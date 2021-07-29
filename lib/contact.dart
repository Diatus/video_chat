import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Help',style: GoogleFonts.poppins(color: Colors.black,)),
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
          Navigator.pop(context);
        },),
        backgroundColor: Colors.white,elevation: 1,),
      body: ListView(children: [
        SizedBox(height: 40,),
        ListTile(title: Text('Phone No',style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5))),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('+1 12345 123415,  +1 12541 12543',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(height: 10,),
        ListTile(title: Text('Email',style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5))),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('Companyname@xyz.com',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(height: 10,),
        ListTile(title: Text('Office Address',style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5))),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('Xyz, Hudson, Oh 51024',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(height: 10,),
      ],),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 24,left: 32,right: 32),
        child: Container(width: MediaQuery.of(context).size.width*0.8,
          height: 50,
          child: MaterialButton(elevation: 0,
              color: Color(0xfff6615e),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32),side: BorderSide(color: Color(0xffffffff))),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 52.0),
                child: Text("Drop a message", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
              onPressed: () {

              }
          ),
        ),
      ),
    );
  }
}
