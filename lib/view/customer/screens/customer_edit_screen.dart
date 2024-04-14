import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/common/primary_button.dart';
import 'package:star_lateks/common/primary_text_field.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/customer/services/customer_provider.dart';

class CustomerEditScreen extends StatelessWidget {
  final CustomerModel customerModel;
  const CustomerEditScreen({super.key, required this.customerModel});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CustomerProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Customer Edit'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              PrimaryTextField(
                  hintText: 'Enter Name',
                  controller: provider.customerNameController),
              AppSpacing.h20,
              PrimaryTextField(
                  hintText: 'Enter Phone Number',
                  controller: provider.customerPhoneController),
              AppSpacing.h20,
              PrimaryTextField(
                hintText: 'Enter Site Address',
                controller: provider.customerAddressController,
              ),
              AppSpacing.h20,
              PrimaryTextField(
                  hintText: 'Enter WhatsApp Number',
                  controller: provider.customerWhatsAppController),
              AppSpacing.h20,
              PrimaryTextField(
                  hintText: 'Enter Bank Account Number',
                  controller: provider.customerBankAccountController),
              AppSpacing.h20,
              const Spacer(),
              PrimaryButton(
                  label: 'SUBMIT CHANGE',
                  isLoading: provider.isLoading,
                  onTap: () => provider.updateCustomer(
                        context,
                        customerModel.uid,
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
