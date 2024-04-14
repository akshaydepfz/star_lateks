import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/common/primary_button.dart';
import 'package:star_lateks/common/primary_text_field.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/weight_list/providers/weight_list_provider.dart';

class AddBarelsScreen extends StatelessWidget {
  const AddBarelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeightListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Barrels'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              AppSpacing.h20,
              PrimaryTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Weight',
                  controller: provider.grossWeight),
              AppSpacing.h20,
              PrimaryButton(
                  label: 'Add Barrel',
                  onTap: () => provider.addBarrels(context)),
              AppSpacing.h20,
            ],
          ),
        ),
      ),
    );
  }
}
