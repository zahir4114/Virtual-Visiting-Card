

import 'package:flutter/material.dart';
import 'package:virtual_card_scanner/db/actual_db.dart';
import 'package:virtual_card_scanner/models/contact_model.dart';

class ContactDetailsPage extends StatefulWidget {
  static final String routeName = '/contact_details';



  @override
  _ContactDetailsPageState createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  ContactModel? contactModel;
int contactId = 0;
String? contactName;


@override
  void didChangeDependencies() {
    final args  = ModalRoute.of(context)?.settings.arguments as List;
    contactId = args[0];
    contactName = args[1];

    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contactName!),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),

            child: FutureBuilder<ContactModel>(
              future: DBSqlite.getContactByRowId(contactId),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  contactModel = snapshot.data;
                  return Column(

                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('images/noimage.jpg', width: double.maxFinite,height: 205,fit: BoxFit.cover, ),
                          //child: Image.asset('images/noimage.jpg'),
                        ),
                      ),
                      ListTile(
                        title: Text(contactModel!.contactName!),
                        subtitle: Text(contactModel!.designation!),
                      )
                    ],

                  );
                }
                if(snapshot.hasError){
                  return Text('failed to bal coda');
                }

                return CircularProgressIndicator();

              },
            ),

        ),
      ),
    );
  }
}
