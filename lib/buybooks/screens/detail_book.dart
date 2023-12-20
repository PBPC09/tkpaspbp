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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Author: ${book.fields.author}'),
            const SizedBox(height: 10),
            Text('Rating: ${book.fields.rating}'),
            const SizedBox(height: 10),
            Text('Voters: ${book.fields.voters}'),
            const SizedBox(height: 10),
            Text('Price: ${book.fields.price}'),
            const SizedBox(height: 10),
            Text('Publisher: ${book.fields.publisher}'),
            const SizedBox(height: 10),
            Text('Page Count: ${book.fields.pageCount}'),
            const SizedBox(height: 10),
            Text('Description: ${book.fields.description}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartFormPage(book: book),
                  ),
                );
              },
              child: const Text('Tambah ke Keranjang'),
            ),
          ],
        ),
      ),
    );
  }
}
