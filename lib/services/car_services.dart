import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/car_model.dart';

class CarService {
  static const String apiUrl = 'https://myfakeapi.com/api/cars/';

  static Future<List<CarModel>> fetchCars() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List carList = jsonData['cars'];
      return carList.map((car) => CarModel.fromJson(car)).toList();
    } else {
      throw Exception('Failed to load cars');
    }
  }
}
