import 'package:flutter/material.dart';
import 'package:lembarpena/BookForum/screens/forum_page.dart';
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/checkoutbook/screens/checkoutpage.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
            leading: const Icon(Icons.search),
            title: const Text('Explore Book'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              /*
              Buatlah routing ke ShopFormPage di sini,
              setelah halaman ShopFormPage sudah dibuat.
              */
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ShopFormPage(),
              //     ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Wishlist'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Cart'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CheckoutPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Buy Books'),
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
        ],
      ),
    );
  }
}
