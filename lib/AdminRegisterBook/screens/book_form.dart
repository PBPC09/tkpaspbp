import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/widgets/admin_left_drawer.dart';
import 'package:lembarpena/AdminRegisterBook/screens/admin_menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class BookFormPage extends StatefulWidget {
  const BookFormPage({super.key});

  @override
  State<BookFormPage> createState() => _BookFormPageState();
}

class _BookFormPageState extends State<BookFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _author = "";
  String _rating = "";
  int _voters = 0;
  String _price = "";
  String _currency = "";
  String _description = "";
  String _publisher = "";
  int _pageCount = 0;
  String _genres = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register Your Book',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo.shade900,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Title",
                    labelText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      // Menambahkan variabel yang sesuai
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Title cannot be empty!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Author",
                    labelText: "Author",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _author = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      // Menambahkan variabel yang sesuai
                      _author = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Author cannot be empty!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Rating",
                    labelText: "Rating",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _rating = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      // Menambahkan variabel yang sesuai
                      _rating = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Rating cannot be empty!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Voters",
                    labelText: "Voters",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _voters = int.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Voters cannot be empty!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Voters must be a valid integer!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Price",
                    labelText: "Price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _price = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      // Menambahkan variabel yang sesuai
                      _price = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Price cannot be empty!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Currency",
                    labelText: "Currency",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _currency = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      // Menambahkan variabel yang sesuai
                      _currency = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Currency cannot be empty!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Publisher",
                    labelText: "Publisher",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      // Menambahkan variabel yang sesuai
                      _publisher = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      // Menambahkan variabel yang sesuai
                      _publisher = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Publisher cannot be empty!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Page Count",
                    labelText: "Page Count",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _pageCount = int.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Page Count cannot be empty!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Page Count must be a valid integer!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Genres",
                    labelText: "Genres",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      // Menambahkan variabel yang sesuai
                      _genres = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      // Menambahkan variabel yang sesuai
                      _genres = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Genres cannot be empty!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Description",
                    labelText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      // Menambahkan variabel yang sesuai
                      _description = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      // Menambahkan variabel yang sesuai
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Description cannot be empty!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final response = await request.postJson(
                "http://localhost:8000/registerbook/create-book-flutter/",
                jsonEncode(<String, String>{
                  'title': _title,
                  'author': _author,
                  'rating': _rating.toString(),
                  'voters': _voters.toString(),
                  'price': _price.toString(),
                  'currency': _currency,
                  'description': _description,
                  'publisher': _publisher,
                  'page_count': _pageCount.toString(),
                  'genres': _genres,
                }),
              );
              if (response['status'] == 'success') {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("New book has been saved!"),
                  ),
                );
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPage()),
                );
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("ERROR, please try again!"),
                  ),
                );
              }
            }
          },
          child: const Text(
            "Save",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
