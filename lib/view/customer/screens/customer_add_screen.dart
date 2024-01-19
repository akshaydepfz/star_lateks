import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/common/primary_button.dart';
import 'package:star_lateks/view/common/primary_textField.dart';
import 'package:star_lateks/view/customer/services/customer_provider.dart';

class CustomerAddAScreen extends StatelessWidget {
  const CustomerAddAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CustomerProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Customer Add'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              PrimaryTextField(
                  hintText: 'Enter Name',
                  labelText: 'Name',
                  controller: provider.customerNameController),
              AppSpacing.h20,
              PrimaryTextField(
                  hintText: 'Enter Phone Number',
                  labelText: 'Phone Number',
                  controller: provider.customerPhoneController),
              AppSpacing.h20,
              PrimaryTextField(
                hintText: 'Enter Site Address',
                labelText: 'Address',
                controller: provider.customerAddressController,
                maxlLines: 3,
              ),
              AppSpacing.h20,
              PrimaryTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Enter WhatsApp Number',
                  labelText: 'WhatsApp Number',
                  controller: provider.customerWhatsAppController),
              AppSpacing.h20,
              PrimaryTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Enter Bank Account Number',
                  labelText: 'Bank Account Number',
                  controller: provider.customerBankAccountController),
              AppSpacing.h20,
              const Spacer(),
              PrimaryButton(
                text: 'SUBMIT',
                isLoading: provider.isLoading,
                onPressed: () => provider.submit(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
