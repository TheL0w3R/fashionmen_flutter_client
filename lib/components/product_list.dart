import 'package:fashionmen_flutter_client/components/product_card.dart';
import 'package:fashionmen_flutter_client/models/product.dart';
import 'package:fashionmen_flutter_client/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  final String searchCriteria;

  ProductList({Key key, @required this.searchCriteria});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ProductService _productService = ProductService();

  List<Widget> _getProductCards(List<Product> products) {
    if(widget.searchCriteria != null)
      return products.where((pr) => pr.name.contains(widget.searchCriteria)).map((p) => ProductCard(p)).toList();
    else
      return products.map((p) => ProductCard(p)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _productService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              children: _getProductCards(snapshot.data)
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}