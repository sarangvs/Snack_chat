import 'package:chat_app/domain/entities/country_entity.dart';
import 'package:chat_app/presentation/auth/cubit/country_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<CountryCubit, CountryState>(
      builder: (context, state) {
        if (state is CountryLoading) {
          return const CircularProgressIndicator();
        } else if (state is CountryLoaded) {
          return TypeAheadField<CountryEntity>(
            suggestionsCallback: (search) async {
              return state.countries
                  .where(
                    (item) =>
                        item.name.toLowerCase().contains(search.toLowerCase()),
                  )
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
              return ListTile(title: Text(item.name));
            },
            onSelected: (country) {
              controller?.text = country.name;
              // onSelected(country.name);
            },
          );
        } else if (state is CountryError) {
          return Text(state.message, style: TextStyle(color: Colors.red));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
