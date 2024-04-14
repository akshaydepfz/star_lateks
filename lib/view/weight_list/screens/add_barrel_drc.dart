import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/common/primary_button.dart';
import 'package:star_lateks/common/primary_text_field.dart';
import 'package:star_lateks/view/weight_list/providers/stock_provider.dart';

class AddbBarrelsDRC extends StatelessWidget {
  const AddbBarrelsDRC({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StockProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Weight List'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              PrimaryTextField(
                  hintText: 'DRC %', controller: provider.drcController),
              const SizedBox(height: 15),
              PrimaryTextField(
                  hintText: 'Amount', controller: provider.amountController),
              const SizedBox(height: 15),
              PrimaryTextField(
                  hintText: 'Advance Amount',
                  controller: provider.advanceController),
              const SizedBox(height: 15),
              PrimaryTextField(
                  hintText: 'Dry Weight',
                  controller: provider.dryWeightController),
              const SizedBox(height: 15),
              PrimaryTextField(
                  hintText: 'Total Amount',
                  controller: provider.totalAmountController),
              const SizedBox(height: 15),
              PrimaryButton(label: 'Gnerate', onTap: () {})
            ],
          ),
        ),
      ),
    );
  }
}
