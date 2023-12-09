// To parse this JSON data, do
//
//     final forumComment = forumCommentFromJson(jsonString);

import 'dart:convert';

List<ForumComment> forumCommentFromJson(String str) => List<ForumComment>.from(json.decode(str).map((x) => ForumComment.fromJson(x)));

String forumCommentToJson(List<ForumComment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ForumComment {
    String model;
    int pk;
    Fields fields;

    ForumComment({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory ForumComment.fromJson(Map<String, dynamic> json) => ForumComment(
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
    int commentTo;
    DateTime date;
    String answer;

    Fields({
        required this.user,
        required this.commentTo,
        required this.date,
        required this.answer,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        commentTo: json["comment_to"],
        date: DateTime.parse(json["date"]),
        answer: json["answer"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "comment_to": commentTo,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "answer": answer,
    };
}
