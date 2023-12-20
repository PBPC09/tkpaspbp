// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:lembarpena/wishlist/models/book.dart';
// import 'package:lembarpena/wishlist/screens/my_wishlist.dart';
// import 'package:http/http.dart' as http;
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';

// class WishlistForm extends StatelessWidget {
//   final Book book;

//   const WishlistForm({Key? key, required this.book}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final request = context.watch<CookieRequest>();
//     String? selectedPreference; 

//     Future<void> sendWishlistData(String preference) async {
//       if (selectedPreference == null) {
//         print('Error: _selectedPreference is null.');
//         return;
//       }

//       // final Map<String, dynamic> requestBody = {
//       //   'book_id': book.pk.toString(),
//       //   'preference': selectedPreference!,
//       // };

//       final response = await request.postJson(
//       "http://localhost:8000/wishlist/add_to_wishlist_flutter/",

//       jsonEncode({"book": book.pk.toInt(), "preference" : selectedPreference!}),
//       );

//       if (response.statusCode != 201) {
//         throw Exception('Failed to add to wishlist');
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Wishlist Form'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               'How much do you like this book?',
//               style: TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               value: selectedPreference,
//               onChanged: (String? value) {
//                 // No need for setState in a StatelessWidget
//                 selectedPreference = value;
//               },
//               items: [
//                 'Not Interested',
//                 'Maybe Later',
//                 'Interested',
//                 'Really Want It',
//                 'Must Have',
//               ].map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               decoration: const InputDecoration(
//                 labelText: 'Preference',
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 if (selectedPreference != null) {
//                   sendWishlistData(selectedPreference!);

//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const WishlistPage(wishlist: [],),
//                     ),
//                   );
//                 } else {

//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: const Text('Error'),
//                         content: const Text('Please select a preference.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Text('OK'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//               child: const Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // void main() {
// //   runApp(MaterialApp(
// //     WishlistForm(
  
// //     ),
// //   ));
// // }
