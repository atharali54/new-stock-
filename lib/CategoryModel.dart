// To parse this JSON data, do
//
//     final stockCat = stockCatFromJson(jsonString);

import 'dart:convert';

List<StockCat> stockCatFromJson(String str) =>
    List<StockCat>.from(json.decode(str).map((x) => StockCat.fromJson(x)));

String stockCatToJson(List<StockCat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockCat {
  StockCat({
    this.category,
    this.total,
  });

  String category;
  int total;

  factory StockCat.fromJson(Map<String, dynamic> json) => StockCat(
        category: json["category"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "total": total,
      };
}
