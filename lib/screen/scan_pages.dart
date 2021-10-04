import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_card_scanner/models/contact_model.dart';
import 'package:virtual_card_scanner/screen/add_contact.dart';

var _temp = [];
bool checked = false;


class ScanPages extends StatefulWidget {
  static final String routeName = '/scan_page';



  @override
  _ScanPagesState createState() => _ScanPagesState();
}

class _ScanPagesState extends State<ScanPages> {
  final contactModel = ContactModel();
  ImageSource imageSource = ImageSource.camera;
  String? imagePath;
  List<String> lines = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Scan Page '),
          actions: [
            IconButton(onPressed: (){

              Navigator.pushNamed(context, AddContact.routeName, arguments: contactModel );

            }, icon: Icon(Icons.arrow_forward_ios))
          ],
    ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 150,
                    width: 250,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: imagePath == null? Text('no image') :Image.file(File(imagePath!),fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(width: 10,),

                Column(
                  children: [
                    ElevatedButton(onPressed: (){
                      imageSource = ImageSource.camera;
                      _scanImage();
                    }, child: Text('Camera')),
                    ElevatedButton(onPressed: (){
                      imageSource = ImageSource.gallery;
                      _scanImage();
                    }, child: Text('Gallery')),
                  ],
                )

              ],
            ),
            SizedBox(height: 10,),
            Divider(height: 2,color: Colors.black,),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: lines.length,
                  itemBuilder: (context, i)=> LineItems(lines[i]),

              ),
            ),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildPropertyButton('Contact Name'),
                  buildPropertyButton('Designation'),
                  buildPropertyButton('Company'),
                  buildPropertyButton('Address'),
                  buildPropertyButton('Email'),
                  buildPropertyButton('Phone'),
                  buildPropertyButton('Website')
                ],

              ),
            )
          ],

        ),
      )
    );
  }

  Widget buildPropertyButton(String property) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
                      onPressed: (){
                        assignPropertyToContactModel(property);
                        setState(() {
                          checked = false;
                        });
                      },
                      child: Text(property)),
    );
  }
   void _scanImage() async{
    XFile? file = await ImagePicker().pickImage(source: imageSource);
    setState(() {
      imagePath = file!.path ;
    });
    if(imagePath != null){

      final inputImage = InputImage.fromFilePath(imagePath!);
      final textDetector = GoogleMlKit.vision.textDetector();
      final recognizedText = await textDetector.processImage(inputImage);
      var temp = <String> [];
      for(var block in recognizedText.blocks){
        for(var line in block.lines){
          temp.add(line.text);
        }
      }

      setState(() {
        lines = temp;
      });

    }


   }


  void assignPropertyToContactModel(String property) {
    final  item = _temp.join(' ');
    switch(property){
      case 'Contact Name':

        contactModel.contactName = item;
        break;
      case 'Company':

        contactModel.company = item;
        break;
      case 'Designation':

        contactModel.designation = item;
        break;
      case 'Address':

        contactModel.address = item;
        break;
      case 'Email':

        contactModel.email = item;
        break;
      case 'Phone':

        contactModel.phone = item;
        break;
      case 'Website':

        contactModel.website = item;
        break;
      case 'Contact Name':

        contactModel.contactName = item;
        break;
    }
    _temp = [];
    print(contactModel.toString());
  }
}
class LineItems extends StatefulWidget {
 // const LineItems({Key? key}) : super(key: key);
  String line;


  LineItems(this.line);


  @override
  _LineItemsState createState() => _LineItemsState();
}

class _LineItemsState extends State<LineItems> {


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.line),
      trailing: Checkbox(
        value : checked,
        onChanged: (value){
          setState(() {
            checked = value!;
          });
          value! ? _temp.add(widget.line) : _temp.remove(widget.line);

        },
      ),
    );
  }
}


