import 'package:flutter/material.dart';
import 'package:virtual_card_scanner/screen/scan_pages.dart';
import 'package:virtual_card_scanner/screen/contact_details_page.dart';
import 'package:virtual_card_scanner/screen/contact_list_page.dart';
import 'package:virtual_card_scanner/screen/add_contact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

        routes: {
        ContactList.routeName:(context)=> ContactList(),
       ContactDetailsPage.routeName:(context)=> ContactDetailsPage(),
       ScanPages.routeName:(context)=> ScanPages(),
       AddContact.routeName:(context)=> AddContact(),
        },
    );
  }
}
