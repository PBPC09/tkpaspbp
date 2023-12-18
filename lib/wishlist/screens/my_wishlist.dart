// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:lembarpena/AdminRegisterBook/models/book.dart';
// import 'package:lembarpena/Authentication/login_page.dart';
// import 'dart:convert';
// import 'package:lembarpena/wishlist/models/wishlist.dart';
// // import 'package:lembarpena/wishlist/models/book.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';

// class WishlistPage extends StatefulWidget {
//   final Book? selectedBook; // Tambahkan field untuk buku yang dipilih

//   const WishlistPage({Key? key, this.selectedBook}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _WishlistPageState createState() => _WishlistPageState();
// }

// class _WishlistPageState extends State<WishlistPage> {
//   List<Wishlist> wishlist = [];
//   late String loggedInUser = LoginPage.uname;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _futureWishlistBooks = fetchData();
//   // }
//   String getCookieString(CookieRequest cookieRequest) {
//     // Asumsikan cookieRequest memiliki properti 'cookies' yang adalah Map<String, Cookie>
//     Map<String, Cookie> cookies = cookieRequest.cookies;

//     // Iterasi melalui map dan buat string cookie
//     String cookieString =
//         cookies.values.map((Cookie c) => '${c.name}=${c.value}').join('; ');

//     return cookieString;
//   }

//   Future<List<Wishlist>> fetchData(CookieRequest cookie) async {
//     var url = Uri.parse(
//         'http://localhost:8000/wishlist/mywishlist/json'); // Sesuaikan dengan URL endpoint Anda
//     String cookieString = getCookieString(cookie);
//     var response = await http.get(
//       url,
//       headers: {
//         "Content-Type": "application/json",
//         "Cookie": cookieString,
//       },
//     );

//     var data = jsonDecode(utf8.decode(response.bodyBytes));
//     wishlist = [];
//     for (var d in data) {
//       wishlist.add(Wishlist.fromJson(d));
//     }
//     return wishlist;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final request = context.watch<CookieRequest>();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Wishlist Saya'),
//         backgroundColor: Colors.indigo[900],
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: FutureBuilder<List<Wishlist>>(
//           future: fetchData(request),
//           builder: (context, AsyncSnapshot snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Center(child: Text('Tidak ada buku dalam wishlist.'));
//             } else {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   var book = snapshot.data![index];
//                   var bookFields = book.fields;
//                   if (loggedInUser == bookFields.user) {
//                     // Kembalikan widget yang sesuai dengan data buku
//                     return ListTile(
//                       title: Text(bookFields.title),
//                       subtitle: Text(bookFields.preference),
//                     );
//                   }
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

