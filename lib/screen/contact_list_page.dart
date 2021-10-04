import 'package:flutter/material.dart';
import 'package:virtual_card_scanner/custom_widget/contact_row_item.dart';
import 'package:virtual_card_scanner/db/actual_db.dart';
import 'package:virtual_card_scanner/models/contact_model.dart';

import 'scan_pages.dart';

class ContactList extends StatefulWidget {

  static final String routeName = '/';


  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact list '),
      ),
      body:  Center(
        child: FutureBuilder<List<ContactModel>> (
          future: DBSqlite.getAllContact() ,
          builder: (context, snapshot){
            if(snapshot.hasData){
              final contactList = snapshot.data!;
             return ListView.builder(

                  itemCount: contactList.length,
                  itemBuilder: (context,index)=> ContactRowItem(contactList[index], index)
              );
            }
            if(snapshot.hasError){
              return Text('failed to fetch data');
            }
            return CircularProgressIndicator();

          }
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, ScanPages.routeName,);
          },
         child: Icon(Icons.add),
      ),

    );
  }
}
