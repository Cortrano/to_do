import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Drawer'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.check_box),
            title: Text('Shopping list'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Groossery'),
          ),
          Divider(),
        ],
      ),
    );
  }
}
