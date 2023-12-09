import 'package:flutter/material.dart';
import 'package:lembarpena/wishlist/models/book.dart';

class WishlistPage extends StatefulWidget {
  final List<Book> wishlist;

  const WishlistPage({Key? key, required this.wishlist}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: widget.wishlist.length,
        itemBuilder: (context, index) {
          Book book = widget.wishlist[index];

          return ListTile(
            title: Text(book.fields.title),
            subtitle: Text('Author: ${book.fields.author}'),
            trailing: ElevatedButton(
              onPressed: () {
                // Handle remove from wishlist logic
                setState(() {
                  widget.wishlist.remove(book);
                });
              },
              child: const Text('Remove from Wishlist'),
            ),
          );
        },
      ),
    );
  }
}
