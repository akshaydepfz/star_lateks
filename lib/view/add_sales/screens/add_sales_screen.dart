// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:provider/provider.dart';
// import 'package:star_lateks/core/app_spacing.dart';
// import 'package:star_lateks/view/add_sales/services/add_sales_service.dart';

// class AddSalesScreen extends StatelessWidget {
//   const AddSalesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<SalesService>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Sales'),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Select Customer',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 AppSpacing.h10,
//                 TypeAheadField(
//                   textFieldConfiguration: TextFieldConfiguration(
//                       style: const TextStyle(fontSize: 16),
//                       controller: provider.controller,
//                       autofocus: false,
//                       decoration: InputDecoration(
//                         hintText: 'Select Customer',
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey.shade300),
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(4.0))),
//                         contentPadding: const EdgeInsets.all(10),
//                         enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey.shade300),
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(4.0))),
//                         disabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey.shade300),
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(4.0))),
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey.shade300),
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(4.0))),
//                       )),
//                   suggestionsCallback: (pattern) => provider.customerList
//                       .map((e) => e.name)
//                       .toList()
//                       .where((item) =>          
//                           item.toLowerCase().contains(pattern.toLowerCase())),
//                   itemBuilder: (context, String item) => ListTile(
//                     title: Text(item),
//                   ),
//                   noItemsFoundBuilder: (context) => const SizedBox(),
//                   getImmediateSuggestions: true,
//                   hideSuggestionsOnKeyboardHide: false,
//                   hideOnEmpty: false,
//                   onSuggestionSelected: (String val) {
//                     provider.getCustomerValues(val);
//                     provider.controller.text = val;
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
