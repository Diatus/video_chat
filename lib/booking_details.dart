import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reach/services/data_provider.dart';

import 'chat/one_one.dart';

class BookingDetails extends StatefulWidget {

  final DocumentSnapshot snapshot;

  BookingDetails(this.snapshot);

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,elevation: 1,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
          Navigator.pop(context);
        },),
        title: Text(widget.snapshot.data['celebrity'], style: GoogleFonts.poppins(color: Colors.black,),),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Color(0xfff4f4f4)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
              Padding(
                padding: const EdgeInsets.only(left: 18,top: 12),
                child: Text('Celebrity Details', style: GoogleFonts.poppins(color: Color(0xfff3605d),),),
              ),
              ListTile(leading: Container(width: 50,height: 50,
                decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.white)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(85.0),
                  child: CachedNetworkImage(imageUrl: widget.snapshot.data['celebrityimage'],fit: BoxFit.cover,width: 40,height: 40,),),
              ),
                title: Text(widget.snapshot.data['celebrity'], style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600),),
                subtitle: Text('Actor', style: GoogleFonts.poppins(color: Colors.grey.shade500,),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Expanded(flex: 1,child: Icon(Icons.location_on_outlined,color: Colors.grey.shade500,),),
                  Expanded(flex: 9,child: Text(widget.snapshot.data['location'], style: GoogleFonts.poppins(color: Color(0xff363636),),),)
                ],),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Expanded(flex: 1,child: Icon(Icons.info_outline,color: Colors.grey.shade500,),),
                  Expanded(flex: 9,child: Text(widget.snapshot.data['about']??'Not yet shared!', style: GoogleFonts.poppins(color: Color(0xff363636),),),)
                ],),
              ),
            ],),
          ),
        ),
        StreamBuilder<DocumentSnapshot>(
          stream: dataBase.bookingStatus(widget.snapshot.documentID),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Color(0xfff4f4f4)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18,top: 12),
                    child: Text('Booked', style: GoogleFonts.poppins(color: Color(0xfff3605d),),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
                      snapshot.data['status']=='Awaited'?Expanded(child: ListTile(title: Text('Date & Time', style: GoogleFonts.poppins(color: Colors.grey.shade500,fontSize: 16),textAlign: TextAlign.center),
                        subtitle: Text('${DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data['bookedon']))}\n${DateFormat(DateFormat.HOUR_MINUTE, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data['bookedon']))}', style: GoogleFonts.poppins(color: Colors.black,fontSize: 20),textAlign: TextAlign.center,),
                      ),
                      ):Expanded(child: ListTile(title: Text('Date & Time', style: GoogleFonts.poppins(color: Colors.grey.shade500,fontSize: 16),textAlign: TextAlign.center),
                        subtitle: Text('${DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data['scheduledtime']))}\n${DateFormat(DateFormat.HOUR_MINUTE, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data['scheduledtime']))}', style: GoogleFonts.poppins(color: Colors.black,fontSize: 20),textAlign: TextAlign.center,),
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,top: 12,bottom: 12),
                        child: Container(height: 80,color: Colors.grey,width: 1,),
                      ),
                      Expanded(child: ListTile(title: Text('Duration', style: GoogleFonts.poppins(color: Colors.grey.shade500,fontSize: 16),textAlign: TextAlign.center),
                        subtitle: Text('${widget.snapshot.data['duration']} min', style: GoogleFonts.poppins(color: Colors.black,fontSize: 20),textAlign: TextAlign.center,),
                      ),
                      )
                    ],),
                  ),
                  snapshot.data['channel']!=null?Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(height: 45,width: MediaQuery.of(context).size.width,
                      child: MaterialButton(elevation: 0,
                          color: Color(0xfff6615e),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                          child: Text("Join Now", style: GoogleFonts.poppins(color: Colors.white,),),
                          onPressed: () async{
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>JoinChannelVideo(snapshot.data)));
                          }
                      ),
                    ),
                  ):Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(height: 45,width: MediaQuery.of(context).size.width,alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Color(0xfff6615e).withOpacity(0.5),),
                      child: Text("Join Now", style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.5),),),
                    ),
                  ),
                ],),
              ),
            );
          }
        ),
        SizedBox(height: 10,)
      ],),
    );
  }
}
