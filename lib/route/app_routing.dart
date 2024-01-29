import 'package:flutter/material.dart';
import 'package:star_lateks/view/customer/screens/customer_add_screen.dart';
import 'package:star_lateks/view/shop/screens/shop_screen_add.dart';
import 'package:star_lateks/view/weight_list/screens/add_weight_list.dart';

class AppRouting {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const AddWeightList(),
    '/addWeightList': (context) => const AddWeightList(),
    '/customerAdd': (context) => const CustomerAddAScreen(),
    '/shopAdd': (context) => const ShopAddScreen(),
  };
}
