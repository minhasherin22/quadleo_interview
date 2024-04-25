import 'dart:convert';

CustomerDetailsModel customerDetailsModelFromJson(String str) =>
    CustomerDetailsModel.fromJson(json.decode(str));

String customerDetailsModelToJson(CustomerDetailsModel data) =>
    json.encode(data.toJson());

class CustomerDetailsModel {
  String? message;
  bool? status;
  Data? data;

  CustomerDetailsModel({
    this.message,
    this.status,
    this.data,
  });

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) =>
      CustomerDetailsModel(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  int? id;
  String? subscriberId;
  String? lcoNo;
  String? mobile;
  String? countryCode;
  dynamic routeNo;
  String? customerType;
  String? areaName;
  String? status;
  String? currencyCode;
  DateTime? joinDate;
  String? address;
  int? balance;
  int? connections;
  String? name;
  String? customerImage;

  Datum({
    this.id,
    this.subscriberId,
    this.lcoNo,
    this.mobile,
    this.countryCode,
    this.routeNo,
    this.customerType,
    this.areaName,
    this.status,
    this.currencyCode,
    this.joinDate,
    this.address,
    this.balance,
    this.connections,
    this.name,
    this.customerImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        subscriberId: json["subscriber_id"],
        lcoNo: json["lco_no"],
        mobile: json["mobile"],
        countryCode: json["country_code"],
        routeNo: json["route_no"],
        customerType: json["customer_type"],
        areaName: json["area_name"],
        status: json["status"],
        currencyCode: json["currency_code"],
        joinDate: json["join_date"] == null
            ? null
            : DateTime.parse(json["join_date"]),
        address: json["address"],
        balance: json["balance"],
        connections: json["connections"],
        name: json["name"],
        customerImage: json["customer_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subscriber_id": subscriberId,
        "lco_no": lcoNo,
        "mobile": mobile,
        "country_code": countryCode,
        "route_no": routeNo,
        "customer_type": customerType,
        "area_name": areaName,
        "status": status,
        "currency_code": currencyCode,
        "join_date": joinDate?.toIso8601String(),
        "address": address,
        "balance": balance,
        "connections": connections,
        "name": name,
        "customer_image": customerImage,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
