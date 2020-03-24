import 'package:uuid/uuid.dart';

abstract class ProductItem {
   String id = "productitem_${Uuid().v4()}";
   String title = "";
   String description = "";
   double price = 0;
}