import 'package:flutter/material.dart';
import 'package:lembarpena/BookForum/screens/forum_page.dart';
import 'package:lembarpena/Main/screens/landing_page.dart';
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/Wishlist/screens/explore_book.dart';
import 'package:lembarpena/Authentication/login_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            // Bagian drawer header
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Column(
              children: [
                Text(
                  'Lembar Pena',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Cari buku disini bro",
                  // Tambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          // Bagian routing
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Buy Books'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Wishlist'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Explore Book'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExploreBooksPage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Cart'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Book Forum'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ForumPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt),
            title: const Text('My Order'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            // Bagian redirection ke ShopFormPage
            onTap: () async {
                final response = await request.logout("http://localhost:8000/auth/logout/");
                // await request.login("http://10.0.2.2:8000/auth/login/", {
                String message = response["message"];
                if (response['status']) {
                  String uname = response["username"];
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message Sampai jumpa, $uname!"),
                  ));
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LandingPage()),
                    (Route<dynamic> route) => false,
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(message),
                  ));
                }              
            },
          ),
        ],
      ),
    );
  }
}
