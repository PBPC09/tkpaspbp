import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/models/Notification.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future<List<OrderNotifications>> fetchNotifications(request) async {
    var data = await request.get(
        'http://127.0.0.1:8000/get-notif/'); // Replace with your API endpoint

    // Convert JSON data to Notification objects
    List<OrderNotifications> notificationList = [];
    for (var d in data) {
      if (d != null) {
        notificationList.add(OrderNotifications.fromJson(d));
      }
    }
    return notificationList;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: fetchNotifications(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Center(
              child: Text(
                "No notifications available.",
                style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) => Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snapshot.data[index].title}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("Message: ${snapshot.data[index].message}"),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
