import 'dart:convert';

List<StockLogin> stockLoginFromJson(String str) =>
    List<StockLogin>.from(json.decode(str).map((x) => StockLogin.fromJson(x)));

String stockLoginToJson(List<StockLogin> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockLogin {
  StockLogin({
    this.mobile,
    this.pass,
    this.type,
    this.branchid,
  });

  dynamic mobile;
  String pass;
  String type;
  int branchid;

  factory StockLogin.fromJson(Map<String, dynamic> json) => StockLogin(
        mobile: json["mobile"],
        pass: json["pass"],
        type: json["type"],
        branchid: json["branchid"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "pass": pass,
        "type": type,
        "branchid": branchid,
      };
}


//   http://103.87.24.57/stockapi/users/
