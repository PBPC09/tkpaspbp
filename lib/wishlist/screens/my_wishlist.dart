import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/AdminRegisterBook/models/book.dart';
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/authentication/login_page.dart';
import 'package:lembarpena/Main/widgets/left_drawer.dart';
import 'package:lembarpena/bookforum/screens/forum_page.dart';
import 'package:lembarpena/wishlist/models/wishlist.dart';
import 'package:lembarpena/wishlist/screens/explore_book.dart';
import 'dart:convert';

class WishlistPage extends StatefulWidget {
  final Book? selectedBook; // Tambahkan field untuk buku yang dipilih

  const WishlistPage({Key? key, this.selectedBook}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<List<Wishlist>>(
            future: getWishlist(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const Text('Tidak ada buku dalam wishlist.');
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Wishlist wishlistItem = snapshot.data![index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        title: Text(wishlistItem.fields.title),
                        subtitle: Text(
                            "Preference: ${wishlistItem.fields.preference}"),
                      ),
                    );
                  },
                );
              }
            },
          ),
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
