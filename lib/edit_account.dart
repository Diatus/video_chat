import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:reach/services/auth.dart';


class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController first =new TextEditingController();
  TextEditingController last =new TextEditingController();
  TextEditingController mail =new TextEditingController();
  TextEditingController phone =new TextEditingController();
  TextEditingController address =new TextEditingController();
  TextEditingController occupation =new TextEditingController();
  TextEditingController hobbies =new TextEditingController();
  File img;
  String url;

  var user;

  Future _get()async{
    user=await UserServices().getUserProfile();
    if(user!=null){
      first.text=user['first'];
      last.text=user['last'];
      mail.text=user['mail'];
      phone.text=user['phone'];
      address.text=user['address'];
      occupation.text=user['occupation'];
      hobbies.text=user['hobbies'];
      setState(() {

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _get();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if(first.text.length>1&&last.text.length>1&&phone.text.length>5&&mail.text.length>5){
          Navigator.pop(context);
        }else{
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please provide your basic information',textAlign: TextAlign.center,)));
        }
      },
      child: Scaffold(key: _scaffoldKey,appBar: AppBar(elevation: 0,automaticallyImplyLeading: false,
        title: Text('Edit Profile',style: GoogleFonts.poppins(fontWeight: FontWeight.normal,color: Colors.black)),backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18,top: 18),
            child: GestureDetector(child: Text('Cancel',style: TextStyle(color: Color(0xfff6615e)),),
              onTap: (){
              if(first.text.length>1&&last.text.length>1&&phone.text.length>5&&mail.text.length>5){
                Navigator.pop(context);
              }else{
                _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please provide your basic information',textAlign: TextAlign.center,)));
              }
              },),
          )
        ],),
        body: ListView(children: [
          Center(
            child: Container(width: 90,height: 90,
              child: Stack(
                children: [
                  Container(width: 90,height: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(95.0),
                      child: img!=null?Image.file(img,width: 60,height: 60,):
                      url!=null&&url.isNotEmpty?CachedNetworkImage(imageUrl: url,fit: BoxFit.cover,width: 60,height: 60,):
                      CircleAvatar(backgroundColor: Color(0xfff6615e),radius: 18,
                        child: Icon(Icons.perm_identity,size: 50,color: Colors.white,),
                      ),),
                  ),
                  Align(alignment: Alignment.bottomRight,
                    child: CircleAvatar(backgroundColor: Color(0xfff6615e),radius: 18,
                      child: IconButton(icon: Icon(Icons.add_a_photo_outlined,size: 20,color: Colors.white,),
                          onPressed: () async {
                            final image = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 512, maxHeight: 512, imageQuality: 70);
                            if(image!=null){
                              setState(() {
                                img=image;
                              });
                            }
                    }),
                    ),
                  )
                ],
              ),
            ),
          ),
          _textEdit(first, 'First Name'),
          _textEdit(last, 'Last Name'),
          _textEdit(phone, 'Phone Number'),
          _textEdit(mail, 'Email'),
          _textEdit(address, 'Address'),
          _textEdit(occupation, 'Occupation'),
          _textEdit(hobbies, 'Hobbies'),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(width: MediaQuery.of(context).size.width*0.8,
              height: 50,
              child: MaterialButton(elevation: 0,color: Color(0xfff6615e),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color: Color(0xfff6615e))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 52.0),
                    child: Text("Save", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                  onPressed: () async{
                _upload();
                  }
              ),
            ),
          ),
          SizedBox(height: 30,),
        ],),
      ),
    );
  }

  _textEdit(TextEditingController controller,String lable){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(lable,style: GoogleFonts.poppins(color: Color(0xff959ea7))),
          SizedBox(height: 8,),
          Container(padding: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color(0xfff4f4f4)),
            child: TextField(controller: controller,
              showCursor: true,textAlign: TextAlign.left,
              style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(color: Color(0xFF666666),),
                hintText: lable,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Future _upload()async{
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    showDialog(context: context,builder: (context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }, barrierDismissible: false);
    if(img!=null){
      StorageReference ref = FirebaseStorage.instance.ref().child("Profile").child(DateTime.now().millisecondsSinceEpoch.toString());
      final task = ref.putFile(img);
      await task.onComplete;
      url = await ref.getDownloadURL();
      setState(() {

      });
    }
    CollectionReference reference=Firestore.instance.collection('Users');
    try{
      reference.document(user.uid).setData({
        'first':first.text,
        'last':last.text,
        'mail':mail.text,
        'profile':url,
        'hobbies':hobbies.text,
        'occupation':occupation.text,
        'phone':phone.text,
        'address':address.text,
      },merge: true);
      await UserServices().getUserProfile();
      Navigator.pop(context);
    }catch(e){
      print(e.toString());
      Navigator.pop(context);
    }
  }
}
