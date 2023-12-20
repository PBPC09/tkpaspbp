import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/AdminRegisterBook/models/book.dart';
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/authentication/login_page.dart';
import 'package:lembarpena/Main/widgets/left_drawer.dart';
import 'package:lembarpena/bookforum/screens/forum_page.dart';
import 'dart:convert';
import 'package:lembarpena/wishlist/models/wishlist.dart';
import 'package:lembarpena/wishlist/screens/explore_book.dart';

class WishlistPage extends StatefulWidget {
  final Book? selectedBook; // Tambahkan field untuk buku yang dipilih

  const WishlistPage({Key? key, this.selectedBook}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late Future<List<Wishlist>> futureWishlist;
  late String loggedInUser = LoginPage.uname;

  @override
  void initState() {
    super.initState();

    futureWishlist =
        fetchWishlist(); // Memuat data wishlist ketika state diinisialisasi
  }

  Future<List<Wishlist>> getWishlist() async {
    return fetchWishlist();
  }

  Future<List<Wishlist>> fetchWishlist() async {
    var url = Uri.parse(
        'https://lembarpena-c09-tk.pbp.cs.ui.ac.id/wishlist/mywishlist/json');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Wishlist> fetchedWishlist = [];
    for (var item in data) {
      if (item['fields']['user'] == loggedInUser) {
        fetchedWishlist.add(Wishlist.fromJson(item));
      }
    }

    // print(item['fields']['user']);
    return fetchedWishlist;
  }

  @override
  Widget build(BuildContext context) {
    // final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Wishlist>>(
          future: getWishlist(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('Tidak ada buku dalam wishlist.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Wishlist wishlistItem = snapshot.data![index];
                  return ListTile(
                    title: Text(wishlistItem.fields.title),
                    // subtitle: Text(wishlistItem.preference.toString()),
                  );
                },
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // currentIndex: 2,
        backgroundColor: Colors.indigo,
        selectedItemColor: const Color.fromARGB(255, 156, 143, 255),
        unselectedItemColor: const Color.fromARGB(255, 156, 143, 255),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Ganti dengan path gambar yang sesuai
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search), // Ganti dengan path gambar yang sesuai
            label: 'Explore Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum), // Ganti dengan path gambar yang sesuai
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


//   // Future<List<Wishlist>> fetchData() async {
//   //   var url = Uri.parse(
//   //       'http://localhost:8000/wishlist/mywishlist/json');
//   //   // String cookieString = getCookieString(cookie);
//   //   var response = await http.get(
//   //     url,
//   //     headers: {
//   //       "Content-Type": "application/json",
//   //     },
//   //   );

//   //   var data = jsonDecode(utf8.decode(response.bodyBytes));
//   //   wishlist = [];
//   //   for (var d in data) {
//   //     wishlist.add(Wishlist.fromJson(d));
//   //   }
//   //   return wishlist;
//   // }

// // import 'package:flutter/material.dart';
// // import 'package:lembarpena/AdminRegisterBook/models/book.dart';
// // import 'package:lembarpena/Main/widgets/left_drawer.dart';

// // class WishlistPage extends StatefulWidget {
// //   final List<Book> wishlist;

// //   const WishlistPage({Key? key, required this.wishlist}) : super(key: key);

// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _WishlistPageState createState() => _WishlistPageState();
// // }

// // class _WishlistPageState extends State<WishlistPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Wishlist', style: TextStyle(color: Colors.white)),
// //         backgroundColor: Colors.indigo[900],
// //       ),
// //       drawer: const LeftDrawer(),
// //       body: widget.wishlist.isEmpty
// //           ? const Center(
// //               child: Text('Wishlist anda kosong.',
// //                   style: TextStyle(fontSize: 18)),
// //             )
// //           : ListView.builder(
// //               itemCount: widget.wishlist.length,
// //               itemBuilder: (context, index) {
// //                 Book book = widget.wishlist[index];
// //                 return Card(
// //                   margin: const EdgeInsets.all(10),
// //                   child: ListTile(
// //                     title: Text(book.fields.title),
// //                     subtitle: Text('Author: ${book.fields.author}'),
// //                     trailing: IconButton(
// //                       icon: const Icon(Icons.delete_outline),
// //                       onPressed: () {
// //                         setState(() {
// //                           widget.wishlist.remove(book);
// //                         });
// //                       },
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //     );
// //   }
// // }