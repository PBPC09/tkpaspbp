import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/models/book.dart';
import 'package:lembarpena/bookforum/screens/forum_page.dart';
import 'package:lembarpena/buybooks/screens/add_to_cart_form.dart';
import 'package:lembarpena/wishlist/screens/explore_book.dart';
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/Main/widgets/left_drawer.dart';
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
  final List<String> ratings = ['All Ratings', '≥ 4.0', '< 4.0'];
  String selectedRating = 'All Ratings';
  List<Book> bookList = [];

  Future<List<Book>> fetchBooks({String? ratingFilter}) async {
    Map<String, String> queryParams = {};
    if (ratingFilter == '≥ 4.0') {
      queryParams['rating_gte'] = '4';
    } else if (ratingFilter == '< 4.0') {
      queryParams['rating_lt'] = '4';
    }

    var uri =
        Uri.http('localhost:8000', '/buybooks/show_books_json/', queryParams);
    var response =
        await http.get(uri, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      return data.map((bookData) => Book.fromJson(bookData)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBooks().then((bookList) {
      setState(() {
        this.bookList = bookList;
      });
    });
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
                color: Colors.white,
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
                  elevation: 0,
                  style: const TextStyle(color: Colors.indigo, fontSize: 16),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRating = newValue!;
                    });
                  },
                  items: ratings.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  dropdownColor: Colors.white,
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
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
              child: const Text(
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Book book = snapshot.data![index];
                      return ListTile(
                        title: Text(book.fields.title),
                        subtitle: Text(
                          "Author: ${book.fields.author}\nRating: ${book.fields.rating}",
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.shopping_cart),
                          color: Colors.blue[400],
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CartFormPage(book: book),
                            ));
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("No books available."));
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
