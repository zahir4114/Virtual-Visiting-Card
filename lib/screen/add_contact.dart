import 'package:flutter/material.dart';
import 'package:virtual_card_scanner/db/actual_db.dart';
import 'package:virtual_card_scanner/models/contact_model.dart';
import 'package:virtual_card_scanner/screen/contact_list_page.dart';

class AddContact extends StatefulWidget {
  static final String routeName = '/add_contact';

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  var contactModal = ContactModel();

  final nameController = TextEditingController();
  final designationController = TextEditingController();
  final companyController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final webController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    designationController.dispose();
    companyController.dispose();
    addressController.dispose();
    phoneController.dispose();
    emailController.dispose();
    webController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    contactModal = ModalRoute.of(context)!.settings.arguments as ContactModel;
    _setTextFieldsValues();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact page'),
        actions: [
          IconButton(onPressed: saveContact, icon: Icon(Icons.save))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Card(
          child: ListView(
            padding: EdgeInsets.all(12.0),
            children:[
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Contact Name',
                border: OutlineInputBorder()
              ),
              validator: (value){
                if(value!.isEmpty){
                  return ' This Field must be validate';
                }
                return null;
             },
              onSaved: (value){
                contactModal.contactName =value;
              },
            ),
              SizedBox(height: 8,),
              TextFormField(
                controller: companyController,
                decoration: InputDecoration(
                    labelText: 'Company',
                    border: OutlineInputBorder()
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return ' This Field must be validate';
                  }
                  return null;
                },
                onSaved: (value){
                  contactModal.company =value;
                },
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: designationController,
                decoration: InputDecoration(
                    labelText: 'Designation',
                    border: OutlineInputBorder()
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return ' This Field must be validate';
                  }
                  return null;
                },
                onSaved: (value){
                  contactModal.designation =value;
                },
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder()
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return ' This Field must be validate';
                  }
                  return null;
                },
                onSaved: (value){
                  contactModal.address =value;
                },
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder()
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return ' This Field must be validate';
                  }
                  return null;
                },
                onSaved: (value){
                  contactModal.phone =value;
                },
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder()
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return ' This Field must be validate';
                  }
                  return null;
                },
                onSaved: (value){
                  contactModal.email =value;
                },
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: webController,
                decoration: InputDecoration(
                    labelText: 'WebSite',
                    border: OutlineInputBorder()
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return ' This Field must be validate';
                  }
                  return null;
                },
                onSaved: (value){
                  contactModal.website =value;
                },
              ),
            ]
          ),
        ),
      ),
    );
  }

  void _setTextFieldsValues() {
    nameController.text = contactModal.contactName?? 'unknown';
    companyController.text = contactModal.company?? 'unknown';
    designationController.text = contactModal.designation?? 'unknown';
    addressController.text = contactModal.address?? 'unknown';
    phoneController.text = contactModal.phone?? 'unknown';
    emailController.text = contactModal.email?? 'unknown';
    webController.text = contactModal.website?? 'unknown';
  }

  void saveContact() {
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      print(contactModal);
      DBSqlite.insertNewContact(contactModal).then((id){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('saved')));
        Navigator.pushNamedAndRemoveUntil(context, ContactList.routeName, (route) => false);
      })
          .catchError((error){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('failed')));
        throw error;
      });
    }
  }
}
