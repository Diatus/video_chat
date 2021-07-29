import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reach/profile_view.dart';
import 'package:reach/services/data_provider.dart';
import 'package:reach/views/profile_card.dart';
import 'package:reach/views/video_card.dart';
import 'package:reach/views/video_view.dart';
import '../filter.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  String sort='Popular';
  String order='bookings';


  @override
  Widget build(BuildContext context) {
    return Container(color: Color(0xfff6615e).withOpacity(0.1),child: ListView(shrinkWrap: true,physics: BouncingScrollPhysics(),children: [
      SizedBox(height: 10,),
      Container(color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
              const EdgeInsets.only(top: 12, left: 8, bottom: 6),
              child: Text('Featured Videos', style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal),
              ),
            ),
            AspectRatio(aspectRatio: 1/0.5,
              child: StreamBuilder<QuerySnapshot>(
                stream: dataBase.featured(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(shrinkWrap: true,physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: VideoCard(image: snapshot.data.documents[index]['profilephoto'],
                            name: '${snapshot.data.documents[index]['first']}',time: '${snapshot.data.documents[index]['price']}',
                          snapshot: snapshot.data.documents[index],onClick: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>VideoView(snapshot.data.documents[index])));
                            },),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>VideoView(snapshot.data.documents[index])));
                          },
                        );
                      },);
                  }
                  return Center(child: CircularProgressIndicator());
                }
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
      SizedBox(height: 10,),
      Container(color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
                Expanded(flex: 3,child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: sort=='Popular'?Color(0xfff89492).withOpacity(0.3):Colors.white),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 4,bottom: 4),
                      child: Text('Popular',style: GoogleFonts.poppins(color: sort=='Popular'?Color(0xfff89492):Colors.grey.shade500,fontSize: 14,fontWeight: FontWeight.normal)),
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      sort='Popular';
                      order='bookings';
                    });
                  },
                ),
                ),
                Expanded(flex: 3,child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: sort=='Trending'?Color(0xfff89492).withOpacity(0.3):Colors.white),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 4,bottom: 4),
                      child: Text('Trending',style: GoogleFonts.poppins(color: sort=='Trending'?Color(0xfff89492):Colors.grey.shade500,fontSize: 14,fontWeight: FontWeight.normal)),
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      sort='Trending';
                      order='visits';
                    });
                  },
                ),
                ),
                Expanded(flex: 2,child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8,bottom: 8),
                    child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: sort=='New'?Color(0xfff89492).withOpacity(0.3):Colors.white),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 4,bottom: 4),
                      child: Text('New',style: GoogleFonts.poppins(color: sort=='New'?Color(0xfff89492):Colors.grey.shade500,fontSize: 14,fontWeight: FontWeight.normal)),
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      sort='New';
                      order='createdOn';
                    });
                  },
                ),
                ),
                Expanded(flex: 3,child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: sort=='Active Now'?Color(0xfff89492).withOpacity(0.3):Colors.white),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 4,bottom: 4),
                      child: Text('Active Now',style: GoogleFonts.poppins(color: sort=='Active Now'?Color(0xfff89492):Colors.grey.shade500,fontSize: 14,fontWeight: FontWeight.normal)),
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      sort='Active Now';
                      order='';
                    });
                  },
                ),
                ),
              ],),
            ),
            Padding(
              padding:
              const EdgeInsets.only(top: 8, left: 8, bottom: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Hollywood', style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text('See all', style: GoogleFonts.poppins(color: Color(0xfff6615e),fontSize: 12,fontWeight: FontWeight.normal,),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Filter('hollywood')));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.width*0.45,
              child: StreamBuilder<QuerySnapshot>(
                stream: dataBase.hollywood('hollywood',order),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(shrinkWrap: true,physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: ProfileCard(image: snapshot.data.documents[index]['profilephoto'],
                            name: '${snapshot.data.documents[index]['first']}',time: '${snapshot.data.documents[index]['price']}',),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ProfileView(snapshot.data.documents[index])));
                          },
                        );
                      },
                    );
                  }
                  return  Text('data',style: TextStyle(color: Colors.black));
                }
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
      SizedBox(height: 10,),
      Container(color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(top: 18, left: 8, bottom: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Bollywood', style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text('See all', style: GoogleFonts.poppins(color: Color(0xfff6615e),fontSize: 12,fontWeight: FontWeight.normal,),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Filter('bollywood')));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.width*0.45,
              child:  StreamBuilder<QuerySnapshot>(
                  stream: dataBase.hollywood('bollywood',order),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(shrinkWrap: true,physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: ProfileCard(image: snapshot.data.documents[index]['profilephoto'],
                              name: '${snapshot.data.documents[index]['first']}',time: '${snapshot.data.documents[index]['price']}',),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ProfileView(snapshot.data.documents[index])));
                            },
                          );
                        },
                      );
                    }
                    return  Text('data',style: TextStyle(color: Colors.black));
                  }
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
      SizedBox(height: 40,)
    ],),);
  }
}
