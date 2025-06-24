import 'package:flutter/material.dart';
import 'package:rbcknightflutter/services/product_services.dart';
import '../models/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Future<ProductModel> product;

  @override
  void initState() {
    super.initState();
    product = ProductService.fetchProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รายละเอียดสินค้า")),
      body: FutureBuilder<ProductModel>(
        future: product,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('ไม่พบข้อมูลสินค้า'));
          }

          final p = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network('${p.image}', height: 200),
                ),
                const SizedBox(height: 16),
                Text('${p.title}',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('\$${p.price?.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, color: Colors.green)),
                const SizedBox(height: 16),
                Text('${p.description}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
