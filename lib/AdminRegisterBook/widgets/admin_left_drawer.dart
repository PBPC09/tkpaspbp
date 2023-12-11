import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/screens/order_notifications.dart';
import 'package:lembarpena/AdminRegisterBook/screens/book_collections.dart';
import 'package:lembarpena/AdminRegisterBook/screens/book_form.dart';
import 'package:lembarpena/AdminRegisterBook/screens/admin_menu.dart';
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
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Column(
              children: [
                Text(
                  'Admin Dashboard',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Register and manage your books here!",
                  // Menambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
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
          // Routing
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminPage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle),
            title: const Text('Book Form'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookFormPage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Book Collections'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const BookCollectionsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Order Notifications'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            // Bagian redirection ke ShopFormPage
            onTap: () async {
              final response =
                  await request.logout("http://127.0.0.1:8000/auth/logout/");
              String message = response["message"];
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message See you again, $uname!"),
                ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message"),
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
