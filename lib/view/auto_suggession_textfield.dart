import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:star_lateks/core/app_spacing.dart';

class AutoSuggestionText extends StatelessWidget {
  final TextEditingController controller;

  final List<String> list;
  final String label;
  final String hint;

  const AutoSuggestionText(
      {super.key,
      required this.controller,
      required this.list,
      this.hint = '',
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        AppSpacing.h10,
        TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
              style: const TextStyle(fontSize: 16),
              controller: controller,
              autofocus: false,
              decoration: InputDecoration(
                hintText: hint,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: const BorderRadius.all(Radius.circular(4.0))),
                contentPadding: const EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: const BorderRadius.all(Radius.circular(4.0))),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: const BorderRadius.all(Radius.circular(4.0))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: const BorderRadius.all(Radius.circular(4.0))),
              )),
          suggestionsCallback: (pattern) => list.where(
              (item) => item.toLowerCase().contains(pattern.toLowerCase())),
          itemBuilder: (context, String item) => ListTile(
            title: Text(item),
          ),
          noItemsFoundBuilder: (context) => const SizedBox(),
          getImmediateSuggestions: true,
          hideSuggestionsOnKeyboardHide: false,
          hideOnEmpty: false,
          onSuggestionSelected: (String val) {
            controller.text = val;
          },
        ),
      ],
    );
  }
}
