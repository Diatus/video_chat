import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reach/services/auth.dart';
import 'home.dart';

class Booking extends StatefulWidget {

  final DocumentSnapshot snapshot;
  Booking(this.snapshot);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {

  int time=0;
  bool coupon=false;
  bool wallet=false;
  double price=0.0;
  double total=0.0;
  TextEditingController code=new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String url;
  String first;
  String phone;
  String mail;
  String address;
  String occupation;
  String token;

  Future _get()async{
    await UserServices().getWallet();
    var user=await UserServices().getUserProfile();
    if(user!=null){
      setState(() {
        url=user['profile'];
        first=user['first'];
        phone=user['phone'];
        mail=user['mail'];
        address=user['address'];
        occupation=user['occupation'];
        token=user['token'];
      });
    }
    return user;
  }

  @override
  void initState() {
    // TODO: implement initState
    _get();
    price=double.parse(widget.snapshot.data['price']);
    time=5;
    total=time*price+time*price*0.25;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,backgroundColor: Colors.white,appBar: AppBar(elevation: 1,backgroundColor: Colors.white,
      title: Text('My Schedule', style: GoogleFonts.poppins(color: Colors.black,),),
      leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
        Navigator.pop(context);
      },),
    ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(left: 12,bottom: 12,top: 12),
          child: Text('Your Influencer',style: GoogleFonts.poppins(color: Colors.grey.shade500,)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(children: [
            Expanded(flex: 3,child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(imageUrl: widget.snapshot.data['profilephoto'],fit: BoxFit.cover,width: MediaQuery.of(context).size.width,height: 100,)
            ),),
            Expanded(flex: 7,
              child: ListTile(title: Text('${widget.snapshot.data['first']}',style: GoogleFonts.poppins(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600)),
                subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(widget.snapshot.data['rating']??'1.0',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600)),
                      Icon(Icons.star,color: Color(0xffe7b429),size: 20,)
                    ],),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text('\$${widget.snapshot.data['price']}/min',style: GoogleFonts.poppins(color: Colors.grey.shade500,)),
                    )
                  ],
                ),
              ),
            )
          ],),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12,top: 12),
          child: Text('Choose duration',style: GoogleFonts.poppins(color: Colors.grey.shade500,)),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
          Expanded(child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: time==5?Color(0xfff6615e):Color(0xfff4f4f4)),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 4,bottom: 4),
                child: Text('5 min',style: GoogleFonts.poppins(color: time==5?Colors.white:Colors.black,fontSize: 14,fontWeight: FontWeight.w500)),
              ),
            ),
            onTap: (){
              if(5*price+5*price*0.25<UserServices.wallet){
                setState(() {
                  time=5;
                  total=time*price+time*price*0.25;
                });
              }else{
                setState(() {
                  wallet=false;
                });
                _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('insufficient points in your wallet!')));
              }
            },

          ),
          ),
          Expanded(child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: time==10?Color(0xfff6615e):Color(0xfff4f4f4)),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 4,bottom: 4),
                child: Text('10 min',style: GoogleFonts.poppins(color: time==10?Colors.white:Colors.black,fontSize: 14,fontWeight: FontWeight.w500)),
              ),
            ),
            onTap: (){
              if(10*price+10*price*0.25<UserServices.wallet){
                setState(() {
                  time=10;
                  total=time*price+time*price*0.25;
                });
              }else{
                setState(() {
                  wallet=false;
                });
                _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('insufficient points in your wallet!')));
              }
            },
          ),
          ),
          Expanded(child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: time==15?Color(0xfff6615e):Color(0xfff4f4f4)),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 4,bottom: 4),
                child: Text('15 min',style: GoogleFonts.poppins(color: time==15?Colors.white:Colors.black,fontSize: 14,fontWeight: FontWeight.w500)),
              ),
            ),
            onTap: (){
              if(15*price+15*price*0.25<UserServices.wallet){
                setState(() {
                  time=15;
                  total=time*price+time*price*0.25;
                });
              }else{
                setState(() {
                  wallet=false;
                });
                _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('insufficient points in your wallet!')));
              }

            },
          ),
          ),
          Expanded(child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: time==20?Color(0xfff6615e):Color(0xfff4f4f4)),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 4,bottom: 4),
                child: Text('20 min',style: GoogleFonts.poppins(color: time==20?Colors.white:Colors.black,fontSize: 14,fontWeight: FontWeight.w500)),
              ),
            ),
            onTap: (){
              if(20*price+20*price*0.25<UserServices.wallet){
                setState(() {
                  time=20;
                  total=time*price+time*price*0.25;
                });
              }else{
                setState(() {
                  wallet=false;
                });
                _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('insufficient points in your wallet!')));
              }
            },
          ),
          ),
        ],),
        Padding(
          padding: const EdgeInsets.only(left: 12,top: 8),
          child: Text('Select meet date',style: GoogleFonts.poppins(color: Colors.grey.shade500,)),
        ),
        Row(
          children: [
            Expanded(flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(padding: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xfff4f4f4)),
                  child: Row(
                    children: [
                      Expanded(flex: 8,
                        child: TextField(controller: code,
                          showCursor: true,textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.normal),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Color(0xFF666666),),
                            hintText: 'Coupon Code',
                          ),
                        ),
                      ),
                      Expanded(flex: 2,
                        child: IconButton(icon: Icon(Icons.close,color: Color(0xff919191),),onPressed: (){
                          setState(() {
                            coupon=false;
                          });
                      },),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(flex: 3,child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(height: 45,
                child: MaterialButton(elevation: 0,
                    color: Color(0xfff6615e),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                    child: Text("Applied", style: GoogleFonts.poppins(color: Colors.white,),),
                    onPressed: () async{
                  if(code.text.length>4){
                    setState(() {
                      coupon=true;
                    });
                  }else{
                    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Enter valid coupon code')));
                  }
                    }
                ),
              ),
            ),)
          ],
        ),
        coupon?Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text('Your coupon has been applied.',style: GoogleFonts.poppins(color: Color(0xff35b74e),)),
        ):Container(),
        ListTile(leading: Radio(activeColor:Color(0xfff6615e),groupValue: wallet, value: true, onChanged: (bool value) {
          if(total<UserServices.wallet){
            setState(() {
              wallet=value;
            });
          }
          else{
            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('insufficient points in your wallet!')));
          }
        }),title: Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,children: [
          Icon(Icons.account_balance_wallet,color: Colors.black,),
          SizedBox(width: 8,),
          Text('My Credit',style: GoogleFonts.poppins(color: Colors.black,)),
        ],),
          trailing: Text('${UserServices.wallet} Points',style: GoogleFonts.poppins(color: Color(0xffe7b429),fontWeight: FontWeight.w500)),
        )
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
                child: Text("Request Now  \$$total", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
              onPressed: (){
                if(wallet){
                  _updateWallet();
                }else{
                  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please select your wallet option')));
                }
              }
          ),
        ),
      ),
    );
  }


  Future _updateWallet()async{
    showDialog(context: context,builder: (context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }, barrierDismissible: false);
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    CollectionReference reference=Firestore.instance.collection('Users');
    try{
      reference.document(user.uid).setData({
        'wallet':(UserServices.wallet-total).toDouble()
      },merge: true);
      _upload();
    }catch(e){
      Navigator.pop(context);
      print(e.toString());
    }
  }


  Future _upload()async{

    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    CollectionReference reference=Firestore.instance.collection('Bookings');
    try{
      reference.document().setData({
        'celebrity':widget.snapshot.data['first'],
        'celebrityimage':widget.snapshot.data['profilephoto'],
        'total':total,
        'duration':time,
        'profession':widget.snapshot.data['profession'],
        'celebrityuid':widget.snapshot.documentID,
        'user':user.uid,
        'location':widget.snapshot.data['location'],
        'about':widget.snapshot.data['about'],
        'bookedon':DateTime.now().millisecondsSinceEpoch,
        'status':'Awaited',
        'userprofile':url,
        'userfirst':first,
        'userlocation':address,
        'occupation':occupation,
        'userphone':phone,
        'usermail':mail,
        'token':token,
      },merge: true);
     _notify();
    }catch(e){
      Navigator.pop(context);
      print(e.toString());
    }
  }

  Future _notify()async{
    CollectionReference userCollection=Firestore.instance.collection('Notifications');
    try{
      userCollection.document().setData({
        'user':widget.snapshot.documentID,
        'message':'$first requested a Video Call with you have a look on it.',
        'time':DateTime.now().millisecondsSinceEpoch,
        'status':false,
        'token':widget.snapshot.data['token']
      },merge: true);
      Navigator.pop(context);
      pickImage();
    }catch(e){
      Navigator.pop(context);
      print(e.toString());
    }
  }


  void pickImage(){
    showDialog(context: context, builder: (context)=>Center(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 34),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(child: Icon(Icons.check_circle_outlined,size: 65,color: Colors.green,),),
              SizedBox(height: 25),
              Text('Booking Successful',style: GoogleFonts.poppins(color: Colors.black,fontSize: 18)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: Text('We will notice you once your request accepted',style:GoogleFonts.poppins(color: Colors.black),textAlign: TextAlign.center,),
              ),
              SizedBox(height: 25),
              Container(width: 200,
                child: MaterialButton(elevation: 0,
                    color: Color(0xfff6615e),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                    child: Text("OK", style: GoogleFonts.poppins(color: Colors.white,),),
                    onPressed: () async{
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>MyHome()));
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
