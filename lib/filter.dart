import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reach/profile_view.dart';
import 'package:reach/services/data_provider.dart';
import 'package:reach/views/profile_card.dart';


class Filter extends StatefulWidget {
  final String filter;

  Filter(this.filter);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {

  String order='bookings';
  String sort='Popular';

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),
      onPressed: (){
      Navigator.pop(context);
    },),title: Text('${widget.filter}',style: GoogleFonts.poppins(color: Colors.black)),
      backgroundColor: Colors.white,elevation: 1,),
      body: ListView(shrinkWrap: true, physics: BouncingScrollPhysics(),children: [
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
        StreamBuilder<QuerySnapshot>(
          stream: dataBase.hollywood(widget.filter,order),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Padding(
                padding: const EdgeInsets.only(left: 12,right: 12),
                child: GridView.builder(shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProfileCard2(image: snapshot.data.documents[index]['profilephoto'],
                            name: '${snapshot.data.documents[index]['first']}',time: '${snapshot.data.documents[index]['price']}',),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ProfileView(snapshot.data.documents[index])));
                        },
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 11.6/12.5,
                    )),
              );
            }
            return Center(child: CircularProgressIndicator(),);
          }
        )
      ],),
    );
  }
}
