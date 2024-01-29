import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/auto_suggession_textfield.dart';
import 'package:star_lateks/view/sales/providers/sales_provider.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SalesProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              AppSpacing.h10,
              AutoSuggestionText(
                  controller: provider.shopController,
                  list: [],
                  label: 'Select Customer'),
            ],
          ),
        ),
      ),
    );
  }
}
