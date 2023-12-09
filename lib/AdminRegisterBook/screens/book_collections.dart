import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookCollectionsPage extends StatefulWidget {
  const BookCollectionsPage({Key? key}) : super(key: key);

  @override
  _BookCollectionsPageState createState() => _BookCollectionsPageState();
}

class _BookCollectionsPageState extends State<BookCollectionsPage> {
  Future<List<Book>> fetchBooks(request) async {
    var data = await request.get(
        'http://127.0.0.1:8000/get-books/'); // Gantilah dengan URL yang sesuai

    // Melakukan konversi data JSON menjadi objek Book
    List<Book> bookList = [];
    for (var d in data) {
      if (d != null) {
        bookList.add(Book.fromJson(d));
      }
    }
    return bookList;
  }

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
      body: FutureBuilder(
        future: fetchBooks(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(
              child: Text(
                "No books available.",
                style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) => InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         BookDetailsPage(book: snapshot.data[index]),
                  //   ),
                  // );
                },
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${snapshot.data[index].title}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("Author: ${snapshot.data[index].author}"),
                        Text("Genre: ${snapshot.data[index].genre}"),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
