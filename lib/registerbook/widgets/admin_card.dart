import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AdminMenuItem {
  final String name;
  final IconData icon;
  final Color color;

  AdminMenuItem(this.name, this.icon, this.color);
}

class AdminCard extends StatelessWidget {
  final AdminMenuItem item;

  const AdminCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Material(
      color: item.color,
      child: InkWell(
        onTap: () async {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

          switch (item.name) {
            case "Show Registered Books":
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const RegisteredBooksPage(),
            //   ),
            // );
            // break;
            case "Show Order Notifications":
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const OrderNotificationsPage(),
              //   ),
              // );
              break;
            case "Logout":
              final response =
                  await request.logout("http://127.0.0.1:8000/auth/logout/");
              String message = response["message"];
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message Sampai jumpa, $uname."),
                ));
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => const LoginPage()),
                // );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message"),
                ));
              }
              break;
          }
        },
        child: Container(
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
