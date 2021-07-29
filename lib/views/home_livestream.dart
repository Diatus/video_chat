import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reach/chat/live_stream.dart';
import 'package:reach/chat/one_one.dart';
import 'package:reach/services/data_provider.dart';
import 'package:reach/views/live_stream_card.dart';


class HomeLiveStream extends StatefulWidget {
  const HomeLiveStream({Key key}) : super(key: key);

  @override
  _HomeLiveStreamState createState() => _HomeLiveStreamState();
}

class _HomeLiveStreamState extends State<HomeLiveStream> {

  String filter='';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(color: Color(0xfff6615e).withOpacity(0.1),
      child: ListView(shrinkWrap: true,physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 10,),
          StreamBuilder<QuerySnapshot>(
            stream: dataBase.liveStream(filter),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Container(width: MediaQuery.of(context).size.width,color: Colors.white,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 8,),
                          Text('Category',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.normal)),
                          SizedBox(width: 8,),
                          Text(filter??'ALL',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500)),
                          PopupMenuButton(padding: EdgeInsets.all(0),
                              icon: Icon(Icons.keyboard_arrow_down),
                              tooltip: 'Filter Category',
                              itemBuilder: (BuildContext context) {
                                return   ['Cooking','Fitness','Marketing','Programming','Gym'].map((e) =>  PopupMenuItem(
                                  child: ListTile(
                                    title: Text(e),
                                    onTap: (){
                                      Navigator.pop(context);
                                      setState(() {
                                        filter=e;
                                      });
                                    },
                                  ),
                                ),).toList();
                              }
                          ),
                        ],
                      ),
                      ListView.builder(shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return LiveStreamCard(snapshot: snapshot.data.documents[index],
                            onClick: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>LiveStream(snapshot:snapshot.data.documents[index])));
                            },);
                        },
                      ),
                      SizedBox(height: 80,)
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator(),);
            }
          )
        ],),
    );
  }
}
