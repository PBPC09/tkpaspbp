import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/models/book.dart';
import 'package:lembarpena/AdminRegisterBook/screens/admin_menu.dart';
import 'package:lembarpena/AdminRegisterBook/screens/order_notifications.dart';
import 'package:lembarpena/AdminRegisterBook/widgets/admin_left_drawer.dart';
import 'package:lembarpena/Wishlist/screens/detail_buku.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookCollectionsPage extends StatefulWidget {
  const BookCollectionsPage({super.key});

  @override
  State<StatefulWidget> createState() => _BookCollectionsPageState();
}

class _BookCollectionsPageState extends State<BookCollectionsPage> {
  List<Book> bookList = [];

  Future<List<Book>> fetchBooks() async {
    var url = Uri.parse('http://localhost:8000/registerbook/get-book/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    bookList = [];
    for (var d in data) {
      if (d != null) {
        bookList.add(Book.fromJson(d));
      }
    }
    return bookList;
  }
  // Future<List<Book>> fetchBooks() async {
  //   try {
  //     var url = Uri.parse('http://localhost:8000/registerbook/get-book/');
  //     var response = await http.get(url, headers: {"Content-Type": "application/json"});

  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
  //       return data.map((book) => Book.fromJson(book)).toList();
  //     } else {
  //       // Handle non-200 responses
  //       throw Exception('Failed to load books. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Handle network errors, parsing errors, etc.
  //     throw Exception('Failed to load books: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Collections',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
          future: fetchBooks(),
          builder: (context, AsyncSnapshot<List<Book>> snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return const Column(
                  children: [
                    Text(
                      "Tidak ada data buku.",
                      style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBukuPage(
                            book: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Padding(
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
                                "Author : ${snapshot.data![index].fields.author}"),
                            const SizedBox(height: 10),
                            Text(
                                "Rating : ${snapshot.data![index].fields.rating}"),
                            const SizedBox(height: 10),
                            Text(
                                "Price : ${snapshot.data![index].fields.price} SAR"),
                            const SizedBox(height: 10),
                            Text(
                                "Genre : ${snapshot.data![index].fields.genres}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        backgroundColor: Colors.indigo,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Book Collections',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Order Notifications',
          ),
        ],
        onTap: (index) {
          // Logika untuk mengganti halaman saat tab navigasi diklik
          switch (index) {
            case 0:
              // Navigasi ke Dashboard
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => AdminPage(),
                  transitionDuration: Duration.zero,
                ),
              );
              break;
            case 1:
              // Navigasi ke halaman Books
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const BookCollectionsPage(),
                  transitionDuration: Duration.zero,
                ),
              );
              break;
            case 2:
              // Navigasi ke halaman Notifications
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const NotificationPage(),
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
