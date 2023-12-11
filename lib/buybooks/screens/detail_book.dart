import 'package:flutter/material.dart';
import 'package:lembarpena/buybooks/models/book.dart';

class ItemDetailPage extends StatelessWidget {
  final Book item;

  const ItemDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.fields.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${item.fields.title}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Author: ${item.fields.author}'),
            SizedBox(height: 10),
            Text('Rating: ${item.fields.rating}'),
            SizedBox(height: 10),
            Text('Voters: ${item.fields.voters}'),
            SizedBox(height: 10),
            Text('Price: ${item.fields.price}'),
            SizedBox(height: 10),
            Text('Publisher: ${item.fields.publisher}'),
            SizedBox(height: 10),
            Text('Page Count: ${item.fields.pageCount}'),
            SizedBox(height: 10),
            Text('Description: ${item.fields.description}'),
          ],
        ),
      ),
    );
  }
}