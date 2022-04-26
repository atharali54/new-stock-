// To parse this JSON data, do
//
//     final allStock = allStockFromJson(jsonString);

import 'dart:convert';

List<AllStock> allStockFromJson(String str) =>
    List<AllStock>.from(json.decode(str).map((x) => AllStock.fromJson(x)));

String allStockToJson(List<AllStock> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllStock {
  AllStock({
    this.srno,
    this.stockRegister,
    this.category,
    this.modelno,
    this.serialno,
    this.invoice,
    this.refno,
    this.make,
    this.dop,
    this.dealer,
    this.price,
    this.tehsil,
    this.presentlocation,
    this.installationdate,
    this.remarks,
    this.warrantyPeriod,
    this.amcPeriod,
    this.status,
    this.project,
    this.branchid,
    this.issuedto,
    this.mobile,
  });

  int srno;
  StockRegister stockRegister;
  String category;
  String modelno;
  String serialno;
  String invoice;
  String refno;
  String make;
  String dop;
  String dealer;
  String price;
  String tehsil;
  String presentlocation;
  String installationdate;
  String remarks;
  WarrantyPeriod warrantyPeriod;
  AmcPeriod amcPeriod;
  String status;
  dynamic project;
  int branchid;
  String issuedto;
  String mobile;

  factory AllStock.fromJson(Map<String, dynamic> json) => AllStock(
        srno: json["srno"],
        stockRegister: stockRegisterValues.map[json["stockRegister"]],
        category: json["category"],
        modelno: json["modelno"],
        serialno: json["serialno"],
        invoice: json["invoice"],
        refno: json["refno"],
        make: json["make"],
        dop: json["dop"],
        dealer: json["dealer"],
        price: json["price"],
        tehsil: json["price"],
        // tehsil: tehsilValues.map[json["tehsil"]],
        presentlocation: json["presentlocation"],
        installationdate: json["installationdate"],
        remarks: json["remarks"],
        warrantyPeriod: warrantyPeriodValues.map[json["warrantyPeriod"]],
        amcPeriod: amcPeriodValues.map[json["amcPeriod"]],
        //status: statusValues.map[json["status"]],
        status: json["status"],
        project: json["project"],
        branchid: json["branchid"],
        issuedto: json["issuedto"] == null ? null : json["issuedto"],
        mobile: json["mobile"] == null ? null : json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "srno": srno,
        "stockRegister": stockRegisterValues.reverse[stockRegister],
        "category": category,
        "modelno": modelno,
        "serialno": serialno,
        "invoice": invoice,
        "refno": refno,
        "make": make,
        "dop": dop,
        "dealer": dealer,
        "price": price,
        "tehsil": tehsilValues.reverse[tehsil],
        "presentlocation": presentlocation,
        "installationdate": installationdate,
        "remarks": remarks,
        "warrantyPeriod": warrantyPeriodValues.reverse[warrantyPeriod],
        "amcPeriod": amcPeriodValues.reverse[amcPeriod],
        "status": statusValues.reverse[status],
        "project": project,
        "branchid": branchid,
        "issuedto": issuedto == null ? null : issuedto,
        "mobile": mobile == null ? null : mobile,
      };
}

enum AmcPeriod { NA, EMPTY, NO, AMC_PERIOD_NO, N0, N_A }

final amcPeriodValues = EnumValues({
  "no": AmcPeriod.AMC_PERIOD_NO,
  "": AmcPeriod.EMPTY,
  "N0": AmcPeriod.N0,
  "NA": AmcPeriod.NA,
  "NO": AmcPeriod.NO,
  "N/A": AmcPeriod.N_A
});

enum Status { WORKING, NOT_WORKING }

final statusValues =
    EnumValues({"Not Working": Status.NOT_WORKING, "Working": Status.WORKING});

enum StockRegister { NON_CONSUMABLE, CONSUMABLE }

final stockRegisterValues = EnumValues({
  "Consumable": StockRegister.CONSUMABLE,
  "Non-Consumable": StockRegister.NON_CONSUMABLE
});

enum Tehsil { THANESAR, BABAIN, PEHOWA, LADWA, OTHER, ISMAILABAD, SHAHABAD }

final tehsilValues = EnumValues({
  "Babain": Tehsil.BABAIN,
  "Ismailabad": Tehsil.ISMAILABAD,
  "Ladwa": Tehsil.LADWA,
  "Other": Tehsil.OTHER,
  "Pehowa": Tehsil.PEHOWA,
  "Shahabad": Tehsil.SHAHABAD,
  "Thanesar": Tehsil.THANESAR
});

enum WarrantyPeriod {
  THE_1_YEAR,
  WARRANTY_PERIOD_1_YEAR,
  THE_2_YEAR,
  THE_2_YEAR_1_WEEK,
  THE_3_YEAR,
  THE_2_YEARS,
  WARRANTY_PERIOD_3_YEAR,
  EMPTY,
  THE_3_YEARS,
  THE_03_YEAR,
  WARRANTY_PERIOD_3_YEARS,
  WARRANTY_PERIOD_2_YEAR,
  THE_6_MONTH,
  THE_5_YEAR_ON_SITE,
  PURPLE_1_YEAR,
  THE_1,
  THE_5_YEAR,
  FLUFFY_1_YEAR,
  THE_3_YEAR_BY_OEM,
  TENTACLED_1_YEAR,
  PURPLE_3_YEARS,
  FLUFFY_3_YEARS
}

final warrantyPeriodValues = EnumValues({
  "": WarrantyPeriod.EMPTY,
  "1Year": WarrantyPeriod.FLUFFY_1_YEAR,
  "3 YEARS": WarrantyPeriod.FLUFFY_3_YEARS,
  "1YEAR": WarrantyPeriod.PURPLE_1_YEAR,
  "3YEARS": WarrantyPeriod.PURPLE_3_YEARS,
  "1 YEAR": WarrantyPeriod.TENTACLED_1_YEAR,
  "03 Year": WarrantyPeriod.THE_03_YEAR,
  "1 ": WarrantyPeriod.THE_1,
  "1 year": WarrantyPeriod.THE_1_YEAR,
  "2 Year": WarrantyPeriod.THE_2_YEAR,
  "2 Years": WarrantyPeriod.THE_2_YEARS,
  "2 YEAR+1Week": WarrantyPeriod.THE_2_YEAR_1_WEEK,
  "3 year": WarrantyPeriod.THE_3_YEAR,
  "3 Years": WarrantyPeriod.THE_3_YEARS,
  "3 YEAR by OEM.": WarrantyPeriod.THE_3_YEAR_BY_OEM,
  "5 year": WarrantyPeriod.THE_5_YEAR,
  "5 Year on site": WarrantyPeriod.THE_5_YEAR_ON_SITE,
  "6 Month": WarrantyPeriod.THE_6_MONTH,
  "1 Year": WarrantyPeriod.WARRANTY_PERIOD_1_YEAR,
  "2 year": WarrantyPeriod.WARRANTY_PERIOD_2_YEAR,
  "3 Year": WarrantyPeriod.WARRANTY_PERIOD_3_YEAR,
  "3Years": WarrantyPeriod.WARRANTY_PERIOD_3_YEARS
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
