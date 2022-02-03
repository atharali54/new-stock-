// To parse this JSON data, do
//
//     final branchMas = branchMasFromJson(jsonString);

import 'dart:convert';

List<BranchMas> branchMasFromJson(String str) =>
    List<BranchMas>.from(json.decode(str).map((x) => BranchMas.fromJson(x)));

String branchMasToJson(List<BranchMas> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BranchMas {
  BranchMas({
    this.branchName,
    this.branchid,
    this.officeid,
  });

  String branchName;
  int branchid;
  int officeid;

  factory BranchMas.fromJson(Map<String, dynamic> json) => BranchMas(
        branchName: json["branchName"],
        branchid: json["branchid"],
        officeid: json["officeid"],
      );

  Map<String, dynamic> toJson() => {
        "branchName": branchName,
        "branchid": branchid,
        "officeid": officeid,
      };
}
