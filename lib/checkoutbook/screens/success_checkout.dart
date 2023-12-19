import 'package:flutter/material.dart';

class SuccessCheckoutPage extends StatelessWidget {
  final String alamat;
  final String metodePembayaran;
  final String metodePengiriman;
  final double totalHarga;
  final List<String> cartItems;

  const SuccessCheckoutPage({
    Key? key,
    required this.alamat,
    required this.metodePembayaran,
    required this.metodePengiriman,
    required this.totalHarga,
    required this.cartItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success Checkout'),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Items:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cartItems
                  .map((item) => Text(
                        item,
                        style: const TextStyle(fontSize: 16),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Text(
              'Alamat Pengiriman: $alamat',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Metode Pembayaran: $metodePembayaran',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Metode Pengiriman: $metodePengiriman',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Total Harga: SAR $totalHarga',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
