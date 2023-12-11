import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lembarpena/Wishlist/models/book.dart';

class CreateForumPage extends StatefulWidget {
  const CreateForumPage({Key? key}) : super(key: key);

  @override
  _CreateForumPageState createState() => _CreateForumPageState();
}

class _CreateForumPageState extends State<CreateForumPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title = '';
  String _question = '';
  Book? _selectedBook;
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    var url = Uri.parse('http://127.0.0.1:8000/bookforum/show_books_json/json/');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Book> fetchedBooks = bookFromJson(data);
    setState(() {
      _books = fetchedBooks;
    });
  }

  void createForumHead() {
    Future<void> createForumHead() async {
      var url = Uri.parse('http://127.0.0.1:8000/create_question/');
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          // Jika autentikasi diperlukan, tambahkan header untuk token autentikasi
        },
        body: json.encode({
          'title': _title,
          'book_id': _selectedBook?.pk,  // Pastikan book_id sesuai dengan yang diperlukan oleh server
          'question': _question,
        }),
      );

      if (response.statusCode == 200) {
        // Handle sukses
        // menampilkan pesan sukses atau navigasi ke halaman lain
      } else {
        // Handle error
        // menampilkan pesan error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Forum Baru'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Judul',
                ),
                onSaved: (value) {
                  _title = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<Book>(
                value: _selectedBook,
                onChanged: (Book? newValue) {
                  setState(() {
                    _selectedBook = newValue!;
                  });
                },
                items: _books.map<DropdownMenuItem<Book>>((Book book) {
                  return DropdownMenuItem<Book>(
                    value: book,
                    child: Text("${book.fields.title} oleh ${book.fields.author}"),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Pilih buku' : null,
                decoration: const InputDecoration(
                  labelText: 'Buku',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Pertanyaan',
                ),
                onSaved: (value) {
                  _question = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pertanyaan tidak boleh kosong';
                  }
                  return null;
                },
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    createForumHead();
                  }
                },
                child: const Text('Buat Forum'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
