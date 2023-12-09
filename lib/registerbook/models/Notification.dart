// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

List<Notification> notificationFromJson(String str) => List<Notification>.from(
    json.decode(str).map((x) => Notification.fromJson(x)));

String notificationToJson(List<Notification> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notification {
  Model model;
  int pk;
  Fields fields;

  Notification({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
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
        buyer: json["buyer"],
        message: json["message"],
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
