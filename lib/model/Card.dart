// To parse this JSON data, do
//
//     final trelloCard = trelloCardFromJson(jsonString);

import 'dart:convert';

List<TrelloCard> trelloCardFromJson(String str) => List<TrelloCard>.from(json.decode(str).map((x) => TrelloCard.fromJson(x)));

String trelloCardToJson(List<TrelloCard> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrelloCard {
    TrelloCard({
        this.id,
        this.checkItemStates,
        this.closed,
        this.dateLastActivity,
        this.desc,
        this.descData,
        this.dueReminder,
        this.idBoard,
        this.idList,
        this.idMembersVoted,
        this.idShort,
        this.idAttachmentCover,
        this.idLabels,
        this.manualCoverAttachment,
        this.name,
        this.pos,
        this.shortLink,
        this.isTemplate,
        this.cardRole,
        this.badges,
        this.dueComplete,
        this.due,
        this.idChecklists,
        this.idMembers,
        this.labels,
        this.shortUrl,
        this.start,
        this.subscribed,
        this.url,
        this.cover,
    });

    String id;
    dynamic checkItemStates;
    bool closed;
    DateTime dateLastActivity;
    String desc;
    dynamic descData;
    dynamic dueReminder;
    String idBoard;
    String idList;
    List<dynamic> idMembersVoted;
    int idShort;
    dynamic idAttachmentCover;
    List<dynamic> idLabels;
    bool manualCoverAttachment;
    String name;
    int pos;
    String shortLink;
    bool isTemplate;
    dynamic cardRole;
    Badges badges;
    bool dueComplete;
    dynamic due;
    List<dynamic> idChecklists;
    List<dynamic> idMembers;
    List<dynamic> labels;
    String shortUrl;
    dynamic start;
    bool subscribed;
    String url;
    Cover cover;

    factory TrelloCard.fromJson(Map<String, dynamic> json) => TrelloCard(
        id: json["id"],
        checkItemStates: json["checkItemStates"],
        closed: json["closed"],
        dateLastActivity: DateTime.parse(json["dateLastActivity"]),
        desc: json["desc"],
        descData: json["descData"],
        dueReminder: json["dueReminder"],
        idBoard: json["idBoard"],
        idList: json["idList"],
        idMembersVoted: List<dynamic>.from(json["idMembersVoted"].map((x) => x)),
        idShort: json["idShort"],
        idAttachmentCover: json["idAttachmentCover"],
        idLabels: List<dynamic>.from(json["idLabels"].map((x) => x)),
        manualCoverAttachment: json["manualCoverAttachment"],
        name: json["name"],
        pos: json["pos"],
        shortLink: json["shortLink"],
        isTemplate: json["isTemplate"],
        cardRole: json["cardRole"],
        badges: Badges.fromJson(json["badges"]),
        dueComplete: json["dueComplete"],
        due: json["due"],
        idChecklists: List<dynamic>.from(json["idChecklists"].map((x) => x)),
        idMembers: List<dynamic>.from(json["idMembers"].map((x) => x)),
        labels: List<dynamic>.from(json["labels"].map((x) => x)),
        shortUrl: json["shortUrl"],
        start: json["start"],
        subscribed: json["subscribed"],
        url: json["url"],
        cover: Cover.fromJson(json["cover"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "checkItemStates": checkItemStates,
        "closed": closed,
        "dateLastActivity": dateLastActivity.toIso8601String(),
        "desc": desc,
        "descData": descData,
        "dueReminder": dueReminder,
        "idBoard": idBoard,
        "idList": idList,
        "idMembersVoted": List<dynamic>.from(idMembersVoted.map((x) => x)),
        "idShort": idShort,
        "idAttachmentCover": idAttachmentCover,
        "idLabels": List<dynamic>.from(idLabels.map((x) => x)),
        "manualCoverAttachment": manualCoverAttachment,
        "name": name,
        "pos": pos,
        "shortLink": shortLink,
        "isTemplate": isTemplate,
        "cardRole": cardRole,
        "badges": badges.toJson(),
        "dueComplete": dueComplete,
        "due": due,
        "idChecklists": List<dynamic>.from(idChecklists.map((x) => x)),
        "idMembers": List<dynamic>.from(idMembers.map((x) => x)),
        "labels": List<dynamic>.from(labels.map((x) => x)),
        "shortUrl": shortUrl,
        "start": start,
        "subscribed": subscribed,
        "url": url,
        "cover": cover.toJson(),
    };
}

class Badges {
    Badges({
        this.attachmentsByType,
        this.location,
        this.votes,
        this.viewingMemberVoted,
        this.subscribed,
        this.fogbugz,
        this.checkItems,
        this.checkItemsChecked,
        this.checkItemsEarliestDue,
        this.comments,
        this.attachments,
        this.description,
        this.due,
        this.dueComplete,
        this.start,
    });

    AttachmentsByType attachmentsByType;
    bool location;
    int votes;
    bool viewingMemberVoted;
    bool subscribed;
    String fogbugz;
    int checkItems;
    int checkItemsChecked;
    dynamic checkItemsEarliestDue;
    int comments;
    int attachments;
    bool description;
    dynamic due;
    bool dueComplete;
    dynamic start;

    factory Badges.fromJson(Map<String, dynamic> json) => Badges(
        attachmentsByType: AttachmentsByType.fromJson(json["attachmentsByType"]),
        location: json["location"],
        votes: json["votes"],
        viewingMemberVoted: json["viewingMemberVoted"],
        subscribed: json["subscribed"],
        fogbugz: json["fogbugz"],
        checkItems: json["checkItems"],
        checkItemsChecked: json["checkItemsChecked"],
        checkItemsEarliestDue: json["checkItemsEarliestDue"],
        comments: json["comments"],
        attachments: json["attachments"],
        description: json["description"],
        due: json["due"],
        dueComplete: json["dueComplete"],
        start: json["start"],
    );

    Map<String, dynamic> toJson() => {
        "attachmentsByType": attachmentsByType.toJson(),
        "location": location,
        "votes": votes,
        "viewingMemberVoted": viewingMemberVoted,
        "subscribed": subscribed,
        "fogbugz": fogbugz,
        "checkItems": checkItems,
        "checkItemsChecked": checkItemsChecked,
        "checkItemsEarliestDue": checkItemsEarliestDue,
        "comments": comments,
        "attachments": attachments,
        "description": description,
        "due": due,
        "dueComplete": dueComplete,
        "start": start,
    };
}

class AttachmentsByType {
    AttachmentsByType({
        this.trello,
    });

    Trello trello;

    factory AttachmentsByType.fromJson(Map<String, dynamic> json) => AttachmentsByType(
        trello: Trello.fromJson(json["trello"]),
    );

    Map<String, dynamic> toJson() => {
        "trello": trello.toJson(),
    };
}

class Trello {
    Trello({
        this.board,
        this.card,
    });

    int board;
    int card;

    factory Trello.fromJson(Map<String, dynamic> json) => Trello(
        board: json["board"],
        card: json["card"],
    );

    Map<String, dynamic> toJson() => {
        "board": board,
        "card": card,
    };
}

class Cover {
    Cover({
        this.idAttachment,
        this.color,
        this.idUploadedBackground,
        this.size,
        this.brightness,
        this.idPlugin,
    });

    dynamic idAttachment;
    dynamic color;
    dynamic idUploadedBackground;
    String size;
    String brightness;
    dynamic idPlugin;

    factory Cover.fromJson(Map<String, dynamic> json) => Cover(
        idAttachment: json["idAttachment"],
        color: json["color"],
        idUploadedBackground: json["idUploadedBackground"],
        size: json["size"],
        brightness: json["brightness"],
        idPlugin: json["idPlugin"],
    );

    Map<String, dynamic> toJson() => {
        "idAttachment": idAttachment,
        "color": color,
        "idUploadedBackground": idUploadedBackground,
        "size": size,
        "brightness": brightness,
        "idPlugin": idPlugin,
    };
}
