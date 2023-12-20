import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/bookforum/screens/forum_page.dart';
import 'dart:convert';
import 'package:lembarpena/AdminRegisterBook/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CreateForumPage extends StatefulWidget {
  const CreateForumPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
    fetchBooks().then((books) {
      setState(() {
        _books = books;
      });
    });
  }

  Future<List<Book>> fetchBooks() async {
    // var url = Uri.parse('http://10.0.2.2:8000/buybooks/show_books_json');
    var url = Uri.parse(
        'https://lembarpena-c09-tk.pbp.cs.ui.ac.id/buybooks/show_books_json/');
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
    final request = context.watch<CookieRequest>();
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
                isExpanded: true,
                onChanged: (Book? newValue) {
                  setState(() {
                    _selectedBook = newValue!;
                  });
                },
                items: _books.map<DropdownMenuItem<Book>>((Book book) {
                  return DropdownMenuItem<Book>(
                    value: book,
                    child: Container(
                      width: 400,
                      padding: const EdgeInsets.all(
                          8.0), // Menambahkan padding di dalam border
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors
                              .grey, // Warna border, sesuaikan sesuai kebutuhan
                          width: 1.0, // Ketebalan border
                        ),
                        borderRadius: BorderRadius.circular(
                            5.0), // Memberikan sudut yang membulat
                      ),
                      child: Column(
                        children: [
                          Text(
                              "${book.fields.title} oleh ${book.fields.author}"),
                          Text(
                              "Rating ${book.fields.rating} - SAR ${book.fields.price} "),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                selectedItemBuilder: (BuildContext context) {
                  return _books.map<Widget>((Book book) {
                    return Text(
                      "${book.fields.title} oleh ${book.fields.author}",
                      overflow: TextOverflow.ellipsis, // Menambahkan ellipsis
                      maxLines: 1,
                    );
                  }).toList();
                },
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
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final response = await request.postJson(
                      // "http://10.0.2.2:8000/bookforum/create_question_flutter/",
                      "https://lembarpena-c09-tk.pbp.cs.ui.ac.id/bookforum/create_question_flutter/",
                      jsonEncode({
                        "question": _question,
                        "book_id": _selectedBook?.pk,
                        "title": _title,
                      }),
                    );

                    // Periksa kode status HTTP dari respons
                    if (response['status'] == 'success') {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Komentar berhasil ditambahkan!"),
                        ),
                      );
                      // Navigator.pop(context); // Kembali ke halaman sebelumnya
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForumPage()),
                      ); // Kembali ke halaman sebelumnya
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Terdapat kesalahan, silakan coba lagi."),
                        ),
                      );
                    }
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
