import 'package:adhiv_medical/controller/db_helper.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';

import 'decoration.dart';

class FetchAndAddListTF extends StatefulWidget {
  final TextEditingController controller;
  final String labelName;
  const FetchAndAddListTF(
      {super.key, required this.controller, required this.labelName});

  @override
  _FetchAndAddListTFState createState() => _FetchAndAddListTFState();
}

class _FetchAndAddListTFState extends State<FetchAndAddListTF> {
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              width: labelAndTFSpacing,
              child: Text(
                widget.labelName,
                style: labelTS,
              )),
          Flexible(
            child: SizedBox(
              height: 30,
              width: 300,
              child: DropDownSearchFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                        color: primaryColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                        color: primaryColor,
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
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
                validator: (value) =>
                    value!.isEmpty ? 'Please select a name' : null,
                displayAllSuggestionWhenTap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
