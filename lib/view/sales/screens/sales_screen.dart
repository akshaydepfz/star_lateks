import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/common/primary_button.dart';
import 'package:star_lateks/common/primary_text_field.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/sales/providers/sales_provider.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  void initState() {
    Provider.of<SalesProvider>(context, listen: false).getShopList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SalesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Sales'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              AppSpacing.h10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Customer',
                    style: TextStyle(fontSize: 16),
                  ),
                  AppSpacing.h10,
                  TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                        style: const TextStyle(fontSize: 16),
                        controller: provider.shopController,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Select Shop',
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0))),
                          contentPadding: const EdgeInsets.all(10),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0))),
                          disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0))),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0))),
                        )),
                    suggestionsCallback: (pattern) => provider.shopList
                        .map((e) => e.name)
                        .toList()
                        .where((item) =>
                            item.toLowerCase().contains(pattern.toLowerCase())),
                    itemBuilder: (context, String item) => ListTile(
                      title: Text(item),
                    ),
                    noItemsFoundBuilder: (context) => const SizedBox(),
                    getImmediateSuggestions: true,
                    hideSuggestionsOnKeyboardHide: false,
                    hideOnEmpty: false,
                    onSuggestionSelected: (String val) {
                      provider.shopController.text = val;
                      provider.getShopValue(val);
                    },
                  ),
                ],
              ),
              AppSpacing.h20,
              PrimaryTextField(
                  hintText: 'Vehicle Weight',
                  controller: provider.vehichleController),
              AppSpacing.h20,
              PrimaryTextField(
                  hintText: 'Net Weight',
                  controller: provider.netWeightController),
              AppSpacing.h20,
              PrimaryTextField(
                  hintText: 'Advance Amount',
                  controller: provider.advanceController),
              AppSpacing.h20,
              PrimaryButton(
                  isLoading: provider.isLoading,
                  label: 'Supply to Shop',
                  onTap: () {
                    provider.addSales(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
