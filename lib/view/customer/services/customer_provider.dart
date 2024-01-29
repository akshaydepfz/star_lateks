import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:star_lateks/view/common/app_alert.dart';
import 'package:star_lateks/view/customer/screens/customer_list_screen.dart';

class CustomerProvider extends ChangeNotifier {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController customerWhatsAppController = TextEditingController();
  TextEditingController customerBankAccountController = TextEditingController();
  TextEditingController customerPhoneController = TextEditingController();
  List<CustomerModel>? customerList;
  CustomerModel? customerModel;
  ScrollController scrollController = ScrollController();

  void whenScrollDownClick() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

Future<void> getCustomer()async{
  
}

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('customers');

  Future<void> getCustomerList() async {
    final QuerySnapshot snapshot = await _collectionReference.get();
    customerList = snapshot.docs
        .map((e) => CustomerModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  void insertEdit(CustomerModel customerModel) {
    customerNameController.text = customerModel.name;
    customerAddressController.text = customerModel.address;
    customerWhatsAppController.text = customerModel.whatsApp;
    customerBankAccountController.text = customerModel.bankAccount;
    customerPhoneController.text = customerModel.phone;
    notifyListeners();
  }

  Future<void> updateCustomer(BuildContext context, String id) async {
    if (customerNameController.text.isEmpty) {
      AppAlert.showWrongSnackbar(context, 'Please enter name');
    } else if (customerPhoneController.text.isEmpty) {
      AppAlert.showWrongSnackbar(context, 'Please enter phone number');
    } else if (customerAddressController.text.isEmpty) {
      AppAlert.showWrongSnackbar(context, 'Please enter address');
    } else if (customerWhatsAppController.text.isEmpty) {
      AppAlert.showWrongSnackbar(context, 'Please enter whatsapp number');
    } else if (customerBankAccountController.text.isEmpty) {
      AppAlert.showWrongSnackbar(context, 'Please enter bank account number');
    } else if (customerPhoneController.text.length != 10) {
      AppAlert.showWrongSnackbar(context, 'Please enter valid phone number');
    } else if (customerWhatsAppController.text.length != 10) {
      AppAlert.showWrongSnackbar(context, 'Please enter valid whatsapp number');
    } else {
      _isLoading = true;
      notifyListeners();
      try {
        await _collectionReference.doc(id).update({
          'name': customerNameController.text,
          'phone': customerPhoneController.text,
          'address': customerAddressController.text,
          'whatsApp': customerWhatsAppController.text,
          'bankAccount': customerBankAccountController.text,
          'updatedAt': DateTime.now().toString(),
        });
        _isLoading = false;
        notifyListeners();
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const CustomerListScreen()));
      } on FirebaseException catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Something went wrong'),
          ),
        );
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> submit(BuildContext context) async {
    if (customerNameController.text.isEmpty) {
      AppAlert.showWrongSnackbar(context, 'Please enter name');
    } else if (customerPhoneController.text.isEmpty) {
      AppAlert.showWrongSnackbar(context, 'Please enter phone number');
    } else if (customerAddressController.text.isEmpty) {
      AppAlert.showWrongSnackbar(context, 'Please enter address');
    } else if (customerWhatsAppController.text.isEmpty) {
      AppAlert.showWrongSnackbar(context, 'Please enter whatsapp number');
    } else if (customerBankAccountController.text.isEmpty) {
      AppAlert.showWrongSnackbar(context, 'Please enter bank account number');
    } else if (customerPhoneController.text.length != 10) {
      AppAlert.showWrongSnackbar(context, 'Please enter valid phone number');
    } else if (customerWhatsAppController.text.length != 10) {
      AppAlert.showWrongSnackbar(context, 'Please enter valid whatsapp number');
    } else {
      _isLoading = true;
      notifyListeners();
      try {
        await _collectionReference.add({
          'name': customerNameController.text,
          'phone': customerPhoneController.text,
          'address': customerAddressController.text,
          'whatsApp': customerWhatsAppController.text,
          'bankAccount': customerBankAccountController.text,
          'createdAt': DateTime.now().toString(),
          'updatedAt': DateTime.now().toString(),
          'totalWeight': 0,
          'totalAmount': 0,
          'advanceAmount': 0,
          'remainingAmount': 0,
          'lastVisited': DateTime.now().toString(),
          'barrels_taken': 0,
          'barrels_returned': 0,
          'barrels_remaining': 0,
          'uid': '',
        }).then((value) {
          _collectionReference.doc(value.id).update({'uid': value.id});
        });
        _isLoading = false;
        notifyListeners();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } on FirebaseException catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Something went wrong'),
          ),
        );
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}

class CustomerModel {
  final String name;
  final String address;
  final String phone;
  final String whatsApp;
  final String bankAccount;
  final String createdAt;
  final String updatedAt;
  final int totalWeight;
  final int totalAmount;
  final int advanceAmount;
  final int remainingAmount;
  final String lastVisited;
  final int barrelsTaken;
  final int barrelsReturned;
  final int barrelsRemaining;
  final String uid;

  CustomerModel({
    required this.name,
    required this.address,
    required this.whatsApp,
    required this.bankAccount,
    required this.createdAt,
    required this.updatedAt,
    required this.totalWeight,
    required this.totalAmount,
    required this.advanceAmount,
    required this.remainingAmount,
    required this.lastVisited,
    required this.barrelsTaken,
    required this.barrelsReturned,
    required this.barrelsRemaining,
    required this.phone,
    required this.uid,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      whatsApp: json['whatsApp'],
      bankAccount: json['bankAccount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      totalWeight: json['totalWeight'],
      totalAmount: json['totalAmount'],
      advanceAmount: json['advanceAmount'],
      remainingAmount: json['remainingAmount'],
      lastVisited: json['lastVisited'],
      barrelsTaken: json['barrels_taken'],
      barrelsReturned: json['barrels_returned'],
      barrelsRemaining: json['barrels_remaining'],
      uid: json['uid'],
    );
  }
}
