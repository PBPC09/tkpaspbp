// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Model model;
  int pk;
  Fields fields;

  Order({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  String alamat;
  MetodePembayaran metodePembayaran;
  int totalPrice;
  List<dynamic> items;

  Fields({
    required this.user,
    required this.alamat,
    required this.metodePembayaran,
    required this.totalPrice,
    required this.items,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        alamat: json["alamat"],
        metodePembayaran:
            metodePembayaranValues.map[json["metode_pembayaran"]]!,
        totalPrice: json["total_price"],
        items: List<dynamic>.from(json["items"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "alamat": alamat,
        "metode_pembayaran": metodePembayaranValues.reverse[metodePembayaran],
        "total_price": totalPrice,
        "items": List<dynamic>.from(items.map((x) => x)),
      };
}

// ignore: constant_identifier_names
enum MetodePembayaran { E_WALLET, KARTU_DEBIT, KARTU_KREDIT, TRANSFER_BANK }

final metodePembayaranValues = EnumValues({
  "E-Wallet": MetodePembayaran.E_WALLET,
  "Kartu Debit": MetodePembayaran.KARTU_DEBIT,
  "Kartu Kredit": MetodePembayaran.KARTU_KREDIT,
  "Transfer Bank": MetodePembayaran.TRANSFER_BANK
});

// ignore: constant_identifier_names
enum Model { CHECKOUTBOOK_CHECKOUT }

final modelValues =
    EnumValues({"checkoutbook.checkout": Model.CHECKOUTBOOK_CHECKOUT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
