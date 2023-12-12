// To parse this JSON data, do
//
//     final wishlist = wishlistFromJson(jsonString);

import 'dart:convert';

Wishlist wishlistFromJson(String str) => Wishlist.fromJson(json.decode(str));

String wishlistToJson(Wishlist data) => json.encode(data.toJson());

class Wishlist {
    List<WishlistBook> wishlistBooks;

    Wishlist({
        required this.wishlistBooks,
    });

    factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        wishlistBooks: List<WishlistBook>.from(json["wishlist_books"].map((x) => WishlistBook.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "wishlist_books": List<dynamic>.from(wishlistBooks.map((x) => x.toJson())),
    };
}

class WishlistBook {
    String title;
    String preference;

    WishlistBook({
        required this.title,
        required this.preference,
    });

    factory WishlistBook.fromJson(Map<String, dynamic> json) => WishlistBook(
        title: json["title"],
        preference: json["preference"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "preference": preference,
    };
}
