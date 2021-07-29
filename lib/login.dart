import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:reach/services/auth.dart';
import 'home.dart';


class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/login.png',))),
      child: Stack(children: [
        Align(alignment: Alignment.bottomCenter,
        child: Column(mainAxisSize: MainAxisSize.min,children: [
          Container(width: MediaQuery.of(context).size.width*0.8,
            height: 50,
            child: MaterialButton(elevation: 0,
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 52.0),
                  child: Text("Log In", style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold),),
                ),
                onPressed: () async{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>SigIn()));
                }
            ),
          ),
          SizedBox(height: 20,),
          Container(width: MediaQuery.of(context).size.width*0.8,
            height: 50,
            child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32),side: BorderSide(color: Color(0xffffffff))),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 52.0),
                  child: Text("Sign Up", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
                onPressed: () async{
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>SigIn()));
                }
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(child: Text('skip',style: GoogleFonts.poppins(decoration: TextDecoration.underline,color: Colors.white),),
          onTap: (){

          },),
          SizedBox(height: 30,),
        ],),)
      ],),
    ),
    );
  }
}


class SigIn extends StatefulWidget {
  @override
  _SigInState createState() => _SigInState();
}

class _SigInState extends State<SigIn> {

  FirebaseUser _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String dropdownValue='+91';
  TextEditingController _phone=new TextEditingController();
  TextEditingController otp=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: ListView(children: [
        Padding(
          padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.07,bottom: 20),
          child: Text('Sign In',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32,color: Colors.black),),
        ),
        SizedBox(height: 20,),
        Center(
          child: Container(width: MediaQuery.of(context).size.width*0.5,height: MediaQuery.of(context).size.height*0.3,
              alignment: Alignment.topCenter,
              child: Image.asset('assets/otp1.png')
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(padding: EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white))
            ),
            child: TextField(controller: _phone,
              showCursor: true,textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                prefixIcon: Container(width: 90,
                  child: DropdownButton(
                    value: dropdownValue,dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),
                    iconSize: 34,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(),
                    hint: Text('Select category'),
                    style: TextStyle(color: Colors.black),
                    onChanged: (value){
                      setState(() {
                        dropdownValue=value;
                      });
                    },
                    items: ['+91','+99'].map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                hintStyle: TextStyle(color: Color(0xFF666666),),
                hintText: "Phone No.",
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        SizedBox(height: 30,),
        Container(width: MediaQuery.of(context).size.width*0.8,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.only(left: 12,right: 12),
            child: MaterialButton(color: Color(0xfff6615e),elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Row(mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(flex: 8,child: Text("Send OTP", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),),
                    Expanded(flex: 2,child: CircleAvatar(child: Icon(Icons.navigate_next,color: Colors.white,),
                      backgroundColor: Color(0xffffffff).withOpacity(0.2),
                    ),),
                  ],
                ),
                onPressed: () async{
              if(_phone.text.length==10){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>OtpVerification(code: dropdownValue,number: _phone.text,)));
              }else{

              }
                }
            ),
          ),
        ),
        SizedBox(height: 20,),
        Padding(
          padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.02,bottom: 20),
          child: Text('OR',style: TextStyle(color: Color(0xffb1b1b1)),textAlign: TextAlign.center,),
        ),
        SizedBox(height: 10,),
        Container(width: MediaQuery.of(context).size.width*0.8,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.only(left: 12,right: 12),
            child: MaterialButton(color: Color(0xfff4f4f4),elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color: Color(0xffffffff))),
                child: Row(mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/search.png',width: 35,height: 35),
                    SizedBox(width: 12,),
                    Text("Login with google", style: GoogleFonts.poppins(color: Color(0xff313131),fontWeight: FontWeight.normal),),
                  ],
                ),
                onPressed: () async{
                  signInWithGoogle();
                }
            ),
          ),
        ),
      ],),
    ),
    );
  }

  Future<FirebaseUser> signInWithGoogle() async {
    showDialog(context: context,builder: (context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }, barrierDismissible: false);
    try{
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      AuthResult authResult = await _auth.signInWithCredential(credential);
      _user = authResult.user;
      assert(!_user.isAnonymous);
      assert(await _user.getIdToken() != null);
      FirebaseUser currentUser = await _auth.currentUser();
      assert(_user.uid == currentUser.uid);
      if(currentUser!=null){
        FirebaseMessaging messaging=new FirebaseMessaging();
        await messaging.getToken().then((value){
          userServices.notification(value);
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>MyHome()));
      }
    }catch(e){
      print(e.toString());
    }
  }
}


