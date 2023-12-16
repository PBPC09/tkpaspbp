// To parse this JSON data, do
//
//     final cartItem = cartItemFromJson(jsonString);

import 'dart:convert';
import 'package:lembarpena/AdminRegisterBook/models/book.dart';

List<CartItem> cartItemFromJson(String str) => List<CartItem>.from(json.decode(str).map((x) => CartItem.fromJson(x)));

String cartItemToJson(List<CartItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartItem {
    String model;
    int pk;
    Fields fields;

    CartItem({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
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
    int user;
    int book;
    int quantity;
    bool isOrdered;

    Fields({
        required this.user,
        required this.book,
        required this.quantity,
        required this.isOrdered,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        book: json["book"],
        quantity: json["quantity"],
        isOrdered: json["is_ordered"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "book": book,
        "quantity": quantity,
        "is_ordered": isOrdered,
    };
}