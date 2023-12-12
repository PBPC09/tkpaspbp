// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    Model model;
    int pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

  get isInWishlist => null;

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String title;
    String author;
    String rating;
    int voters;
    String price;
    String currency;
    String description;
    String publisher;
    int pageCount;
    String genres;

    Fields({
        required this.title,
        required this.author,
        required this.rating,
        required this.voters,
        required this.price,
        required this.currency,
        required this.description,
        required this.publisher,
        required this.pageCount,
        required this.genres,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        author: json["author"],
        rating: json["rating"],
        voters: json["voters"],
        price: json["price"],
        currency: json["currency"],
        description: json["description"],
        publisher: json["publisher"],
        pageCount: json["page_count"],
        genres: json["genres"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "rating": rating,
        "voters": voters,
        "price": price,
        "currency": currencyValues.reverse[currency],
        "description": description,
        "publisher": publisher,
        "page_count": pageCount,
        "genres": genres,
    };
}

enum Currency {
    FREE,
    SAR
}

final currencyValues = EnumValues({
    "Free": Currency.FREE,
    "SAR": Currency.SAR
});

enum Model {
    REGISTERBOOK_BOOK
}

final modelValues = EnumValues({
    "registerbook.book": Model.REGISTERBOOK_BOOK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
