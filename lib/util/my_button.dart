import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonName;
  final void Function()? onPress;
  const MyButton({
    super.key,
    required this.buttonName,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 120,
      // decoration: BoxDecoration(
      //   gradient: const LinearGradient(
      //     colors: [Colors.green, Colors.lightGreenAccent],
      //     begin: Alignment.centerLeft,
      //     end: Alignment.centerRight,
      //   ),
      //   borderRadius: BorderRadius.circular(8),
      // ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [
      //       actionColor,
      //       primaryColor,
      //     ],
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //   ),
      //   borderRadius: BorderRadius.circular(25),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withOpacity(0.2),
      //       spreadRadius: 2,
      //       blurRadius: 6,
      //       offset: const Offset(0, 3),
      //     ),
      //   ],
      // ),
      child: ElevatedButton(
        onPressed: () => onPress!(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          shadowColor: Colors.transparent,
          alignment: Alignment.center,
          elevation: 5, // Normal elevation
        ).copyWith(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.white.withOpacity(0.3); // Change color on tap
              }
              return Colors.transparent;
            },
          ),
          shadowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black.withOpacity(0.7); // Increase shadow on tap
              }
              return Colors.transparent;
            },
          ),
          elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return 10; // Increase elevation on tap
              }
              return 5; // Normal elevation
            },
          ),
        ),
        child: Text(
          buttonName,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
