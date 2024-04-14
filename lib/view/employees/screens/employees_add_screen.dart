import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/common/primary_button.dart';
import 'package:star_lateks/common/primary_text_field.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/employees/services/employe_service.dart';

class EmployeesAddScreen extends StatelessWidget {
  const EmployeesAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Employee Add'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Column(
            children: [
              PrimaryTextField(
                  hintText: 'Name', controller: provider.nameController),
              AppSpacing.h15,
              PrimaryTextField(
                  hintText: 'Phone', controller: provider.phoneController),
              AppSpacing.h15,
              PrimaryTextField(
                  hintText: 'Address', controller: provider.addressController),
              AppSpacing.h15,
              PrimaryTextField(
                  hintText: 'Salary', controller: provider.salaryController),
              AppSpacing.h15,
              PrimaryTextField(
                  hintText: 'Position',
                  controller: provider.positionController),
              const Spacer(),
              PrimaryButton(
                  isLoading: provider.isLoading,
                  label: 'Submit',
                  onTap: () => provider.addEmployee(context))
            ],
          ),
        ),
      ),
    );
  }
}
