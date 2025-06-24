import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rbcknightflutter/models/product_model.dart';

class ProductService {
  static const String apiUrl = 'https://fakestoreapi.com/products';

  static Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    // if (response.statusCode == 200) {
    //   final jsonData = jsonDecode(response.body);
    //   final List productList = jsonData['products'];
    //   return productList.map((products) => ProductModel.fromJson(products)).toList();
    // } else {
    //   throw Exception('Failed to load product');
    // }

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<ProductModel> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return ProductModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load product');
    }
  }
}
