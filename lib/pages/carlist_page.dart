import 'package:flutter/material.dart';
import 'package:rbcknightflutter/pages/cardetail_page.dart';
import 'package:rbcknightflutter/services/car_services.dart';
import '../models/car_model.dart';

class CarListPage extends StatefulWidget {
  @override
  _CarListPageState createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  late Future<List<CarModel>> _carList;

  @override
  void initState() {
    super.initState();
    _carList = CarService.fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Car List')),
      body: FutureBuilder<List<CarModel>>(
        future: _carList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final cars = snapshot.data!;
            return ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                return ListTile(
                  // leading: Image.network(car.image, width: 50, fit: BoxFit.cover),
                  title: Text('${car.car} ${car.carModel}'),
                  subtitle: Text('\$${car.price}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CarDetailPage(car: car),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
