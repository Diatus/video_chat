import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:reach/views/gallery_view.dart';
import 'package:reach/views/profile_card.dart';
import 'booking.dart';

class ProfileView extends StatefulWidget {

  final DocumentSnapshot snapshot;

  ProfileView(this.snapshot);

  @override
  _ProfileViewState createState() => _ProfileViewState();

}

class _ProfileViewState extends State<ProfileView> {

  CachedVideoPlayerController controller;
  String type;

  Future _visits()async{
    CollectionReference reference=Firestore.instance.collection('Celebrity');
    try{
      if(widget.snapshot.data['visits']!=null){
        reference.document(widget.snapshot.documentID).setData({
          'visits':widget.snapshot.data['visits']+1
        },merge: true);
      }else{
        reference.document(widget.snapshot.documentID).setData({
          'visits':1
        },merge: true);
      }
    }catch(e){
      print(e.toString());
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    _visits();
    controller = CachedVideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/video-chat-8b5f3.appspot.com/o/static%2FWoman%20-%2063241.mp4?alt=media&token=846d7bec-3a8f-481c-85b0-a3221e581d09')
      ..initialize().then((_) {

      });
    controller.play();
    controller.setVolume(10);
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
    return Scaffold(backgroundColor: Colors.white,body: Stack(children: [
      Align(alignment: Alignment.topCenter,
        child: AspectRatio(
          aspectRatio: 1/1,
          child: Stack(
            children: [
              CachedVideoPlayer(controller),
              Container(width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [
                  Colors.black12.withOpacity(0.01),
                  Colors.black12.withOpacity(0.01),
                  Colors.black.withOpacity(0.7)
                ])),
              ),
            ],
          ),
        ),
      ),

      Align(alignment: Alignment.topCenter,
        child: Container(width: MediaQuery.of(context).size.width,
          child: ListView(shrinkWrap: true,physics: ScrollPhysics(),
            children: [
              SizedBox(height: MediaQuery.of(context).size.width*0.6,),
              Container(width: MediaQuery.of(context).size.width,
                  child: ListTile(title: Text('Gallery',style: GoogleFonts.poppins(color: Color(0xfffdfdfc),fontWeight: FontWeight.w600),
                  ),trailing: Row(mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(widget.snapshot.data['rating']??'1.0',style: GoogleFonts.poppins(color: Color(0xfffdfdfc),fontWeight: FontWeight.w600),),
                      Icon(Icons.star,color: Color(0xffe7b429),size: 20,)
                    ],
                  ),)
              ),
              widget.snapshot.data['gallery']!=null?Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.width*0.45,
                child: ListView(shrinkWrap: true,physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: widget.snapshot.data['gallery'].map<Widget>((e){
                    return e['type']=='video'?CProfile(video: e['url'],
                      onclick: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>GalleryView(type: e['type'],file: e['url'],snapshot: widget.snapshot,)));
                      },):GestureDetector(
                        child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),elevation: 0,
                        child: AspectRatio(
                          aspectRatio: 0.5/0.6,
                          child: Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: CachedNetworkImage(imageUrl: e['url'],width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,fit: BoxFit.cover,),
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
                          ],),
                        ),),
                      onTap: (){
                          _gallery(context);
                      },
                      );
                    }).toList()
                ),
              ):Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.width*0.25,),
              Container(width: MediaQuery.of(context).size.width,
                  child: ListTile(title: Text('About',style: GoogleFonts.poppins(color: Colors.black,),
                  ),
                    trailing: Text('\$${widget.snapshot.data['price']}/min',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600),),
                  )
              ),
              Container(width: MediaQuery.of(context).size.width,color: Colors.transparent,
                padding: const EdgeInsets.all(12.0),
                child: Text(widget.snapshot.data['about']??'Not updated',
                    style: GoogleFonts.poppins(color: Colors.black,)),
              ),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
      Align(alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Row(
            children: [
              Expanded(flex: 2,
                child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,), onPressed: () {
                  Navigator.pop(context);
                },),
              ),
              Expanded(flex: 6,child: Text('${widget.snapshot.data['first']}', style: GoogleFonts.poppins(color: Color(0xfffdfdfc),fontSize: 24),)),
              Expanded(flex: 2,
                child: IconButton(icon: Image.asset('assets/sound.png',width: 30,height: 30,), onPressed: () {

                },),
              ),
            ],
          ),
        ),
      ),
    ],),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.only(left: 32,right: 32,bottom: 32,top: 4),
        child: Container(width: MediaQuery.of(context).size.width*0.6,
          height: 50,
          child: MaterialButton(elevation: 0,
              color: Color(0xfff6615e),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32),side: BorderSide(color: Color(0xffffffff))),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 52.0),
                child: Text("R.O", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Booking(widget.snapshot)));
              }
          ),
        ),
      ),
    );
  }

  _gallery(BuildContext context){
    showDialog(context: context, builder: (context)=>Stack(
      children: [
        Align(alignment: Alignment.center,
          child: Container(
              child: PageView(
                children: widget.snapshot.data['gallery'].map<Widget>((e){
                  return e['type']=='image'?Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: PhotoView(
                      imageProvider: NetworkImage(e['url']),
                      backgroundDecoration: BoxDecoration(color: Colors.transparent),
                      loadingBuilder: (context, event) => Center(
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            value: event == null
                                ? 0
                                : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                          ),
                        ),
                      ),
                    ),
                  ):Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: VideoViewCard(e['url']),
                  );
                }).toList()
              )
          ),
        ),
        Align(alignment: Alignment.topRight,child: Padding(
          padding: const EdgeInsets.only(right: 32,top: 32),
          child: GestureDetector(child: Icon(Icons.close,color: Colors.white,),
          onTap: (){
            Navigator.pop(context);
          },),
        ),)
      ],
    ));
  }
}



class VideoViewCard extends StatefulWidget {

  final String url;

  VideoViewCard(this.url);

  @override
  _VideoViewCardState createState() => _VideoViewCardState();
}

class _VideoViewCardState extends State<VideoViewCard> {

  CachedVideoPlayerController controller;



  @override
  void initState() {
    // TODO: implement initState
    controller=CachedVideoPlayerController.network(widget.url);
    controller.initialize().then((value) => {

    });
    controller.play();
    controller.setVolume(10);
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
    return Center(
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CachedVideoPlayer(controller),
      ),
    );
  }
}