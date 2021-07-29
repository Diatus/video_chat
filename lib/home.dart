import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reach/services/data_provider.dart';
import 'package:reach/views/home_livestream.dart';
import 'package:reach/login.dart';
import 'package:reach/search.dart';
import 'package:reach/terms&conditions.dart';
import 'package:reach/wallet.dart';
import 'account.dart';
import 'contact.dart';
import 'help.dart';
import 'views/home_view.dart';
import 'my_bookings.dart';
import 'notification.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var userprofile;
  String name;
  String phone;
  String url;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(drawer: _drawer(),key: _scaffoldKey,
          appBar: AppBar(elevation: 0,automaticallyImplyLeading: false,backgroundColor: Colors.white,
              title: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: Colors.grey,blurRadius: 4,),
                BoxShadow(color: Colors.grey),
              ]),
                child: Row(children: [
                  Expanded(flex: 2,
                    child: IconButton(icon: Icon(Icons.menu,color: Colors.black,),onPressed: (){
                      _scaffoldKey.currentState.openDrawer();
                    },),
                  ),
                  Expanded(flex: 6,child: Text('Search here',style: GoogleFonts.poppins(color: Colors.grey.withOpacity(0.5),fontSize: 14,fontWeight: FontWeight.normal),)),
                  Expanded(flex: 2,child: StreamBuilder<DocumentSnapshot>(
                    stream: dataBase.profile(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData&&snapshot.data.exists){
                        return Padding(
                          padding: const EdgeInsets.only(left: 14,right: 14),
                          child: GestureDetector(onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Account()));
                          },child: Container(width: 35,height: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(125.0),
                              child: snapshot.data['profile']!=null&&snapshot.data['profile'].isNotEmpty?CachedNetworkImage(imageUrl: snapshot.data['profile'],fit: BoxFit.cover,width: 25,height: 25):
                              CircleAvatar(radius: 35,backgroundColor: Colors.grey.shade300,
                                child: IconButton(padding: EdgeInsets.all(0),icon:Icon(Icons.camera_enhance_sharp,color: Colors.white,size: 30,),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Account()));
                                  },),
                              ),),
                          ),),
                        );
                      }
                      return GestureDetector(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Account()));
                      },child: Container(width: 40,height: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(85.0),
                          child: url!=null&&url.isNotEmpty?CachedNetworkImage(imageUrl: url,fit: BoxFit.contain,width: 30,height: 30,):
                          CircleAvatar(radius: 35,backgroundColor: Colors.grey.shade300,
                            child: IconButton(icon:Icon(Icons.camera_enhance_sharp,color: Colors.white,size: 30,),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Account()));
                              },),
                          ),),
                      ),);
                    }
                  ))
                ],),),
            bottom: TabBar(
              isScrollable: true,
              labelStyle: GoogleFonts.poppins(color: Colors.blue,),
              unselectedLabelStyle: GoogleFonts.poppins(color: Colors.blue,),
              unselectedLabelColor: Colors.grey.shade500,
              labelColor: Colors.black,
              indicatorPadding: EdgeInsets.all(0),
              labelPadding: EdgeInsets.all(0),
              indicator:  ShapeDecoration(
                  shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,)),
                  gradient: LinearGradient(begin: Alignment.bottomLeft,end: Alignment.bottomRight,colors: [Color(0xff00f6615e),Color(0xfff6615e),Color(0xff00ffffff)])),
              tabs: <Widget>[
                Container(color: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Celebrity",),
                ),
                Container(color: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                  child: Text("TV Shows"),
                ),
                Container(color: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Player"),
                ),
                Container(color: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Live Stream"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              HomeView(),
              HomeView(),
              HomeView(),
              HomeLiveStream(),
            ],
          ),
          bottomSheet: Container(height: 64,decoration: BoxDecoration(gradient: LinearGradient(colors: [
            Color(0xff00f6615e),
            Color(0xfff6615e),
            Color(0xff00f6615e),
          ],begin: Alignment.topLeft,end: Alignment.topRight)),
              padding: EdgeInsets.only(top: 2),
              child: Container(height: 64,child: BNavigation())),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(backgroundColor: Colors.white,onPressed: () {

          },child: BNavigation.index!=1?Image.asset(
            'assets/logo.png',
            width: 55,
            height: 55,
            fit: BoxFit.cover,
          ):Image.asset(
            'assets/logo.png',
            width: 55,
            height: 55,
            fit: BoxFit.cover,
          ),),
        )
    );
  }



  Widget _drawer(){
    return Container(color: Colors.white,
      child: Container(width: MediaQuery.of(context).size.width*0.75,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.black,
        gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [
          Colors.grey.shade300,
          Colors.grey.shade50,
        ])),
        child: ListView(children: [
          StreamBuilder<DocumentSnapshot>(
            stream: dataBase.profile(),
            builder: (context, snapshot) {
              if(snapshot.hasData&&snapshot.data.exists){
                return Container(height: MediaQuery.of(context).size.width*0.55,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(bottomRight: Radius.circular(42))),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    IconButton(icon: Icon(Icons.close,color: Colors.black,),onPressed: (){
                      Navigator.pop(context);
                    },),
                    Center(
                      child: Container(width: 80,height: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(95.0),
                          child: snapshot.data['profile']!=null&&snapshot.data['profile'].isNotEmpty?CachedNetworkImage(imageUrl: snapshot.data['profile'],fit: BoxFit.cover,width: 60,height: 60,):
                          CircleAvatar(radius: 35,backgroundColor: Colors.grey.shade300,
                            child: IconButton(icon:Icon(Icons.camera_enhance_sharp,color: Colors.white,size: 30,),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Account()));
                              },),
                          ),),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(child: Text('${snapshot.data['first']??'Guest'}',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold))),
                    Center(child: Text('${snapshot.data['phone']??'+91 xxxxxxxx'}',style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5),fontWeight: FontWeight.normal))),
                  ],),
                );
              }
              return Container(height: MediaQuery.of(context).size.width*0.55,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(bottomRight: Radius.circular(42))),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  IconButton(icon: Icon(Icons.close,color: Colors.black,),onPressed: (){
                    Navigator.pop(context);
                  },),
                  Center(
                    child: Container(width: 80,height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(95.0),
                        child: url!=null&&url.isNotEmpty?CachedNetworkImage(imageUrl: url,fit: BoxFit.cover,width: 60,height: 60,):
                        CircleAvatar(radius: 35,backgroundColor: Colors.grey.shade300,
                          child: IconButton(icon:Icon(Icons.camera_enhance_sharp,color: Colors.white,size: 30,),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Account()));
                            },),
                        ),),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(child: Text('Guest',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold))),
                  Center(child: Text('+91 xxxxxxxx',style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5),fontWeight: FontWeight.normal))),
                ],),
              );
            }
          ),
          ListTile(leading: Image.asset('assets/ahome.png',width: 25,height: 25,),title: Text('Home',style: GoogleFonts.poppins(color: Color(0xfff6615e),fontWeight: FontWeight.normal)),
            trailing: Icon(Icons.navigate_next,color: Colors.grey,),
          onTap: (){

          },),
          ListTile(leading: Image.asset('assets/booking.png',width: 25,height: 25,color: Colors.black,),title: Text('My Booking',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.normal)),
            trailing: Icon(Icons.navigate_next,color: Colors.grey,),
            onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>MyBookings()));
            },),
          ListTile(leading: Icon(Icons.account_balance_wallet_outlined,color: Colors.black,),title: Text('Wallet',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.normal)),
            trailing: Icon(Icons.navigate_next,color: Colors.grey,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Wallet()));
            },),
          ListTile(leading: Container(height: 30,width: 30,
            child: StreamBuilder<QuerySnapshot>(
                stream: dataBase.unreadNotification(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return Stack(
                      children: [
                        Positioned(top: 4,right: 6,child:  Image.asset('assets/note.png',
                          width: 25,height: 25,fit: BoxFit.cover,color: Colors.black,)),
                        Positioned(top: 0,right: 0,left: 9,
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(blurRadius: 1,color: Colors.grey.shade500)
                                ],
                              ),
                              child: snapshot.data.documents.length>0?CircleAvatar(radius: 9,backgroundColor: Color(0xfff6615e),
                                  child: Text('${snapshot.data.documents.length}',style: GoogleFonts.poppins(color: Colors.white,fontSize: 11,fontWeight: FontWeight.w500))):Container(),
                            )
                        ),
                      ],
                    );
                  }
                 return Image.asset('assets/note.png',
                   width: 25,height: 25,fit: BoxFit.cover,color: Colors.black,);
                }
            ),
          ),title: Text('Notification',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.normal)),
            trailing: Icon(Icons.navigate_next,color: Colors.grey,),
            onTap: (){
            BNavigation.index=2;
            Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => NotificationView(),
                  transitionsBuilder: (c, anim, a2, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 10),
                ),
              );
            },),
          ListTile(leading: Image.asset('assets/terms.png',width: 25,height: 25,color: Colors.black),title: Text('Terms & Conditions',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.normal)),
            trailing: Icon(Icons.navigate_next,color: Colors.grey,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Terms()));
            },),
          ListTile(leading: Image.asset('assets/help.png',width: 25,height: 25,color: Colors.black),title: Text('Help',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.normal)),
            trailing: Icon(Icons.navigate_next,color: Colors.grey,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Help()));
            },),
          ListTile(leading: Image.asset('assets/mentions.png',width: 25,height: 25,color: Colors.black),title: Text('Contact Us',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.normal)),
            trailing: Icon(Icons.navigate_next,color: Colors.grey,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Contact()));
            },),
          Divider(height: 40,),
          ListTile(leading: Image.asset('assets/logout.png',width: 25,height: 25,color: Colors.black),title: Text('LogOut',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.normal)),
            onTap: () async {
            await FirebaseAuth.instance.signOut();
            await _googleSignIn.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>LogIn()));
            },),
        ],),
      ),
    );
  }
}


