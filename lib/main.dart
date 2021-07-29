import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reach/home.dart';
import 'package:reach/services/auth.dart';
import 'package:reach/views/ui_background.dart';
import 'login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  Future _user()async{
    var user=await UserServices().user();
    await UserServices().getWallet();
    Timer(Duration(seconds: 5), (){
      if(UserServices.uid!= null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>MyHome()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>LogIn()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _user();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.8),
      child: Stack(children: [
        Background()
      ],),
    ),
    );
  }
}