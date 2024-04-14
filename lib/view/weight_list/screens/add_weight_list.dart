import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:star_lateks/common/primary_button.dart';
import 'package:star_lateks/common/whatsapp_button.dart';
import 'package:star_lateks/core/app_spacing.dart';
import 'package:star_lateks/view/weight_list/providers/weight_list_provider.dart';
import 'package:star_lateks/view/weight_list/screens/add_barels.dart';
import '../../../common/primary_text_field.dart';

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          controller: provider.customerController,
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: 'Select Customer',
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0))),
                            contentPadding: const EdgeInsets.all(10),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0))),
                            disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0))),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0))),
                          )),
                      suggestionsCallback: (pattern) => provider.customerList
                          .map((e) => e.name)
                          .toList()
                          .where((item) => item
                              .toLowerCase()
                              .contains(pattern.toLowerCase())),
                      itemBuilder: (context, String item) => ListTile(
                        title: Text(item),
                      ),
                      noItemsFoundBuilder: (context) => const SizedBox(),
                      getImmediateSuggestions: true,
                      hideSuggestionsOnKeyboardHide: false,
                      hideOnEmpty: false,
                      onSuggestionSelected: (String val) {
                        provider.getCustomerValues(val);
                        provider.customerController.text = val;
                      },
                    ),
                  ],
                ),
                // AutoSuggestionText(
                //     controller: provider.customerController,
                //     list: provider.customerList.map((e) => e.name).toList(),
                //     label: 'Select Customer'),
                AppSpacing.h20,

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddBarelsScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.deepPurple,
                        ),
                        AppSpacing.w10,
                        Text(
                          'Add Barrels',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                AppSpacing.h20,
                Visibility(
                  visible: provider.barrelsCountList.isNotEmpty,
                  child: const Text(
                    'Barrels',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.barrelsCountList.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(5)),
                        child: ListTile(
                          leading: Text(
                            "${i + 1}.",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                              "Gross Weight : ${provider.barrelsCountList[i].grossWeight}"),
                          subtitle: Text(
                            'ID ${i + 12672345}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              provider.removeBarrels(i);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    }),
                AppSpacing.h10,
                PrimaryTextField(
                    label: 'Balance Barrels',
                    keyboardType: TextInputType.number,
                    hintText: 'Balance Barrels',
                    controller: provider.balanceBarrels),
                AppSpacing.h20,
                PrimaryTextField(
                    label: 'Placed Barrels',
                    keyboardType: TextInputType.number,
                    hintText: 'Placed Barrels',
                    controller: provider.placedBarrels),
                AppSpacing.h20,
                PrimaryTextField(
                    keyboardType: TextInputType.number,
                    hintText: 'Enter Advance Amount',
                    label: 'Advance Amount',
                    controller: provider.advancePaidControl),
                AppSpacing.h20,
                PrimaryButton(
                  label: 'Generate Bill',
                  onTap: () => provider.generateInvoice(context),
                ),
                AppSpacing.h20,
                WhatsappButton(
                    label: 'Send bill to whatsapp',
                    onTap: () {
                      provider.generatePDFToBill(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
