import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/models/book.dart';

class DetailBukuPage extends StatelessWidget {
  final Book book;

  const DetailBukuPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.fields.title,
        ),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const Text(
                "Author:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                  height: 4), // Add a smaller space between label and value
              Text(
                book.fields.author,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              const Text(
                "Rating:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                book.fields.rating,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              const Text(
                "Voters:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                book.fields.voters.toString(),
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              const Text(
                "Price:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                "${book.fields.price} SAR",
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              const Text(
                "Page Count:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                book.fields.pageCount.toString(),
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              const Text(
                "Publisher:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                book.fields.publisher,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              const Text(
                "Genres:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              // Display genres as a horizontal list
              Row(
                children: book.fields.genres.split(',').map((genre) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.indigo[900],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      genre.trim(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              const Text(
                "Description:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                book.fields.description,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}