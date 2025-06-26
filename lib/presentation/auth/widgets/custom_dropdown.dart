import 'package:chat_app/domain/entities/country_entity.dart';
import 'package:chat_app/presentation/auth/cubit/country_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomSearchDropdown extends StatefulWidget {
  final void Function(String) onSelected;
  final String? labelText;
  final TextEditingController? controller;

  const CustomSearchDropdown({
    super.key,

    required this.onSelected,
    this.labelText = "Country",
    this.controller,
  });

  @override
  State<CustomSearchDropdown> createState() => _CustomSearchDropdownState();
}

class _CustomSearchDropdownState extends State<CustomSearchDropdown> {
  String? selectedCountry;
  late TextEditingController _fieldController;

  @override
  void initState() {
    super.initState();
    _fieldController = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryCubit, CountryState>(
      buildWhen: (previous, current) => current is! CountryError,
      builder: (context, state) {
        List<CountryEntity> countries = [];
        bool isLoading = false;

        if (state is CountryLoading) {
          isLoading = true;
        } else if (state is CountryLoaded) {
          countries = state.countries;
        }
        if (state is CountryLoaded) {
          return TypeAheadField<CountryEntity>(
            suggestionsCallback: (search) async {
              return countries
                  .where(
                    (item) =>
                        item.name.toLowerCase().contains(search.toLowerCase()),
                  )
                  .toList();
            },
            builder: (context, fieldController, focusNode) {
              _fieldController = fieldController;

              return TextField(
                controller: fieldController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon:
                      isLoading
                          ? Transform.scale(
                            scale: 0.5,
                            child: CircularProgressIndicator(),
                          )
                          : Icon(Icons.arrow_drop_down),
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),

                  hintText: selectedCountry ?? widget.labelText,
                ),
              );
            },
            itemBuilder: (context, item) {
              return ListTile(title: Text(item.name));
            },
            onSelected: (country) {
              setState(() {
                selectedCountry = country.name;
              });

              _fieldController.text = country.name;
              widget.onSelected(country.name);
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
