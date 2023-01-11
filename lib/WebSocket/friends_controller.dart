import 'package:flutter/material.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Client/client_constants.dart';
import 'package:geo_app/WebSocket/friends_interface.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class FriendRequests {
  int count;
  List<String> senders;

  FriendRequests({this.count = 0, this.senders = const []});

  factory FriendRequests.fromJson(Map json) => FriendRequests(
        count: json['count'] ?? 0,
        senders: json['senders']?.cast<String>() ?? [],
      );
}

class FriendRequestResponse {
  String? sender;
  String? response;

  FriendRequestResponse({this.sender, this.response});

  FriendRequestResponse.fromJson(Map json) {
    sender = json['sender'];
    response = json['response'];
  }
}

class FriendsController extends ChangeNotifier with IFriends {
  late io.Socket socket;
  late FriendRequests friendRequests;
  late FriendRequestResponse responsedRequest;

  FriendsController() {
    createSocket();
    friendRequests = FriendRequests();
    responsedRequest = FriendRequestResponse();
  }

  @override
  createSocket() async {
    String? token = await CacheManager.getSharedPref(tag: "user_token");
    // Initialize socket
    //'http://localhost:3000'
    //ClientConstants.baseUrl
    socket = io.io(ClientConstants.baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'query': {'token': token},
    });

    print("Socket created");
    // Get room Id
    socket.on('take-friend-request', (data) {
      friendRequests = FriendRequests.fromJson(data);
      print('take-friend-request ${friendRequests.count}');
      notifyListeners();
    });

    // Listen for game state updates
    socket.on('friend-request-response', (data) {
      responsedRequest = FriendRequestResponse.fromJson(data);
      print('friend-request-response ${responsedRequest.sender}');
      notifyListeners();
    });
  }

//yahya@gmail.com
  @override
  disconnect() {
    socket.emit('disconnect');
    socket.disconnect();
  }

  @override
  respondFriendRequest({
    required String id,
    required String recipientId,
    required String response,
  }) =>
      socket.emit('respond-friend-request', [recipientId, id, response]);

  @override
  sendFriendRequest({
    required String id,
    required String recipientId,
  }) =>
      socket.emit('send-friend-request', [id, recipientId]);
}
