
final String tableContact =  'tbl_contact';
final String colContactName = 'contact_name';
final String colContactCompany = 'contact_company';
final String colContactDesignation = 'contact_designation';
final String colContactAddress = 'contact_address';
final String colContactPhone = 'contact_phone';
final String colContactEmail = 'contact_email';
final String colContactWeb = 'contact_web';
final String colContactId = 'contact_id';


class ContactModel{
  int? contactId ;
  String? contactName;
  String? company;
  String? designation;
  String? address;
  String? phone;
  String? email;
  String? website;
  String? image;

  ContactModel(
      {

        this.contactId,
        this.contactName,
        this.company,
         this.designation ,
          this.address,
         this.phone,
         this.email,
         this.website ,
         this.image
      });

  Map<String,dynamic> toMap(){

    var map = <String,dynamic>{

      colContactDesignation: designation,
      colContactName: contactName,
      colContactAddress: address,
      colContactCompany: company,
      colContactPhone: phone,
      colContactEmail: email,
      colContactWeb: website,
    };
    if(contactId != null ){
      map[colContactId] = contactId;
    };

    return map;

  }

  ContactModel.fromMap(Map<String, dynamic> map){

    contactId = map[colContactId];
    contactName = map[colContactName];
    designation = map[colContactDesignation];
    address = map[colContactAddress];
    company = map[colContactCompany];
    phone = map[colContactPhone];
    email = map[colContactEmail];
    website = map[colContactWeb];


  }



  @override
  String toString() {
    return 'ContactModel{contactName: $contactName, company: $company, designation: $designation, address: $address, phone: $phone, email: $email, website: $website, image: $image}';
  }
}
