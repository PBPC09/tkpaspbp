import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/widgets/admin_menu_card.dart';
// import 'package:inventory_app_mobile/screens/book_collections.dart'; // Gantilah dengan nama halaman "Book Collections" yang sesuai
// import 'package:inventory_app_mobile/screens/notifications.dart'; // Gantilah dengan nama halaman "Notification" yang sesuai
// import 'package:lembarpena/authentication/login_page.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<AdminMenuItem> adminMenuItems = [
      AdminMenuItem("Book Collections", Icons.book, Colors.blue),
      AdminMenuItem("Notification", Icons.notifications, Colors.green),
    ];

    // final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page"),
      ),
      body: GridView.builder(
        itemCount: adminMenuItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          final item = adminMenuItems[index];
          return AdminMenuCard(item);
        },
      ),
    );
  }
}
