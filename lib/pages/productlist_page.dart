import 'package:flutter/material.dart';
import 'package:rbcknightflutter/models/product_model.dart';
import 'package:rbcknightflutter/pages/productdetail_page.dart';
import 'package:rbcknightflutter/services/product_services.dart';

class ProductlistPage extends StatefulWidget {
  const ProductlistPage({super.key});

  @override
  State<ProductlistPage> createState() => _ProductlistPageState();
}

class _ProductlistPageState extends State<ProductlistPage> {
  // late Future<List<CarModel>> _carList;
  late Future<List<ProductModel>> _productList;

  @override
  void initState() {
    super.initState();
    _productList = ProductService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: _productList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data!;
            return ListView.separated(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];

                return ListTile(
                  leading: Image.network('${product.image}', width: 50),
                  title: Text(
                    '(${product.id})  ${product.title}',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('\$${product.price?.toStringAsFixed(2)}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailPage(productId: product.id!),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(),
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
