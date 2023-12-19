import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String apiUrl = 'http://localhost:8000/checkoutbook/get_order_json/';

class Order {
  final int id;
  final String alamat;
  final String metodePembayaran;
  final int totalPrice;
  final List<dynamic> items;

  Order({
    required this.id,
    required this.alamat,
    required this.metodePembayaran,
    required this.totalPrice,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['pk'],
      alamat: json['fields']['alamat'],
      metodePembayaran: json['fields']['metode_pembayaran'],
      totalPrice: json['fields']['total_price'],
      items: List<dynamic>.from(json['fields']['items']),
    );
  }
}

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  late Future<List<Order>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = fetchOrders();
  }

  Future<List<Order>> fetchOrders() async {
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((order) => Order.fromJson(order)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: FutureBuilder<List<Order>>(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found'));
          } else {
            List<Order> orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('Order ${orders[index].id}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Alamat: ${orders[index].alamat}'),
                        Text('Total Price: SAR ${orders[index].totalPrice}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
