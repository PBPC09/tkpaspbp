import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/models/book.dart';
import 'package:lembarpena/buybooks/screens/add_to_cart_form.dart';

class ItemDetailPage extends StatelessWidget {
  final Book book;

  const ItemDetailPage({Key? key, required this.book}) : super(key: key);

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
            Text(
              'Name: ${book.fields.title}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Author: ${book.fields.author}'),
            SizedBox(height: 10),
            Text('Rating: ${book.fields.rating}'),
            SizedBox(height: 10),
            Text('Voters: ${book.fields.voters}'),
            SizedBox(height: 10),
            Text('Price: ${book.fields.price}'),
            SizedBox(height: 10),
            Text('Publisher: ${book.fields.publisher}'),
            SizedBox(height: 10),
            Text('Page Count: ${book.fields.pageCount}'),
            SizedBox(height: 10),
            Text('Description: ${book.fields.description}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartFormPage(book: book),
                  ),
                );
              },
              child: Text('Tambah ke Keranjang'),
            ),
          ],
        ),
      ),
    );
  }
}
