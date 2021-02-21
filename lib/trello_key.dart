final treloKey = "b7d537d8f39bba81017a62ce96f28509";
final token =
    "e9f409a72abe93d42ebaee1a93638c94c46a00a70565f10219a358416b51d8e5";

final boardId = "qEKBMl2W";

String get trelloApiAccess =>
    'https://api.trello.com/1/members/me/boards/?key=$treloKey&token=$token';

String get trelloApiBoard =>
    'https://api.trello.com/1/boards/$boardId?key=$treloKey&token=$token';

String get trelloApiList =>
    'https://api.trello.com/1/boards/$boardId/lists?key=$treloKey&token=$token';

// String get trelloApiCard =>
//     'https://api.trello.com/1/boards/$boardId/cards?key=$treloKey&token=$token';

String trelloApiCard(String id) {
  return "https://api.trello.com/1/lists/$id/cards?key=$treloKey&token=$token";
}

String trelloPostCard({String id}) {
  // https://api.trello.com/1/cards/{id}
  return id == null
      ? "https://api.trello.com/1/cards?key=$treloKey&token=$token"
      : "https://api.trello.com/1/cards/$id?key=$treloKey&token=$token";
}

// https://api.trello.com/1/cards?key=0471642aefef5fa1fa76530ce1ba4c85&token=9eb76d9a9d02b8dd40c2f3e5df18556c831d4d1fadbe2c45f8310e6c93b5c548&idList=5abbe4b7ddc1b351ef961414
// https://api.trello.com/1/lists/{id}/cards?key=0471642aefef5fa1fa76530ce1ba4c85&token=9eb76d9a9d02b8dd40c2f3e5df18556c831d4d1fadbe2c45f8310e6c93b5c548
