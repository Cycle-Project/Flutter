mixin IFriends {
  createSocket();
  disconnect();
  sendFriendRequest({
    required String id,
    required String recipientId,
  });
  respondFriendRequest({
    required String id,
    required String recipientId,
    required String response,
  });
}
