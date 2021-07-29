import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../booking.dart';
import '../profile_view.dart';

class GalleryView extends StatefulWidget {

  final String type;
  final String file;
  final DocumentSnapshot snapshot;
  const GalleryView({Key key,this.type,this.file,this.snapshot}) : super(key: key);

  @override
  _GalleryViewState createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {

  CachedVideoPlayerController controller;


  @override
  void initState() {
    // TODO: implement initState
    if(widget.type=='video'){
      controller=CachedVideoPlayerController.network(widget.file);
      controller.initialize().then((value) => {

      });
      controller.play();
      controller.setVolume(10);
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      body: Stack(children: [
        Center(
          child: AspectRatio(
            aspectRatio: 1/2,
            child: widget.type=='video'?CachedVideoPlayer(controller):CachedNetworkImage(imageUrl: widget.file,fit: BoxFit.contain),
          ),
        ),
        Align(alignment: Alignment.topCenter,
          child: AppBar(backgroundColor: Colors.transparent,title: Text('${widget.snapshot.data['first']}', style: GoogleFonts.poppins(color: Color(0xfffdfdfc),),
          ),
            actions: [
              IconButton(icon: Icon(Icons.speaker_phone,color: Colors.white,), onPressed: () {

              },)
            ],
          ),
        ),
        // Align(alignment: Alignment.bottomCenter,
        //   child: Column(mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Container(width: MediaQuery.of(context).size.width*0.8,
        //         height: 50,
        //         child: MaterialButton(
        //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32),side: BorderSide(color: Color(0xffffffff))),
        //             child: Padding(
        //               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 52.0),
        //               child: Text("View Profile", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),
        //             ),
        //             onPressed: () async{
        //               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ProfileView(widget.snapshot)));
        //             }
        //         ),
        //       ),
        //       SizedBox(height: 20,),
        //       Container(width: MediaQuery.of(context).size.width*0.8,
        //         height: 50,
        //         child: MaterialButton(elevation: 0,
        //             color: Color(0xfff6615e),
        //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32),side: BorderSide(color: Color(0xffffffff))),
        //             child: Padding(
        //               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 52.0),
        //               child: Text("R.O", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),
        //             ),
        //             onPressed: () {
        //               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Booking(widget.snapshot)));
        //             }
        //         ),
        //       ),
        //       SizedBox(height: 40,),
        //     ],
        //   ),
        // ),
      ],),
    );
  }
}
