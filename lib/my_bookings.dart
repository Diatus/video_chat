import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reach/services/data_provider.dart';
import 'package:reach/views/booking_card.dart';
import 'booking_details.dart';

class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(backgroundColor: Colors.white,elevation: 1,
            leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
              Navigator.pop(context);
            },),
            title: Text('My Schedule', style: GoogleFonts.poppins(color: Colors.black,),),
            bottom: TabBar(
              isScrollable: true,
              labelStyle: GoogleFonts.poppins(color: Colors.black,),
              indicatorWeight: 2.0,
              unselectedLabelColor: Colors.grey.shade500,
              labelColor: Colors.black,
              unselectedLabelStyle: GoogleFonts.poppins(color: Colors.grey.shade500,),
              indicatorPadding: EdgeInsets.all(0),
              labelPadding: EdgeInsets.all(0),
              indicator:  ShapeDecoration(
                  shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black,)),
                  gradient: LinearGradient(begin: Alignment.bottomLeft,end: Alignment.bottomRight,colors: [Color(0xff00ffffff),Color(0xffffffff),Color(0xff00ffffff),])),
              tabs: <Widget>[
                Container(color: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                  child: Text("All"),
                ),
                Container(color: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Awaited"),
                ),
                Container(color: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Scheduled"),
                ),
                Container(color: Colors.transparent,
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Completed"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              All(),
              Awaited(),
              Scheduled(),
              Completed(),
            ],
          ),
        )
    );
  }
}


class All extends StatefulWidget {
  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: dataBase.bookings(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  SizedBox(height: 10,),
                  snapshot.data.documents[index]['status']=='Awaited'?GestureDetector(
                    child: BookingCard(image: snapshot.data.documents[index]['celebrityimage'],
                      name: '${snapshot.data.documents[index]['celebrity']}',date: '${DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index]['bookedon']))}',
                      filter: snapshot.data.documents[index]['status'],status: snapshot.data.documents[index]['status'],amount: '\$${snapshot.data.documents[index]['total']}',
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>BookingDetails(snapshot.data.documents[index])));
                    },
                  ):snapshot.data.documents[index]['status']=='Scheduled'?GestureDetector(
                    child: BookingCard(image: snapshot.data.documents[index]['celebrityimage'],
                      name: '${snapshot.data.documents[index]['celebrity']}',date: '${DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index]['bookedon']))}',
                      filter: snapshot.data.documents[index]['status'],
                      status: '${DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index]['scheduledtime']))} | ${DateFormat(DateFormat.HOUR_MINUTE, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index]['scheduledtime']))}-${DateFormat(DateFormat.HOUR_MINUTE, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index]['scheduledtime']+snapshot.data.documents[index]['duration']*60*1000))} | ${snapshot.data.documents[index]['duration']} min',
                      amount: '\$${snapshot.data.documents[index]['total']}',
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>BookingDetails(snapshot.data.documents[index])));
                    },
                  ):GestureDetector(
                    child: BookingCard(image: snapshot.data.documents[index]['celebrityimage'],
                      name: '${snapshot.data.documents[index]['celebrity']}',date: '${DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index]['bookedon']))}',
                      filter: snapshot.data.documents[index]['status'],status: 'Completed on${snapshot.data.documents[index]['completedon']}',amount: '\$${snapshot.data.documents[index]['total']}',
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>BookingDetails(snapshot.data.documents[index])));
                    },
                  ),
                  Divider(height: 20,),
                ],
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator(),);
      }
    );
  }
}


class Awaited extends StatefulWidget {
  @override
  _AwaitedState createState() => _AwaitedState();
}

class _AwaitedState extends State<Awaited> {
  @override
  Widget build(BuildContext context) {
    return Container(child: StreamBuilder<QuerySnapshot>(
      stream: dataBase.bookingSort('Awaited'),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  SizedBox(height: 10,),
                  GestureDetector(
                    child: BookingCard(image: snapshot.data.documents[index]['celebrityimage'],
                      name: '${snapshot.data.documents[index]['celebrity']}',date: '${DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index]['bookedon']))}',
                      filter: snapshot.data.documents[index]['status'],status: snapshot.data.documents[index]['status'],amount: '\$${snapshot.data.documents[index]['total']}',
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>BookingDetails(snapshot.data.documents[index])));
                    },
                  ),
                  Divider(height: 20,),
                ],
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator(),);
      }
    ),);
  }
}


class Scheduled extends StatefulWidget {
  @override
  _ScheduledState createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: dataBase.bookingSort('Scheduled'),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(height: 10,),
                    GestureDetector(
                      child: BookingCard(image: snapshot.data.documents[index]['celebrityimage'],
                        name: '${snapshot.data.documents[index]['celebrity']}',date: '${DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index]['bookedon']))}',
                        filter: snapshot.data.documents[index]['status'],
                        status: '${DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index]['scheduledtime']))} | ${DateFormat(DateFormat.HOUR_MINUTE, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index]['scheduledtime']))}-${DateFormat(DateFormat.HOUR_MINUTE, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index]['scheduledtime']+snapshot.data.documents[index]['duration']*60*1000))} | ${snapshot.data.documents[index]['duration']} min',
                        amount: '\$${snapshot.data.documents[index]['total']}',
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>BookingDetails(snapshot.data.documents[index])));
                      },
                    ),
                    Divider(height: 20,),
                  ],
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator(),);
        }
    );
  }
}



class Completed extends StatefulWidget {
  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: dataBase.bookingSort('Completed'),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(height: 10,),
                    GestureDetector(
                      child: BookingCard(image: snapshot.data.documents[index]['celebrityimage'],
                        name: '${snapshot.data.documents[index]['celebrity']}',date: '${DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index]['bookedon']))}',
                        filter: snapshot.data.documents[index]['status'],status: 'Completed on ${DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index]['completedon']))}',amount: '\$${snapshot.data.documents[index]['total']}',
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>BookingDetails(snapshot.data.documents[index])));
                      },
                    ),
                    Divider(height: 20,),
                  ],
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator(),);
        }
    );
  }
}
