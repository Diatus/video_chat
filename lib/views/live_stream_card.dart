import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reach/chat/one_one.dart';

class LiveStreamCard extends StatelessWidget {

  final DocumentSnapshot snapshot;
  final Function onClick;
  const LiveStreamCard({this.snapshot,this.onClick,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(height: 150,
        padding: EdgeInsets.only(top: 8,bottom: 12),child: Row(children: [
        Expanded(flex: 3,child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 12),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(imageUrl: snapshot.data['url'],fit: BoxFit.cover,height: MediaQuery.of(context).size.height,)
            ),
          ),
          Align(alignment: Alignment.bottomCenter,
          child: Container(width: 80,
            height: 30,
            child: MaterialButton(elevation: 0,
                color: Color(0xffee4142),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Text("Live", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
                onPressed: onClick
            ),
          ),)
        ],)),
        Expanded(flex: 7,child: ListTile(title: Text('${snapshot.data['name']}',style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600)),
          subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            SizedBox(height: 5,),
            Text('${snapshot.data['title']}',style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5),fontSize: 16,fontWeight: FontWeight.w600)),
            SizedBox(height: 10,),
            Row(children: [
              Expanded(flex:5,child: Row(
                children: [
                  Icon(Icons.access_time_outlined,color: Colors.grey.withOpacity(0.8)),
                  SizedBox(width: 4,),
                  Text('${DateFormat(DateFormat.HOUR_MINUTE, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data['time']))}')
                ],
              )
              ),    SizedBox(width: 8,),
              Expanded(flex: 6,child: Row(
                children: [
                  Icon(Icons.local_offer_outlined,color: Colors.grey.withOpacity(0.8)),
                  SizedBox(width: 4,),
                  Text('${snapshot.data['category']}')
                ],
              )
              )
            ],),
            SizedBox(height: 10,),
            Row(children: [
                Icon(Icons.location_on_outlined,color: Colors.grey.withOpacity(0.8)),
                SizedBox(width: 4,),
                Text('${snapshot.data['location']}')
            ],),
            SizedBox(height: 10,),
          ],),)
        )
      ],),),
      onTap: (){

      },
    );
  }


}
