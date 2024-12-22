import 'package:flutter/material.dart';

import 'decoration.dart';

final today = DateUtils.dateOnly(DateTime.now());

class DateSelector extends StatefulWidget {
  final TextEditingController dateController;
  const DateSelector({Key? key, required this.dateController})
      : super(key: key);

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 200,
      child: TextField(
        controller: widget.dateController,
        decoration: InputDecoration(
          labelText: "Exp Date",
          filled: true,
          fillColor: Colors.grey[200],
          prefixIcon: const Icon(Icons.calendar_today),
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
        onTap: () => _selectDate(),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      widget.dateController.text = picked.toString().split(" ")[0];
    }
  }
}
