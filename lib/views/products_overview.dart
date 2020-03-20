import 'package:flutter/material.dart';
import 'package:to_do/components/main_drawer.dart';

class ProductsOverview extends StatelessWidget {
  const ProductsOverview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProductsOverview'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text('Body'),
      ),
    );
  }
}
