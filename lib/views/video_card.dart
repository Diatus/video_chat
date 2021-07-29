import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reach/views/video_view.dart';


class VideoCard extends StatefulWidget {
  final String image;
  final String time;
  final String name;
  final DocumentSnapshot snapshot;
  final Function onClick;
  VideoCard({this.image, this.time, this.name,this.snapshot,this.onClick});

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {

  CachedVideoPlayerController controller;



  @override
  void initState() {
    // TODO: implement initState
    controller=CachedVideoPlayerController.network(widget.snapshot.data['video']);
    controller.initialize().then((value) => {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3/2.1,
      child: Stack(
        children: [
          Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),elevation: 0,
            child: AspectRatio(
              aspectRatio: 3/2,
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: AspectRatio(
                    aspectRatio: 3/2,
                    child: CachedVideoPlayer(controller),
                  ),
                ),
                Align(alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [
                      Colors.black12.withOpacity(0.01),
                      Colors.black12.withOpacity(0.01),
                      Colors.black.withOpacity(0.7)
                    ])),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${widget.name}',style: GoogleFonts.poppins(color: Color(0xfffdfdfc),fontSize: 14,fontWeight: FontWeight.w600),),
                    ),),),
                Align(alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: IconButton(icon: Icon(Icons.play_circle_outline,color: Colors.white,size: 30,),onPressed: (){

                      },)
                  ),),
                Align(alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(width: 60,height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Color(0xff000000).withOpacity(0.5),borderRadius: BorderRadius.only(topRight: Radius.circular(4),bottomRight: Radius.circular(4),bottomLeft: Radius.circular(4))),
                      child: Text('\$${widget.time}/min',style: GoogleFonts.poppins(color: Color(0xfffdfdfc),fontSize: 12),),),
                  ),)
              ],),
            ),),
          Align(alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Container(width: 60,height: 35,
                child: RaisedButton(elevation: 0,color: Color(0xfff6615e),onPressed: widget.onClick,
                  child: Text('R.O',style: GoogleFonts.poppins(color: Color(0xfffdfdfc),fontSize: 16)),),
              ),
            ),
          )
        ],
      ),
    );
  }
}


