// To parse this JSON data, do
//
//     final officeMas = officeMasFromJson(jsonString);

import 'dart:convert';

List<OfficeMas> officeMasFromJson(String str) =>
    List<OfficeMas>.from(json.decode(str).map((x) => OfficeMas.fromJson(x)));

String officeMasToJson(List<OfficeMas> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OfficeMas {
  OfficeMas({
    this.officeName,
    this.officeid,
  });

  String officeName;
  int officeid;

  factory OfficeMas.fromJson(Map<String, dynamic> json) => OfficeMas(
        officeName: json["officeName"],
        officeid: json["officeid"],
      );

  Map<String, dynamic> toJson() => {
        "officeName": officeName,
        "officeid": officeid,
      };
}
