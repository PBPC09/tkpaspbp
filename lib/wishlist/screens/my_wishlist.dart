import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/models/book.dart';

class WishlistPage extends StatefulWidget {
  final List<Book> wishlist;

  const WishlistPage({Key? key, required this.wishlist}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: widget.wishlist.isEmpty
          ? const Center(
              child: Text('Your wishlist is empty',
                  style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              itemCount: widget.wishlist.length,
              itemBuilder: (context, index) {
                Book book = widget.wishlist[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(book.fields.title),
                    subtitle: Text('Author: ${book.fields.author}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        setState(() {
                          widget.wishlist.remove(book);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
