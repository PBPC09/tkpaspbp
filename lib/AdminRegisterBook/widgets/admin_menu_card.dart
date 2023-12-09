import 'package:flutter/material.dart';
// import 'package:inventory_app_mobile/screens/book_collections.dart'; // Gantilah dengan nama halaman "Book Collections" yang sesuai
// import 'package:inventory_app_mobile/screens/notifications.dart'; // Gantilah dengan nama halaman "Notification" yang sesuai
// import 'package:lembarpena/authentication/login_page.dart';
import 'package:lembarpena/AdminRegisterBook/screens/book_collections.dart';
import 'package:lembarpena/AdminRegisterBook/screens/order_notifications.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';

class AdminMenuItem {
  final String name;
  final IconData icon;
  final Color color;

  AdminMenuItem(this.name, this.icon, this.color);
}

class AdminMenuCard extends StatelessWidget {
  final AdminMenuItem item;

  const AdminMenuCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    // final request = context.watch<CookieRequest>();

    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () async {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

          if (item.name == "Book Collections") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BookCollectionsPage(), // Gantilah dengan nama halaman "Book Collections" yang sesuai
                ));
          } else if (item.name == "Notification") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      NotificationPage(), // Gantilah dengan nama halaman "Notification" yang sesuai
                ));
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
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
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
