import 'package:flutter/material.dart';
import '../models/car_model.dart';

class CarDetailPage extends StatelessWidget {
  final CarModel car;

  CarDetailPage({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${car.car} ${car.carModel}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image.network(car.image),
            SizedBox(height: 16),
            Text(
              '${car.car} ${car.carModel}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Model: ${car.car}'),
            SizedBox(height: 8),
            Text('Price: \$${car.price}'),
          ],
        ),
      ),
    );
  }
}
