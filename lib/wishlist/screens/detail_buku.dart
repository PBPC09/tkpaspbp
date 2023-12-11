import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/models/book.dart';

class DetailBukuPage extends StatelessWidget {
  final Book book;

  const DetailBukuPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.fields.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text("Author: ${book.fields.author}"),
            const SizedBox(height: 10),
            Text("Rating: ${book.fields.rating}"),
            const SizedBox(height: 10),
            Text("Voters: ${book.fields.voters}"),
            const SizedBox(height: 10),
            Text("Price: ${book.fields.price} SAR"),
            const SizedBox(height: 10),
            Text("Page Count: ${book.fields.pageCount}"),
            const SizedBox(height: 10),
            Text("Publisher: ${book.fields.publisher}"),
            const SizedBox(height: 10),
            Text("Genres: ${book.fields.genres}"),
            const SizedBox(height: 10),
            Text("Description: ${book.fields.description}"),
          ],
        ),
      ),
    );
  }
}
