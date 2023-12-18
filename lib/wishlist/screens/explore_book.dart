import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/bookforum/screens/forum_page.dart';
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/Main/widgets/left_drawer.dart';
import 'package:lembarpena/AdminRegisterBook/models/book.dart';
import 'package:lembarpena/wishlist/screens/detail_buku.dart';
import 'package:lembarpena/authentication/login_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ExploreBooksPage extends StatefulWidget {
  const ExploreBooksPage({Key? key}) : super(key: key);

  @override
  _ExploreBooksPageState createState() => _ExploreBooksPageState();
}

class _ExploreBooksPageState extends State<ExploreBooksPage> {
  List<Book> books = [];
  Set<int> wishlistBookIds = {};
  String selectedRating =
      'All Ratings'; // State untuk menyimpan rating yang dipilih
  String uname = LoginPage.uname;

  @override
  void initState() {
    super.initState();
    fetchBooks(selectedRating); // Panggil dengan rating awal
    fetchWishlist();
  }

  Future<void> fetchBooks(String rating) async {
    String ratingQuery = rating != 'All Ratings' ? '&rating=$rating' : '';
    var url = Uri.parse(
        'http://localhost:8000/buybooks/show_books_json/?rating=$ratingQuery');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    setState(() {
      books = List<Book>.from(data.map((x) => Book.fromJson(x)));
    });
  }

  Future<void> fetchWishlist() async {
    var url = Uri.parse('http://localhost:8000/wishlist/mywishlist/json');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    setState(() {
      wishlistBookIds = Set<int>.from(data.map((x) => x['pk']));
    });
  }

  Future<void> addToWishlist(int bookId, int preference, request) async {
    // print(bookId);
    final response = await request.postJson(
                    "http://localhost:8000/wishlist/add_to_wishlist_flutter/",
                      jsonEncode({
                        'book_id': bookId, 
                        'preference': preference, 
                        // 'user_id': uname,
                      }),
                    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        setState(() {
          wishlistBookIds.add(bookId);
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error adding book to wishlist')));
    }
  }

  void showPreferenceDialog(int bookId, request) async {
    int? preference = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('How much do you like this book?'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 1);
              },
              child: const Text('Not Interested'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 2);
              },
              child: const Text('Maybe Later'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 3);
              },
              child: const Text('Interested'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 4);
              },
              child: const Text('Really Want It'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 5);
              },
              child: const Text('Must Have'),
            ),
          ],
        );
      },
    );

    if (preference != null) {
      // print(bookId);
      addToWishlist(bookId, preference, request);
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo[900],
      ),
      drawer: const LeftDrawer(),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (_, index) {
          Book book = books[index];
          bool isInWishlist = wishlistBookIds.contains(book.pk);
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.fields.title,
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("Author: ${book.fields.author}"),
                  const SizedBox(height: 8),
                  Text("Rating: ${book.fields.rating}"),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        color: Colors.blue[400],
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailBukuPage(book: book),
                          ));
                        },
                      ),
                      IconButton(
                        icon: Icon(isInWishlist
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: isInWishlist ? Colors.red : Colors.grey,
                        onPressed: () {
                          if (!isInWishlist) {
                            // print(book.pk);
                            showPreferenceDialog(book.pk, request);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Buku sudah ada dalam wishlist.')));
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        backgroundColor: Colors.indigo,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 156, 143, 255),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
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