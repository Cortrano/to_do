import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

abstract class ProductItemRepository {
   String id = "productitem_${Uuid().v4()}";
   String title = "";
   String description = "";
   double price = 0;
}