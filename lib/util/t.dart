// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class CustomDatePickerTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final String labelText;
//   final DateTime initialDate;
//   final DateTime firstDate;
//   final DateTime lastDate;
//   final DateFormat dateFormat;
//
//   const CustomDatePickerTextField({
//     Key? key,
//     required this.controller,
//     required this.labelText,
//     this.initialDate = const DateTime.now(),
//     this.firstDate = const DateTime(2000),
//     this.lastDate = DateTime(2100),
//     this.dateFormat = DateFormat('dd-MM-yyyy'),
//   }) : super(key: key);
//
//   @override
//   _CustomDatePickerTextFieldState createState() => _CustomDatePickerTextFieldState();
// }
//
// class _CustomDatePickerTextFieldState extends State<CustomDatePickerTextField> {
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: widget.initialDate,
//       firstDate: widget.firstDate,
//       lastDate: widget.lastDate,
//     );
//     if (picked != null) {
//       widget.controller.text = widget.dateFormat.format(picked);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: widget.controller,
//       decoration: InputDecoration(
//         labelText: widget.labelText,
//         suffixIcon: IconButton(
//           icon: const Icon(Icons.calendar_today),
//           onPressed: () => _selectDate(context),
//         ),
//         filled: true,
//         fillColor: Colors.grey[200],
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5.0),
//           borderSide: const BorderSide(
//             color: Colors.blueAccent,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5.0),
//           borderSide: const BorderSide(
//             color: Colors.blueAccent,
//           ),
//         ),
//       ),
//       readOnly: true,
//     );
//   }
// }
