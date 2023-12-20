import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/models/book.dart'; // Make sure to use the correct path
import 'package:lembarpena/AdminRegisterBook/screens/admin_menu.dart';
import 'package:lembarpena/AdminRegisterBook/screens/order_notifications.dart';
import 'package:lembarpena/AdminRegisterBook/widgets/admin_left_drawer.dart';
import 'package:lembarpena/wishlist/screens/detail_buku.dart'; // Import your book detail page here
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookCollectionsPage extends StatefulWidget {
  const BookCollectionsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookCollectionsPageState createState() => _BookCollectionsPageState();
}

class _BookCollectionsPageState extends State<BookCollectionsPage> {
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

    String baseUrl = 'https://lembarpena-c09-tk.pbp.cs.ui.ac.id';
    String path = '/registerbook/get-book/';
    String queryString = Uri(queryParameters: queryParams).query;

    final response = await http.get(Uri.parse('$baseUrl$path?$queryString'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return List<Book>.from(data.map((bookData) => Book.fromJson(bookData)));
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<void> deleteBook(int bookId) async {
    final url = Uri.parse(
        'https://lembarpena-c09-tk.pbp.cs.ui.ac.id/registerbook/delete-book-ajax/$bookId/');

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      setState(() {});
    } else {
      throw Exception('Failed to delete the book.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final request = context.watch<CookieRequest>();
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
          Expanded(
            child: FutureBuilder<List<Book>>(
              future: fetchBooks(ratingFilter: selectedRating),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
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
                                icon: const Icon(Icons.info_outlined),
                                color: Colors.blue[400],
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        DetailBukuPage(book: book),
                                  ));
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  deleteBook(snapshot.data![index].pk)
                                      .catchError((error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Error deleting book: $error")),
                                    );
                                  });
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
            label: 'Notifications',
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
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        AdminPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ));
              break;
            case 1:
              // Navigasi ke halaman Books
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const BookCollectionsPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ));
              break;
            case 2:
              // Navigasi ke halaman Notifications
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const NotificationPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ));
              break;
          }
        },
      ),
    );
  }
}
