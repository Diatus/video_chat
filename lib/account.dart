import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reach/services/auth.dart';
import 'edit_account.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  var user;
  String url;
  String first;
  String last;
  String phone;
  String mail;
  String address;
  String occupation;
  String hobbies;

  Future _get()async{
    user=await UserServices().getUserProfile();
    if(user!=null){
      setState(() {
        url=user['profile'];
        first=user['first'];
        last=user['last'];
        phone=user['phone'];
        mail=user['mail'];
        address=user['address'];
        occupation=user['occupation'];
        hobbies=user['hobbies'];
      });
    }
    return user;
  }

  @override
  void initState() {
    // TODO: implement initState
    _get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(elevation: 0,title: Text('My Profile',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.normal)),backgroundColor: Colors.white,
      leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
        Navigator.pop(context);
      },),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 18,top: 18),
        child: GestureDetector(child: Text('Edit',style: TextStyle(color: Color(0xfff6615e)),),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>EditAccount()));
        },),
      )
    ],),
    body: FutureBuilder<Object>(
      future: _get(),
      builder: (context, snapshot) {
        return ListView(children: [
          Container(height: MediaQuery.of(context).size.width*0.55,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(bottomRight: Radius.circular(42)),
                boxShadow: [
                  BoxShadow(color: Colors.grey,blurRadius: 8,),
                  BoxShadow(color: Colors.grey),
                ]
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [
              Container(width: 90,height: 90,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(95.0),
                  child: url!=null&&url.isNotEmpty?CachedNetworkImage(imageUrl: url,fit: BoxFit.cover,width: 60,height: 60,):
                  CircleAvatar(backgroundColor: Color(0xfff6615e),radius: 18,
                    child: Icon(Icons.perm_identity,size: 50,color: Colors.white,),
                  ),),
              ),
              SizedBox(height: 10,),
              Text(first??'Guest',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold)),
              Text(phone??'+91 xxxxxxxx',style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5),fontWeight: FontWeight.normal)),
            ],),
          ),
          SizedBox(height: 30),
          ListTile(title: Text('Email',style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5))),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(mail??'xyz@gmail.com',style: GoogleFonts.poppins(color: Colors.black)),
            ),
          ),
          SizedBox(height: 10,),
          ListTile(title: Text('Address',style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5))),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(address??'xyz,delhi,india-140413',style: GoogleFonts.poppins(color: Colors.black)),
            ),
          ),
          SizedBox(height: 10,),
          ListTile(title: Text('Occupation',style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5))),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(occupation??'Developer',style: GoogleFonts.poppins(color: Colors.black)),
            ),
          ),
          SizedBox(height: 10),
          ListTile(title: Text('Hobbies',style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5))),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(hobbies??"Playing Football, Reading Books, Playing Video Games",style: GoogleFonts.poppins(color: Colors.black)),
            ),
          ),
        ],);
      }
    ),);
  }
}
