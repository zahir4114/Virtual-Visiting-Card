import 'package:flutter/material.dart';
import 'package:virtual_card_scanner/db/actual_db.dart';
import 'package:virtual_card_scanner/models/contact_model.dart';
import 'package:virtual_card_scanner/screen/contact_details_page.dart';
import 'package:virtual_card_scanner/utility/helper.dart';



class ContactRowItem extends StatefulWidget {

  final ContactModel contactModel;
  int index;


  ContactRowItem(this.contactModel, this.index);

  @override
  _ContactRowItemState createState() => _ContactRowItemState();
}

class _ContactRowItemState extends State<ContactRowItem> {
  @override
  Widget build(BuildContext context) {
    return  Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.green,
        child: Icon(Icons.delete, size: 30, color: Colors.white,),
      ),
      onDismissed: (_){
        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text('Delete ${widget.contactModel.contactName}?'),
          content: Text('Are you sure to delete this contact'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context,false);
            }, child: Text('Cancel')
            ),
            ElevatedButton(onPressed: (){
              Navigator.pop(context,true);
              DBSqlite.deleteContact(widget.contactModel.contactId!);
              showMsg(context, 'Deleted');
            }, child: Text('Delete')
            )
          ],
        ));
      },
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
              onTap: (){

                Navigator.pushNamed(
                    context,
                    ContactDetailsPage.routeName,
                    arguments:[ widget.contactModel.contactId, widget.contactModel.contactName]
                );

              },
              title: Text(widget.contactModel.contactName!),
              subtitle: Text(widget.contactModel.company!),
              leading: CircleAvatar(
                backgroundImage: AssetImage('images/noimage.jpg')
              ),
              trailing: IconButton(
                icon: Icon(Icons.favorite_border),

                onPressed: (){},
              ),

          ),
        ),
      ),
    );
  }
}
