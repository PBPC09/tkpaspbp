// RAW TEMPLATE FROM JESHUAMART

// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<ForumHead> productFromJson(String str) => List<ForumHead>.from(json.decode(str).map((x) => ForumHead.fromJson(x)));

String productToJson(List<ForumHead> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ForumHead {
    Model model;
    int pk;
    Fields fields;

    ForumHead({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory ForumHead.fromJson(Map<String, dynamic> json) => ForumHead(
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
    String name;
    int amount;
    int price;
    String description;
    DateTime dateIn;
    bool stock;
    String categories;

    Fields({
        required this.user,
        required this.name,
        required this.amount,
        required this.price,
        required this.description,
        required this.dateIn,
        required this.stock,
        required this.categories,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        amount: json["amount"],
        price: json["price"],
        description: json["description"],
        dateIn: DateTime.parse(json["date_in"]),
        stock: json["stock"],
        categories: json["categories"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "amount": amount,
        "price": price,
        "description": description,
        "date_in": "${dateIn.year.toString().padLeft(4, '0')}-${dateIn.month.toString().padLeft(2, '0')}-${dateIn.day.toString().padLeft(2, '0')}",
        "stock": stock,
        "categories": categories,
    };
}

enum Model {
    // ignore: constant_identifier_names
    MAIN_PRODUCT
}

final modelValues = EnumValues({
    "main.product": Model.MAIN_PRODUCT
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
