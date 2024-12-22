import 'package:adhiv_medical/util/my_sidebar.dart';
import 'package:adhiv_medical/view/save_data_page.dart';
import 'package:adhiv_medical/view/show_table_data.dart';
import 'package:adhiv_medical/view/temp.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

import 'mk_reciept_page.dart';

class TriggerPage extends StatelessWidget {
  TriggerPage({super.key});

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  final screens = [
    // ProductListPage(),
    ProductEntryForm(),
    // DataPage(),
    ShowTableData(),
    SaveDataPage(),
    MkReceiptPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          key: _key,
          body: Row(
            children: [
              MySidebar(controller: _controller),
              Expanded(
                child: Center(
                    child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return screens[_controller.selectedIndex];
                  },
                )),
              ),
            ],
          ),
        );
      },
    );
  }
}
