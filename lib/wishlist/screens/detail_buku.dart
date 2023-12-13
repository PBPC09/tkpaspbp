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
              SizedBox(height: 12),
              Text(
                "Author:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                  height: 4), // Add a smaller space between label and value
              Text(
                book.fields.author,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 12),
              Text(
                "Rating:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                book.fields.rating,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 12),
              Text(
                "Voters:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                book.fields.voters.toString(),
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 12),
              Text(
                "Price:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                "${book.fields.price} SAR",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 12),
              Text(
                "Page Count:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                book.fields.pageCount.toString(),
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 12),
              Text(
                "Publisher:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                book.fields.publisher,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 12),
              Text(
                "Genres:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              // Display genres as a horizontal list
              Row(
                children: book.fields.genres.split(',').map((genre) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.indigo[900],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      genre.trim(),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 12),
              Text(
                "Description:",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                book.fields.description,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
