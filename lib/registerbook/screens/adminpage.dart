import 'package:flutter/material.dart';
// Impor admin drawer widget
// import 'package:lembarpena/widgets/left_drawer_admin.dart';
// // Impor book collection card
// import 'package:lembarpena/widgets/book_collection_card.dart';
// // Impor order notification card
// import 'package:lembarpena/widgets/order_notification_card.dart';

class AdminHomePage extends StatelessWidget {
  AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      //drawer: const LeftDrawerAdmin(), // Menggunakan admin drawer
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Book Collection', // Judul untuk koleksi buku
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Tampilkan koleksi buku disini
              //BookCollectionCard(), // Widget untuk menampilkan koleksi buku
              const Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Text(
                  'Order Notifications', // Judul untuk notifikasi order
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Tampilkan notifikasi order disini
              //OrderNotificationCard(), // Widget untuk menampilkan notifikasi order
            ],
          ),
        ),
      ),
    );
  }
}
