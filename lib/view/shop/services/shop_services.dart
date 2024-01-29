import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopServices extends ChangeNotifier {
  final TextEditingController shopNameControll = TextEditingController();
  final TextEditingController shopContactControll = TextEditingController();
  final TextEditingController shopWhatsappControll = TextEditingController();
  final TextEditingController shopLocationControll = TextEditingController();

  Future<void> addShopToFirestore() async {
    await FirebaseFirestore.instance.collection('shop').add({
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
          .collection('shop')
          .doc(value.id)
          .update({"id": value.id});
    });
    shopNameControll.clear();
    shopContactControll.clear();
    shopWhatsappControll.clear();
    shopLocationControll.clear();
    notifyListeners();
  }
}
