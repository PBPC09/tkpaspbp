import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/models/book.dart';
import 'package:lembarpena/wishlist/screens/my_wishlist.dart';
import 'package:http/http.dart' as http;
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';

class WishlistForm extends StatefulWidget {
  final Book book;

  const WishlistForm({Key? key, required this.book}) : super(key: key);

  @override
  _WishlistFormState createState() => _WishlistFormState();
}

class _WishlistFormState extends State<WishlistForm> {
  String? _selectedPreference;

  Future<void> sendWishlistData(String preference) async {
    final Map<String, dynamic> requestBody = {
      'book_id': widget.book.pk.toString(),
      'preference': preference,
    };

    final response = await http.post(
      Uri.parse("http://localhost:8000/wishlist/add_to_wishlist_flutter/"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 201) {
      // Handle success
      return;
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'How much do you like this book?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedPreference,
              onChanged: (String? value) {
                setState(() {
                  _selectedPreference = value;
                });
              },
              items: [
                'Not Interested',
                'Maybe Later',
                'Interested',
                'Really Want It',
                'Must Have',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Preference',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_selectedPreference != null) {
                  // try {
                    await sendWishlistData(_selectedPreference!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WishlistPage(
                          // book: snapshot.data![index],
                        ),
                      ),
                    );
                  // } catch (e) {
                  //   showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         title: Text('Error'),
                  //         content: Text('Failed to add book to wishlist: $e'),
                  //         actions: [
                  //           TextButton(
                  //             onPressed: () => Navigator.pop(context),
                  //             child: Text('OK'),
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   );
                  // }
                } else {
                  // Prompt the user to select a preference before submitting
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Please select a preference.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
