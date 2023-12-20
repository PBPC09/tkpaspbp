//import 'dart:convert';

class SelectedBook {
  final int id;
  final String title;
  final String author;
  final double price;
  final String imageUrl;
  bool isSelected;

  SelectedBook({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.imageUrl,
    this.isSelected = false,
  });

  factory SelectedBook.fromJson(Map<String, dynamic> json) => SelectedBook(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        price: json["price"].toDouble(),
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "price": price,
        "imageUrl": imageUrl,
      };
}

SelectedBook selectedBookFromJson(Map<String, dynamic> json) => SelectedBook(
      id: json["id"],
      title: json["title"],
      author: json["author"],
      price: json["price"].toDouble(),
      imageUrl: json["imageUrl"],
);

Map<String, dynamic> selectedBookToJson(SelectedBook book) => {
      "id": book.id,
      "title": book.title,
      "author": book.author,
      "price": book.price,
      "imageUrl": book.imageUrl,
    };
