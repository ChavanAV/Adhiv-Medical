import 'package:flutter/material.dart';

class myAlert extends StatelessWidget {
  const myAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Text("data"),
        Text("tata"),
      ],
    );
  }
}

void showAlertDialog(
    BuildContext context, Function()? onYesPress, Function()? onNoPress) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Alert'),
        content: const Text('Do you want to proceed?'),
        actions: <Widget>[
          TextButton(
            onPressed: onNoPress,
            child: const Text('No'),
          ),
          TextButton(
            onPressed: onYesPress,
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
