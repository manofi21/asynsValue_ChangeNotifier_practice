// To parse this JSON data, do
//
//     final trelloList = trelloListFromJson(jsonString);

import 'dart:convert';

List<TrelloList> trelloListFromJson(String str) => List<TrelloList>.from(json.decode(str).map((x) => TrelloList.fromJson(x)));

String trelloListToJson(List<TrelloList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrelloList {
    TrelloList({
        this.id,
        this.name,
        this.closed,
        this.pos,
        this.softLimit,
        this.idBoard,
        this.subscribed,
    });

    String id;
    String name;
    bool closed;
    int pos;
    dynamic softLimit;
    String idBoard;
    bool subscribed;

    factory TrelloList.fromJson(Map<String, dynamic> json) => TrelloList(
        id: json["id"],
        name: json["name"],
        closed: json["closed"],
        pos: json["pos"],
        softLimit: json["softLimit"],
        idBoard: json["idBoard"],
        subscribed: json["subscribed"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "closed": closed,
        "pos": pos,
        "softLimit": softLimit,
        "idBoard": idBoard,
        "subscribed": subscribed,
    };
}
