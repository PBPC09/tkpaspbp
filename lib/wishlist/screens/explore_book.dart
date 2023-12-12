import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lembarpena/Wishlist/models/book.dart';
import 'package:lembarpena/Main/widgets/left_drawer.dart';
import 'package:lembarpena/Wishlist/screens/detail_buku.dart';
import 'package:lembarpena/wishlist/screens/wishlist_form.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';

class ExploreBooksPage extends StatefulWidget {
  const ExploreBooksPage({Key? key}) : super(key: key);

  @override
  _ExploreBooksPageState createState() => _ExploreBooksPageState();
}

class _ExploreBooksPageState extends State<ExploreBooksPage> {
  List<Book> wishlist = [];
  Future<List<Book>> fetchProduct() async {
    var url = Uri.parse('http://localhost:8000/buybooks/show_books_json');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Book> listItem = [];
    for (var d in data) {
      if (d != null) {
        listItem.add(Book.fromJson(d));
      }
    }
    return listItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Books'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
              // if (snapshot.data == null) {
              //   return const Center(child: CircularProgressIndicator());
              // } else {
              if (!snapshot.hasData) {
                return const Column(
                  children: [
                    Text(
                      "Tidak ada data produk.",
                      style: TextStyle(color: Colors.redAccent, fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => InkWell(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data![index].fields.title}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Author: ${snapshot.data![index].fields.author}",
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Rating: ${snapshot.data![index].fields.rating}",
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailBukuPage(
                                          book: snapshot.data![index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text("Show Details"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Handle adding to wishlist logic
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WishlistForm(
                                          book: snapshot.data![index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text("Add To Wishlist"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}
