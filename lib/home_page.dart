import 'package:adhiv_medical/save_data_page.dart';
import 'package:flutter/material.dart';

import 'ListPage.dart';
import 'db_helper.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                try {
                  var result = await DBHelper().myFun();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListPage(result: result),
                    ),
                  );
                } catch (e) {
                  // Handle errors if needed
                  // print("Error: $e");
                }
              },
              child: const Text("Show"),
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SaveDataPage(),
                    ));
              },
              child: const Text("name page"),
            ),
          ],
        ),
      ),
    );
  }
}
