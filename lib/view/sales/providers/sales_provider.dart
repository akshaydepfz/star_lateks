import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:star_lateks/models/shop_model.dart';
import 'package:star_lateks/models/shop_weight_model.dart';
import 'package:star_lateks/view/common/app_alert.dart';
import 'package:star_lateks/view/sales/screens/sales_history_screen.dart';

class SalesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<ShopWeightModel>? shopWeightList;
  ShopWeightModel? selectedShopWeight;
  List<ShopModel> shopList = [];
  ShopModel? selectedShop;
  final TextEditingController shopController = TextEditingController();
  final TextEditingController vehichleController = TextEditingController();
  final TextEditingController netWeightController = TextEditingController();
  final TextEditingController advanceController = TextEditingController();

  //AFTER DRC

  final TextEditingController drcController = TextEditingController();
  final TextEditingController dryWeightController = TextEditingController();
  final TextEditingController currentRubberAmountController =
      TextEditingController();
  final TextEditingController gstAmountController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController recivedAmountController = TextEditingController();

  Future<void> getShopList() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('shops').get();
    shopList = querySnapshot.docs
        .map((e) => ShopModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  Future<void> getShopWeightList() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('shop_sales').get();
    shopWeightList = querySnapshot.docs
        .map((e) => ShopWeightModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  void onSalesDRCAdd() async {
    isLoading = true;
    notifyListeners();
    if (double.parse(totalAmountController.text) >
        double.parse(recivedAmountController.text)) {
      await FirebaseFirestore.instance.collection('due_bills').add({
        'shop': shopController.text,
        'vehicle_weight': vehichleController.text,
        'net_weight': netWeightController.text,
        'advance': advanceController.text,
        'drc': drcController.text,
        'dry_weight': dryWeightController.text,
        'current_rubber_amount': currentRubberAmountController.text,
        'gst_amount': gstAmountController.text,
        'total_amount': totalAmountController.text,
        'recived_amount': recivedAmountController.text,
        "id": "",
        "createdAt": DateTime.now().toString(),
        //  "shop_id": selectedShop!.id,
      }).then((value) => {
            FirebaseFirestore.instance
                .collection('due_bills')
                .doc(value.id)
                .update({'id': value.id}),
          });
    }
    await FirebaseFirestore.instance.collection('gst_due').add({
      'shop': shopController.text,
      'vehicle_weight': vehichleController.text,
      'net_weight': netWeightController.text,
      'advance': advanceController.text,
      'drc': drcController.text,
      'dry_weight': dryWeightController.text,
      'current_rubber_amount': currentRubberAmountController.text,
      'gst_amount': gstAmountController.text,
      'total_amount': totalAmountController.text,
      'recived_amount': recivedAmountController.text,
      "id": "",
      "createdAt": DateTime.now().toString(),
      // "shop_id": selectedShop!.id,
    }).then((value) => {
          FirebaseFirestore.instance
              .collection('gst_due')
              .doc(value.id)
              .update({'id': value.id}),
        });

    clearAll();
    isLoading = false;
    notifyListeners();
  }

  void clearAll() {
    shopController.clear();
    vehichleController.clear();
    netWeightController.clear();
    advanceController.clear();
    drcController.clear();
    dryWeightController.clear();
    currentRubberAmountController.clear();
    gstAmountController.clear();
    totalAmountController.clear();
    recivedAmountController.clear();
  }

  void selectWeightList(ShopWeightModel shopWeightModel) {
    selectedShopWeight = shopWeightModel;
    notifyListeners();
  }

  void fillCurrentShopDetails() {
    advanceController.text = selectedShopWeight!.advance;
    netWeightController.text = selectedShopWeight!.netWeight;
  }

  void onDRCChanged() {
    double weight = netWeightController.text.isEmpty
        ? 0
        : double.parse(netWeightController.text.toString());
    double percentage = drcController.text.isEmpty
        ? 0
        : double.parse(drcController.text.toString());

    double deduction = (percentage / 100) * weight;
    double result = weight - deduction;
    dryWeightController.text = "${result.toString()} Kg";
  }

  void onAmountChanged() {
    double weight = double.parse(dryWeightController.text.split(' ')[0]);
    double currentRubberAmount =
        double.parse(currentRubberAmountController.text);
    totalAmountController.text = (weight * currentRubberAmount).toString();
  }

  void onGSTAmountChanged() {
    double gstAmount = double.parse(gstAmountController.text);
    double totalAmount = double.parse(totalAmountController.text);
    totalAmountController.text = (totalAmount + gstAmount).toString();
  }

  Future<void> addSales(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final Map<String, dynamic> data = {
      'shop': shopController.text,
      'vehicle_weight': vehichleController.text,
      'net_weight': netWeightController.text,
      'advance': advanceController.text,
      "id": "",
      "createdAt": DateTime.now().toString(),
      "shop_id": selectedShop!.id,
    };
    await FirebaseFirestore.instance
        .collection('shop_sales')
        .add(data)
        .then((value) => {
              FirebaseFirestore.instance
                  .collection('shop_sales')
                  .doc(value.id)
                  .update({'id': value.id}),
            });
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SalesHistoryScreen()));
    AppAlert.showSuccessSnackbar(context, 'Sales Added Successfully');
    isLoading = false;
    notifyListeners();
  }

  Future<void> getShopValue(String value) async {
    List custList = [];
    selectedShop = null;
    for (var element in shopList) {
      if (element.name.toLowerCase().contains(value.toLowerCase())) {
        custList.add(element);
        selectedShop = element;
        notifyListeners();
      }
    }

    notifyListeners();
  }
}
