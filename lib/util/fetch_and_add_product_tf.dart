import 'package:adhiv_medical/controller/db_helper.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';

import 'decoration.dart';

class FetchAndAddProductNameTF extends StatefulWidget {
  final TextEditingController controller;
  const FetchAndAddProductNameTF({super.key, required this.controller});

  @override
  _FetchAndAddProductNameTFState createState() =>
      _FetchAndAddProductNameTFState();
}

class _FetchAndAddProductNameTFState extends State<FetchAndAddProductNameTF> {
  List<String> names = [];
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    fetchNames();
  }

  void fetchNames() async {
    names = await dbHelper.fetchName();
    setState(() {});
  }

  List<String> getSuggestions(String query) {
    if (names.isEmpty) return [];
    return names
        .where((s) => s.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        suggestionBoxController.close();
      },
      child: DropDownSearchFormField(
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            labelText: "labelText",
            hintText: "hintText",
            filled: true,
            fillColor: Colors.grey[200],
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: primaryColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: primaryColor,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          ),
          controller: widget.controller,
        ),
        suggestionsCallback: (pattern) {
          return getSuggestions(pattern);
        },
        itemBuilder: (context, String suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        itemSeparatorBuilder: (context, index) {
          return const Divider();
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSuggestionSelected: (String suggestion) {
          setState(() {
            widget.controller.text = suggestion;
          });
        },
        suggestionsBoxController: suggestionBoxController,
        validator: (value) => value!.isEmpty ? 'Please select a name' : null,
        displayAllSuggestionWhenTap: true,
      ),
    );
  }
}
