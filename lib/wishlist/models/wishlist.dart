// To parse this JSON data, do
//
//     final wishlistBook = wishlistBookFromJson(jsonString);

import 'dart:convert';

List<WishlistBook> wishlistBookFromJson(String str) => List<WishlistBook>.from(
    json.decode(str).map((x) => WishlistBook.fromJson(x)));

String wishlistBookToJson(List<WishlistBook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WishlistBook {
  String model;
  int pk;
  Fields fields;

  WishlistBook({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory WishlistBook.fromJson(Map<String, dynamic> json) => WishlistBook(
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
  String title;
  String preference;
  String user;

  Fields({
    required this.title,
    required this.preference,
    required this.user,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        preference: json["preference"],
        user: json["user"]
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "preference": preference,
        "user" : user,
      };
}
