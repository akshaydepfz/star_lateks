import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/auto_suggession_textfield.dart';
import 'package:star_lateks/view/common/primary_button.dart';
import 'package:star_lateks/view/weight_list/providers/weight_list_provider.dart';

class AddWeightList extends StatelessWidget {
  const AddWeightList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeightListProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // PrimaryTextField(
              //     hintText: 'Select  Customer',
              //     controller: provider.customerNameController),
              // AppSpacing.h20,
              // PrimaryTextField(
              //     hintText: 'Select  Customer',
              //     controller: provider.customerNameController),
              // AppSpacing.h20,
              // PrimaryTextField(
              //     hintText: 'Select  Customer',
              //     controller: provider.customerNameController),
              // AppSpacing.h20,
              // PrimaryTextField(
              //     hintText: 'Select  Customer',
              //     controller: provider.customerNameController),
              AppSpacing.h10,
              AutoSuggestionText(
                  controller: provider.customerController,
                  list: [],
                  label: 'Select Customer'),
              const Spacer(),
              PrimaryButton(
                  text: 'Submit',
                  onPressed: () => provider.submit(context),
                  isLoading: false)
            ],
          ),
        ),
      ),
    );
  }
}