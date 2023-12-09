// To parse this JSON data, do
//
//     final forumHead = forumHeadFromJson(jsonString);

import 'dart:convert';

List<ForumHead> forumHeadFromJson(String str) => List<ForumHead>.from(json.decode(str).map((x) => ForumHead.fromJson(x)));

String forumHeadToJson(List<ForumHead> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ForumHead {
    String model;
    int pk;
    Fields fields;

    ForumHead({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory ForumHead.fromJson(Map<String, dynamic> json) => ForumHead(
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
    String book;
    String user;
    DateTime date;
    String title;
    String question;
    int commentCounts;
    bool ownedByCurrentUser;

    Fields({
        required this.book,
        required this.user,
        required this.date,
        required this.title,
        required this.question,
        required this.commentCounts,
        required this.ownedByCurrentUser,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        book: json["book"],
        user: json["user"],
        date: DateTime.parse(json["date"]),
        title: json["title"],
        question: json["question"],
        commentCounts: json["comment_counts"],
        ownedByCurrentUser: json["owned_by_current_user"],
    );

    Map<String, dynamic> toJson() => {
        "book": book,
        "user": user,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "title": title,
        "question": question,
        "comment_counts": commentCounts,
        "owned_by_current_user": ownedByCurrentUser,
    };
}
