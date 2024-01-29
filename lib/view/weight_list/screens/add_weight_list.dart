import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/auto_suggession_textfield.dart';
import 'package:star_lateks/view/common/primary_button.dart';
import 'package:star_lateks/view/common/primary_textField.dart';
import 'package:star_lateks/view/weight_list/providers/weight_list_provider.dart';

class AddWeightList extends StatefulWidget {
  const AddWeightList({super.key});

  @override
  State<AddWeightList> createState() => _AddWeightListState();
}

class _AddWeightListState extends State<AddWeightList> {
  @override
  void initState() {
    Provider.of<WeightListProvider>(context, listen: false).getCustomerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeightListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Weight List'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              AppSpacing.h10,
              AutoSuggestionText(
                  controller: provider.customerController,
                  list: provider.customerList.map((e) => e.name).toList(),
                  label: 'Select Customer'),
              AppSpacing.h20,
              PrimaryTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Enter Advance Amount',
                  labelText: 'Enter Advance Amount',
                  controller: provider.advancePaidControl),
              AppSpacing.h20,
              PrimaryTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Enter Weight (per barrels)',
                  labelText: 'Enter Weight (per barrels)',
                  controller: provider.weightControl),
              AppSpacing.h20,
              PrimaryTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Barrels Count',
                  labelText: 'Barrels Count',
                  controller: provider.weightControl),
              AppSpacing.h20,
              PrimaryTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Balance Barrels',
                  labelText: 'Balance Barrels',
                  controller: provider.weightControl),
              AppSpacing.h20,
              PrimaryTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Placed Barrels',
                  labelText: 'Placed Barrels',
                  controller: provider.weightControl),
              const Spacer(),
              PrimaryButton(
                  text: 'Generate Bill',
                  onPressed: () => provider.submit(context),
                  isLoading: false)
            ],
          ),
        ),
      ),
    );
  }
}
