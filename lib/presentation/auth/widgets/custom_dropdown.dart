import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomSearchDropdown extends StatelessWidget {
  final List<String> data;
  final void Function(String) onSelected;
  final String labelText;
  final TextEditingController? controller;

  const CustomSearchDropdown({
    super.key,
    required this.data,
    required this.onSelected,
    this.labelText = 'City',
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      suggestionsCallback: (search) async {
        return data
            .where((item) => item.toLowerCase().contains(search.toLowerCase()))
            .toList();
      },
      builder: (context, fieldController, focusNode) {
        return TextField(
          controller: controller ?? fieldController,
          focusNode: focusNode,
          decoration: InputDecoration(
            filled: true,
            suffixIcon: const Icon(Icons.arrow_drop_down),
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),

            hintText: labelText,
          ),
        );
      },
      itemBuilder: (context, item) {
        return ListTile(title: Text(item));
      },
      onSelected: onSelected,
    );
  }
}
