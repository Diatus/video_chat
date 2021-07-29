import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCard extends StatelessWidget {

  final String image;
  final String time;
  final String name;

  ProfileCard({this.image, this.time, this.name});

  @override
  Widget build(BuildContext context) {
    return Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),elevation: 0,
      child: Container(width: MediaQuery.of(context).size.width*0.35,height: MediaQuery.of(context).size.width*0.45,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Stack(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(imageUrl: image,fit: BoxFit.cover,height: MediaQuery.of(context).size.height,)
            ),
            Align(alignment: Alignment.bottomCenter,
              child: Container(height: MediaQuery.of(context).size.width*0.45,width: MediaQuery.of(context).size.width*0.35,
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [
                  Colors.black12.withOpacity(0.01),
                  Colors.black12.withOpacity(0.01),
                  Colors.black.withOpacity(0.7)
                ])),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('$name',style: GoogleFonts.poppins(color: Color(0xfffdfdfc),fontSize: 14,fontWeight: FontWeight.w600),),
                ),),),
            Align(alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(width: 60,height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Color(0xff000000).withOpacity(0.5),borderRadius: BorderRadius.only(topRight: Radius.circular(4),bottomRight: Radius.circular(4),bottomLeft: Radius.circular(4))),
                child: Text('\$$time/min',style: GoogleFonts.poppins(color: Color(0xfffdfdfc),fontSize: 12),),),
            ),)
          ],),
      ),);
  }
}

class ProfileCard2 extends StatelessWidget {

  final String image;
  final String time;
  final String name;

  ProfileCard2({this.image, this.time, this.name});

  @override
  Widget build(BuildContext context) {
    return Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),elevation: 0,
      child: AspectRatio(
        aspectRatio: 11.6/12.5,
        child: Stack(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(imageUrl: image,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,)
          ),
          Align(alignment: Alignment.bottomCenter,
            child: Container(height: MediaQuery.of(context).size.width,width: MediaQuery.of(context).size.height,
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [
                Colors.black12.withOpacity(0.01),
                Colors.black12.withOpacity(0.01),
                Colors.black.withOpacity(0.7)
              ])),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$name',style: GoogleFonts.poppins(color: Color(0xfffdfdfc),fontSize: 14,fontWeight: FontWeight.w600),),
              ),),),
          Align(alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(width: 50,height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Color(0xff000000).withOpacity(0.5),borderRadius: BorderRadius.only(topRight: Radius.circular(4),bottomRight: Radius.circular(4),bottomLeft: Radius.circular(4))),
                child: Text('\$$time/min',style: GoogleFonts.poppins(color: Color(0xfffdfdfc),fontSize: 12),),),
            ),)
        ],),
      ),);
  }
}


class CProfile extends StatefulWidget {

  final String video;
  final Function onclick;

  CProfile({this.video,this.onclick});


  @override
  _CProfileState createState() => _CProfileState();
}

class _CProfileState extends State<CProfile> {

  CachedVideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = CachedVideoPlayerController.network(widget.video);
    controller.initialize().then((e) {
      setState(() {});

    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),elevation: 0,
        child: AspectRatio(
          aspectRatio: 0.5/0.6,
          child: Stack(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedVideoPlayer(controller),
            ),
            Align(alignment: Alignment.bottomCenter,
              child: Container(height: MediaQuery.of(context).size.width,width: MediaQuery.of(context).size.height,
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [
                  Colors.black12.withOpacity(0.01),
                  Colors.black12.withOpacity(0.01),
                  Colors.black.withOpacity(0.7)
                ])),
              ),),
            Align(alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.play_circle_outline,color: Colors.white,),
              ),)
          ],),
        ),),
      onTap: widget.onclick,
    );
  }
}
