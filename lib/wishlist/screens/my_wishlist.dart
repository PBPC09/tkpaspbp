import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lembarpena/Wishlist/models/book.dart';
import 'package:lembarpena/wishlist/models/wishlist.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<WishlistBook> wishlistBooks = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/wishlist/mywishlist/json/'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        // wishlistBooks = List<WishlistBook>.from(
        //   data['wishlist_books'].map((book) => WishlistBook.fromJson(book)),
        wishlistBooks = Wishlist.fromJson(data).wishlistBooks;
        // );
      });
    } else {
      throw Exception('Failed to load wishlist');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist Saya'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Detail Wishlist',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            // Display the list of books in the wishlist
            Expanded(
              child: ListView.builder(
                itemCount: wishlistBooks.length,
                itemBuilder: (context, index) {
                  final book = wishlistBooks[index];
                  return ListTile(
                    title: Text(book.title),
                    subtitle: Text('Preference: ${book.preference}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
