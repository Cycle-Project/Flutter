import 'package:flutter/material.dart';
import 'package:geo_app/Client/client_constants.dart';
import 'package:geo_app/WebSocket/friends_interface.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class FriendsController extends ChangeNotifier with IFriends {
  late io.Socket socket;
  Map<String, dynamic> friendRequests = {
    "count": 0,
    "senders": [],
  };

  Map<String, dynamic>? responsedRequest;

  FriendsController() {
    createSocket();
  }

  @override
  createSocket({String? url}) {
    // Initialize socket
    socket = io.io(ClientConstants.url, <String, dynamic>{
      'transports': ['websocket'],
    });
    // Get room Id
    socket.on('take-friend-request', (data) {
      friendRequests = {
        "count": data['count'],
        "senders": data['senders'],
      };
      notifyListeners();
    });

    // Listen for game state updates
    socket.on('friend-request-response', (data) {
      responsedRequest = {
        "sender": data['sender'],
        "response": data['response'],
      };
      notifyListeners();
    });
  }

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