class BNavigation extends StatelessWidget {
  static int index = 1;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: index,
      backgroundColor: Colors.white,
      elevation: 20,
      iconSize: 15,
      onTap: (v) {
        if (v == 0 && index != v) {
          index = v;
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => Search(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 10),
            ),
          );
        }
        if (v == 1 && index != v) {
          index = v;
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => MyHome(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 10),
            ),
          );
        }
        if (v == 2 && index != v) {
          index = v;
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => NotificationView(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 10),
            ),
          );
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icon.png',
            width: 20,
            height: 20,
            fit: BoxFit.cover,
          ),
          activeIcon: Image.asset(
          'assets/icon.png',
          width: 20,
          height: 20,
          fit: BoxFit.cover,
          color:  Color(0xfff6615e),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              'Search',
              style: GoogleFonts.poppins(
                  color: index == 0 ? Color(0xfff6615e) : Colors.grey,),
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Container(decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.grey,blurRadius: 6)
          ]),
            padding: EdgeInsets.all(8),
          ),
          activeIcon: Container(padding: EdgeInsets.all(8),),
          title: Padding(
            padding: const EdgeInsets.only(top:5.0),
            child: Text(
              'Home',
              style: GoogleFonts.poppins(
                  color: index == 1 ? Color(0xfff6615e): Colors.grey,),
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: StreamBuilder<QuerySnapshot>(
            stream: dataBase.unreadNotification(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Container(
                    height: 25,
                    width: 35,
                    padding: EdgeInsets.only(left: 0),
                    child: Stack(
                      children: [
                        Positioned(top: 4,right: 12,child:  Image.asset('assets/note.png',
                          width: 19,height: 19,fit: BoxFit.cover,color: Colors.grey,)),
                        Positioned(top: 0,right: 0,left: 9,
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(blurRadius: 1,color: Colors.grey.shade500)
                                ],
                              ),
                              child: snapshot.data.documents.length>0?CircleAvatar(radius: 9,backgroundColor: Color(0xfff6615e),
                                  child: Text('${snapshot.data.documents.length}',style: GoogleFonts.poppins(color: Colors.white,fontSize: 11,fontWeight: FontWeight.w500))):Container(),
                            )
                        ),
                      ],
                    ));
              }
              return Image.asset('assets/note.png',
                width: 19,height: 19,fit: BoxFit.cover,color: Colors.grey,);

            }
          ),
          activeIcon:  Image.asset(
            'assets/note.png',
            width: 20,
            height: 20,
            fit: BoxFit.cover,
            color: Color(0xfff6615e),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              'Notification',
              style: GoogleFonts.poppins(
                  color: index == 2 ? Color(0xfff6615e) : Colors.grey,),
            ),
          ),
        ),
      ],
    );
  }
}
