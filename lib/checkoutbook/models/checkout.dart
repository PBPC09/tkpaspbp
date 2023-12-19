// To parse this JSON data, do
//
//     final checkoutbook = checkoutbookFromJson(jsonString);
// model untuk semua pesanann yang udah dicekout
import 'dart:convert';

List<Checkoutbook> checkoutbookFromJson(String str) => List<Checkoutbook>.from(json.decode(str).map((x) => Checkoutbook.fromJson(x)));

String checkoutbookToJson(List<Checkoutbook> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Checkoutbook {
    String model;
    int pk;
    Fields fields;

    Checkoutbook({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Checkoutbook.fromJson(Map<String, dynamic> json) => Checkoutbook(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String user;
    String alamat;
    String metodePembayaran;
    int totalPrice;

    Fields({
        required this.user,
        required this.alamat,
        required this.metodePembayaran,
        required this.totalPrice,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        alamat: json["alamat"],
        metodePembayaran: json["metode_pembayaran"],
        totalPrice: json["total_price"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "alamat": alamat,
        "metode_pembayaran": metodePembayaran,
        "total_price": totalPrice,
    };
}
