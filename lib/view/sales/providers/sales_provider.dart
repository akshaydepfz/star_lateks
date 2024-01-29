import 'package:flutter/material.dart';
import 'package:star_lateks/models/customer_model.dart';

class SalesProvider extends ChangeNotifier {
  List<Shop>? shopList;
  final TextEditingController shopController = TextEditingController();
}
