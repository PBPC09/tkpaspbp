// To parse this JSON data, do
//
//     final cartItem = cartItemFromJson(jsonString);

import 'dart:convert';

List<CartItem> cartItemFromJson(String str) =>
    List<CartItem>.from(json.decode(str).map((x) => CartItem.fromJson(x)));

String cartItemToJson(List<CartItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartItem {
  int id;
  String title;
  int quantity;
  String subtotal;
  String currency;
  bool isSelected;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.subtotal,
    required this.currency,
    required this.isSelected,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
<<<<<<< HEAD
      id: json["id"],
      title: json["title"],
      quantity: json["quantity"],
      subtotal: json["subtotal"],
      currency: json["currency"],
      isSelected: json["is_ordered"]);
=======
        id: json["id"],
        title: json["title"],
        quantity: json["quantity"],
        subtotal: json["subtotal"],
        currency: json["currency"],
        isSelected: json["is_ordered"]
      );
>>>>>>> 273332b4a49442091214b79e7554aba2cebfbeac

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "quantity": quantity,
        "subtotal": subtotal,
        "currency": currency,
<<<<<<< HEAD
        "is_ordered": isSelected,
=======
        "is_ordered":isSelected,
>>>>>>> 273332b4a49442091214b79e7554aba2cebfbeac
      };
}
