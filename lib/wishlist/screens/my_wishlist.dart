import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/Authentication/login_page.dart';
import 'dart:convert';
// import 'package:lembarpena/Wishlist/models/book.dart';
import 'package:lembarpena/Wishlist/models/wishlist.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<WishlistBook> wishlist = [];
  late String loggedInUser = LoginPage.uname;

  // @override
  // void initState() {
  //   super.initState();
  //   _futureWishlistBooks = fetchData();
  // }

  Future<List<WishlistBook>> fetchData() async {
    var url = Uri.parse(
        'http://localhost:8000/wishlist/mywishlist/json'); // Sesuaikan dengan URL endpoint Anda
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    wishlist = [];
    for (var d in data) {
      wishlist.add(WishlistBook.fromJson(d));
    }
    return wishlist;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist Saya'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<WishlistBook>>(
          future: fetchData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Tidak ada buku dalam wishlist.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var book = snapshot.data![index];
                  var bookFields = book.fields;

                  // Kembalikan widget yang sesuai dengan data buku
                  return ListTile(
                    title: Text(bookFields.title),
                    subtitle: Text('Seberapa suka: ${bookFields.preference}'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
