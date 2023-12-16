import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/models/book.dart';
import 'package:lembarpena/bookforum/screens/forum_page.dart';
import 'package:lembarpena/wishlist/screens/explore_book.dart';
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/Main/widgets/left_drawer.dart';
import 'package:lembarpena/buybooks/screens/detail_book.dart'; // Import your book detail page here
import 'package:lembarpena/buybooks/screens/cart_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BuyBooksPage extends StatefulWidget {
  const BuyBooksPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BuyBooksPageState createState() => _BuyBooksPageState();
}

class _BuyBooksPageState extends State<BuyBooksPage> {
  List<Book> bookList = [];
  String selectedRating = 'All Ratings';
  final Map<String, String> ratingFilterMap = {
    'All Ratings': 'all',
    '> 4.0': 'gt4',
    '≤ 4.0': 'lte4',
  };

  Future<List<Book>> fetchBooks({String? ratingFilter}) async {
    Map<String, String> queryParams = {};
    if (ratingFilter != null && ratingFilterMap[ratingFilter] != 'all') {
      queryParams['rating_filter'] = ratingFilterMap[ratingFilter]!;
    }

    var uri =
        Uri.http('localhost:8000', '/registerbook/get-book/', queryParams);
    var response =
        await http.get(uri, headers: {"Content-Type": "application/json"});

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    return List<Book>.from(data.map((bookData) => Book.fromJson(bookData)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Books',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white, // Ensuring the background is white
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                    color: Colors.indigo,
                    style: BorderStyle.solid,
                    width: 0.80),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedRating,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.indigo),
                  iconSize: 24,
                  elevation: 0, // Removes elevation and shadow
                  style: const TextStyle(color: Colors.indigo, fontSize: 16),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRating = newValue!;
                    });
                  },
                  items: ratingFilterMap.keys
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  dropdownColor: Colors.white, // Dropdown background color
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CartPage()),
                );
              },
              child: Text(
                'Cek Keranjang Saya',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Book>>(
              future: fetchBooks(ratingFilter: selectedRating),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
                bookList = snapshot.data!;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text("Error: ${snapshot.error.toString()}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No books available."));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Book book = snapshot.data![index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(book.fields.title),
                          subtitle: Text(
                            "Author: ${book.fields.author}\nRating: ${book.fields.rating}",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.shopping_cart),
                                color: Colors.blue[400],
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ItemDetailPage(book: book),
                                  ));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        backgroundColor: Colors.indigo,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 156, 143, 255),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Ganti dengan path gambar yang sesuai
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search), // Ganti dengan path gambar yang sesuai
            label: 'Explore Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum), // Ganti dengan path gambar yang sesuai
            label: 'Book Forum',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => MyHomePage(),
                  transitionDuration: Duration.zero,
                ),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ExploreBooksPage(),
                  transitionDuration: Duration.zero,
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ForumPage(),
                  transitionDuration: Duration.zero,
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
