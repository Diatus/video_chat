import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reach/services/data_provider.dart';
import 'home.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {

  Future _notifications()async{
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    CollectionReference reference=Firestore.instance.collection('Notifications');
    try{
      QuerySnapshot snapshot= await reference.where('user',isEqualTo: user.uid).where('status',isEqualTo: false).getDocuments();
      snapshot.documents.map((e)async{
       await  reference.document(e.documentID).setData({'status':true},merge: true);
      }).toList();
    }catch(e){

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _notifications();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.white,
      title: Text('Notifications', style: GoogleFonts.poppins(color: Colors.black,),),
    ),
      body: StreamBuilder<QuerySnapshot>(
        stream: dataBase.notifications(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(itemCount: snapshot.data.documents.length,itemBuilder: (BuildContext context, int index) {
              return Column(children: [
                ListTile(leading: Icon(Icons.notifications_active_outlined,color: Color(0xfff6615e) ,),
                  title: Text('${snapshot.data.documents[index].data['message']}', style: GoogleFonts.poppins(color: Colors.black,fontSize: 14),),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text('${DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index]['time']))}', style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5),fontSize: 12),),
                  ),),
                Divider(height: 6,),
              ],);
            });
          }
          return Center(child: CircularProgressIndicator(),);
        }
      ),
      bottomSheet: Container(height: 64,decoration: BoxDecoration(gradient: LinearGradient(colors: [
        Color(0xff00f6615e),
        Color(0xfff6615e),
        Color(0xff00f6615e),
      ],begin: Alignment.topLeft,end: Alignment.topRight)),
          padding: EdgeInsets.only(top: 3),
          child: Container(height: 64,child: BNavigation())),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.white,onPressed: () {
        BNavigation.index=1;
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => MyHome(),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 10),
          ),
        );
      },child: BNavigation.index!=1?Image.asset(
        'assets/home.png',
        width: 25,
        height: 25,
        fit: BoxFit.cover,
      ):Image.asset(
        'assets/home.png',
        width: 25,
        height: 25,
        color: Color(0xfff6615e),
        fit: BoxFit.cover,
      ),),
    );
  }
}
