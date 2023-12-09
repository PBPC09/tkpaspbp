import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/screens/book_collections.dart';
import 'package:lembarpena/AdminRegisterBook/screens/book_form.dart';
import 'package:lembarpena/AdminRegisterBook/screens/order_notifications.dart';
import 'package:lembarpena/authentication/login_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AdminMenuItem {
  final String name;
  final IconData icon;
  final Color color;

  AdminMenuItem(this.name, this.icon, this.color);
}

class AdminMenuCard extends StatelessWidget {
  final AdminMenuItem page;

  const AdminMenuCard(this.page, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Material(
      color: page.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () async {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${page.name}!")));

          if (page.name == "Book Collections") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const BookCollectionsPage(), // Gantilah dengan nama halaman "Book Collections" yang sesuai
                ));
          } else if (page.name == "Book Form") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const BookFormPage(), // Gantilah dengan nama halaman "Notification" yang sesuai
                ));
          } else if (page.name == "Order Notifications") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const NotificationPage(), // Gantilah dengan nama halaman "Notification" yang sesuai
                ));
          } else if (page.name == "Logout") {
            final response =
                await request.logout("http://127.0.0.1:8000/auth/logout/");
            //"https://muhammad-hilal21-tugas.pbp.cs.ui.ac.id/auth/logout/");
            String message = response["message"];
            if (response['status']) {
              String uname = response["username"];
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message Sampai jumpa, $uname."),
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
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  page.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  page.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
