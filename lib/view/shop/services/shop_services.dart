import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:star_lateks/view/common/app_alert.dart';

class ShopServices extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final TextEditingController shopNameControll = TextEditingController();
  final TextEditingController shopContactControll = TextEditingController();
  final TextEditingController shopWhatsappControll = TextEditingController();
  final TextEditingController shopLocationControll = TextEditingController();

  Future<void> addShopToFirestore(BuildContext context) async {
    if (shopNameControll.text == '') {
      AppAlert.showWrongSnackbar(context, 'Shop Name is required');
    } else if (shopContactControll.text == '') {
      AppAlert.showWrongSnackbar(context, 'Contact Number is required');
    } else if (shopWhatsappControll.text == '') {
      AppAlert.showWrongSnackbar(context, 'Whatsapp Number is required');
    } else if (shopLocationControll.text == '') {
      AppAlert.showWrongSnackbar(context, 'Location is required');
    } else {
      _isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance.collection('shops').add({
        "name": shopNameControll.text,
        "contact": shopContactControll.text,
        "whatsapp": shopWhatsappControll.text,
        "location": shopLocationControll.text,
        "createdAt": DateTime.now().toString(),
        "updatedAt": DateTime.now().toString(),
        "isActive": true,
        "totalAdvance": 0,
        "totalWeight": 0,
        "totalAmount": 0,
        "id": "",
      }).then((value) {
        FirebaseFirestore.instance
            .collection('shops')
            .doc(value.id)
            .update({"id": value.id});
      });
      shopNameControll.clear();
      shopContactControll.clear();
      shopWhatsappControll.clear();
      shopLocationControll.clear();
      AppAlert.showSuccessSnackbar(context, 'Shop Added Successfully');
      Navigator.pop(context);
      _isLoading = false;
      notifyListeners();
    }
  }
}