class OtpVerification extends StatefulWidget {

  final String code;
  final String number;
  OtpVerification({this.code, this.number});

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {

  TextEditingController _phone=new TextEditingController();
  TextEditingController otp=new TextEditingController();
  String _countryCode='+91';
  String _smsCode = "";
  String _verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool otpp=false;


  Future<void> verifyPhone() async {
    try{
      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
        this._verificationId = verId;
      };
      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        this._verificationId = verId;
      };
      final PhoneVerificationCompleted verifiedSuccess = (credential) async {
        print(credential.providerId + "    --------      AUTO VERIFY");
      };

      final PhoneVerificationFailed verificationFailed = (AuthException exception) {

      };


      await _auth.verifyPhoneNumber(
        phoneNumber: this._countryCode + this._phone.text.trim(),
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verificationFailed,
      );
    }catch(e){
      print("What Was the problem"+e.toString());
    }

  }

  void signIn() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: _smsCode.trim());
    _signInWithCredential(credential);
  }

  @override
  void initState() {
    // TODO: implement initState
    _auth.signOut();
    _googleSignIn.signOut();
    _phone.text=widget.number;
    verifyPhone();
    print(_phone.text);
    print(widget.code);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>SigIn()));
    },),
      backgroundColor: Colors.white,elevation: 0,),
      body: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: ListView(children: [
          Padding(
            padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.03,bottom: 20),
            child: Text.rich(TextSpan(text: 'Please, enter 4 digit code we sent on your \n no as SMS',
                style: GoogleFonts.poppins(color: Colors.black),
                children: [
                  TextSpan(text: '   ${widget.code} ${widget.number}',style: GoogleFonts.poppins(color: Color(0xfff6615e)))
                ])),
          ),
          SizedBox(height: 20,),
          Center(
            child: Container(width: MediaQuery.of(context).size.width*0.5,height: MediaQuery.of(context).size.height*0.3,
                alignment: Alignment.topCenter,
                child: Image.asset('assets/otp2.png')
            ),
          ),
          SizedBox(height: 30,),
          Center(
            child: PinCodeTextField(
              autofocus: true,
              controller: otp,
              highlight: true,
              highlightColor: Colors.black,
              defaultBorderColor: Colors.black.withOpacity(0.3),
              hasTextBorderColor: Colors.black,
              maxLength: 6,
              pinBoxRadius: 12,
              onDone: (text) {
                setState(() {
                  _smsCode=text;
                });
              },
              pinBoxWidth: 45,
              pinBoxHeight: 45,
              wrapAlignment: WrapAlignment.spaceAround,
              pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
              pinTextStyle: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(height: 30,),
          Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [
            Text('Resend OTP',style: GoogleFonts.poppins(color: Colors.black)),
            Text('${widget.code} ${widget.number}',style: GoogleFonts.poppins(color: Color(0xfff6615e)))
          ],),
          SizedBox(height: 40,),
          Container(width: MediaQuery.of(context).size.width*0.8,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: MaterialButton(color: Color(0xfff6615e),elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Row(mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(flex: 8,child: Text("Login", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),),
                      Expanded(flex: 2,child: CircleAvatar(child: Icon(Icons.navigate_next,color: Colors.white,),
                        backgroundColor: Color(0xffffffff).withOpacity(0.2),
                      ),),
                    ],
                  ),
                  onPressed: () async{
                if(_smsCode.length==6){
                  signIn();
                }
                else{

                }
                  }
              ),
            ),
          ),
          SizedBox(height: 20,),
        ],),
      ),
    );
  }


  _signInWithCredential(AuthCredential credential) async {
    FirebaseUser user;
    try {
      final authRes = await _auth.signInWithCredential(credential);
      user = authRes.user;
    } catch (err) {
      setState(() {
        otpp=true;
      });
      print(err.toString());
    }
    if (user != null) {
      FirebaseMessaging messaging=new FirebaseMessaging();
      await messaging.getToken().then((value){
        userServices.notification(value);
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>MyHome()));
    } else {
      print('ccv');
    }
  }
}
