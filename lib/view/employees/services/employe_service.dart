// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:star_lateks/models/employee_model.dart';
import 'package:star_lateks/view/common/app_alert.dart';

class EmployeeService extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final TextEditingController paymentController = TextEditingController();
  List<EmployeeModel>? employees;

  Future<void> getEmployee() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("employees")
        .where("agent_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    employees = snapshot.docs
        .map((docSnapshot) => EmployeeModel.fromJson(docSnapshot.data()))
        .toList();
    notifyListeners();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController positionController = TextEditingController();

  void clearControllers() {
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    salaryController.clear();
    positionController.clear();
  }

  Future<void> payEmployee(
      BuildContext context, String id, int remainingSalary) async {
    if (paymentController.text == '') {
      AppAlert.showWrongSnackbar(context, 'Please enter payment amount');
    } else if (int.parse(paymentController.text) > remainingSalary) {
      AppAlert.showWrongSnackbar(
          context, 'Payment amount is greater than remaining salary');
    } else if (int.parse(paymentController.text) == 0) {
      AppAlert.showWrongSnackbar(context, 'Please enter payment amount');
    } else {
      _isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance.collection('employees').doc(id).update({
        'remining_salary':
            employees![0].reminingSalary - int.parse(paymentController.text)
      });
      AppAlert.showSuccessSnackbar(context, 'Payment done successfully');
      Navigator.pop(context);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addEmployee(BuildContext context) async {
    if (nameController.text == '') {
      AppAlert.showWrongSnackbar(context, 'Name is required');
    } else if (phoneController.text == '') {
      AppAlert.showWrongSnackbar(context, 'Please enter phone Number');
    } else if (addressController.text == '') {
      AppAlert.showWrongSnackbar(context, 'Please enter address');
    } else if (salaryController.text == '') {
      AppAlert.showWrongSnackbar(context, 'Please enter salary');
    } else if (positionController.text == '') {
      AppAlert.showWrongSnackbar(context, 'Please enter position');
    } else {
      _isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance.collection('employees').add({
        'name': nameController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'salary': salaryController.text,
        'position': positionController.text,
        "createdAt": DateTime.now().toString(),
        "agent_id": FirebaseAuth.instance.currentUser!.uid,
        "id": '',
        "remining_salary": int.parse(salaryController.text),
      }).then((value) {
        FirebaseFirestore.instance
            .collection('employees')
            .doc(value.id)
            .update({'id': value.id});
      });

      AppAlert.showSuccessSnackbar(context, 'Employee added successfully');
      Navigator.pop(context);
      _isLoading = false;
      notifyListeners();
    }
  }
}
