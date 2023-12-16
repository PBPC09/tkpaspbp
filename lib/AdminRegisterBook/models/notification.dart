// To parse this JSON data, do
//
//     final orderNotifications = orderNotificationsFromJson(jsonString);

import 'dart:convert';

List<OrderNotifications> orderNotificationsFromJson(String str) =>
    List<OrderNotifications>.from(
        json.decode(str).map((x) => OrderNotifications.fromJson(x)));

String orderNotificationsToJson(List<OrderNotifications> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderNotifications {
  Model model;
  int pk;
  Fields fields;

  OrderNotifications({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory OrderNotifications.fromJson(Map<String, dynamic> json) =>
      OrderNotifications(
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
  int buyer;
  String message;
  bool isRead;
  DateTime timestamp;

  Fields({
    required this.buyer,
    required this.message,
    required this.isRead,
    required this.timestamp,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        buyer: json[
            "buyer"], // Directly use the buyer username added in the custom serialization
        message: json['message'],
        isRead: json["is_read"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "buyer": buyer,
        "message": message,
        "is_read": isRead,
        "timestamp": timestamp.toIso8601String(),
      };
}

// ignore: constant_identifier_names
enum Model { REGISTERBOOK_NOTIFICATION }

final modelValues =
    EnumValues({"registerbook.notification": Model.REGISTERBOOK_NOTIFICATION});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
