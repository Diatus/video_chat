import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_channel.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reach/services/data_provider.dart';

class LiveStream extends StatefulWidget {

  final DocumentSnapshot snapshot;
  const LiveStream({Key key,this.snapshot}) : super(key: key);

  @override
  _LiveStreamState createState() => _LiveStreamState();
}

class _LiveStreamState extends State<LiveStream> {

  RtcEngine _engine;
  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];
  TextEditingController _controller=new TextEditingController();
  String chanel;
  bool mute=false;

  @override
  void initState() {
    super.initState();
    this._initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  _initEngine() async {
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig('93370cbda96a41d48f9f6c38c4480c00'));
    this._addListeners();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
    await _joinChannel();
  }

  _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        log('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        setState(() {
          isJoined = true;
        });
      },
      userJoined: (uid, elapsed) {
        log('userJoined  ${uid} ${elapsed}');
        setState(() {
          remoteUid.add(uid);
        });
      },
      userOffline: (uid, reason) {
        log('userOffline  ${uid} ${reason}');
        setState(() {
          remoteUid.removeWhere((element) => element == uid);
        });
      },
      leaveChannel: (stats) {
        log('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
    ));
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel('00693370cbda96a41d48f9f6c38c4480c00IADQ1VSPV30OseI5QEzedmlyCJExjPydis64vDVOPjiR6DG1dm0AAAAAEAD/3NMfysuzYAEAAQDJy7Ng', 'Guest', null, 0);
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
    Navigator.pop(context);
  }

  _switchCamera() {
    _engine.switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {
      log('switchCamera $err');
    });
  }

  _switchRender() {
    setState(() {
      switchRender = !switchRender;
      remoteUid = List.of(remoteUid.reversed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: dataBase.liveStatus(widget.snapshot.documentID),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        _renderVideo(),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18,top: 0,bottom: 24),
                              child: Text('${snapshot.data['name']}', style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 24,),),
                            ),
                            // Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //   Container(width: 120,height: 40,alignment: Alignment.center,
                            //   decoration: BoxDecoration(color: Color(0xffa09e9e).withOpacity(0.5),borderRadius: BorderRadius.circular(32)),
                            //   child: CountdownTimer(
                            //     widgetBuilder: (_, time) {
                            //       if (time == null) {
                            //         return Text('${time.min}:${time.sec} left',style:GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20,),);
                            //       }
                            //       return Text('Meeting completed',textAlign: TextAlign.center,style:GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,));
                            //     },
                            //     textStyle: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20,),
                            //     onEnd: (){
                            //
                            //     },
                            //     endTime: DateTime.fromMillisecondsSinceEpoch(snapshot.data['scheduledtime']+snapshot.data['duration']*60*1000).millisecondsSinceEpoch,
                            //   ),),
                            //   ],
                            // ),
                            SizedBox(height: 30,),
                            Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(flex: 4,child: CircleAvatar(radius: 25,backgroundColor: Color(0xff000000).withOpacity(0.5),
                                  child: IconButton(icon: Icon(Icons.flip_camera_ios_outlined,color: Colors.white),
                                      onPressed: () async {
                                    await _engine.switchCamera();
                                      }),),),
                                Expanded(flex: 2,
                                  child: Container(width: MediaQuery.of(context).size.width*0.35,alignment: Alignment.centerRight,
                                    child: CircleAvatar(radius: 30,backgroundColor: Color(0xffee3731),
                                      child: IconButton(icon: Icon(Icons.call_end,color: Colors.white),
                                          onPressed: _leaveChannel),),
                                  ),
                                ),
                                Expanded(flex: 4,
                                  child: CircleAvatar(radius: 25,backgroundColor: Color(0xff000000).withOpacity(0.5),
                                    child: IconButton(icon: Icon(mute?Icons.mic_off_rounded:Icons.mic,color: Colors.white),
                                        onPressed: (){
                                          setState(() {
                                            mute = !mute;
                                          });
                                          _engine.muteLocalAudioStream(mute);
                                        }),),
                                ),
                              ],
                            ),
                            SizedBox(height: 30,)
                          ],
                        ),
                      ),
                    ),
                    Align(alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 32,left: 4),
                        child: IconButton(icon: Icon(Icons.arrow_back_outlined,size: 35,color: Colors.white),onPressed: (){
                          Navigator.pop(context);
                        },),
                      ),)
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator(),);
          }
      ),
    );
  }

  _renderVideo() {
    return Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          RtcLocalView.SurfaceView(),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 12,top: 44),
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.of(remoteUid.map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                        onTap: this._switchRender,
                        child: Container(
                              width: 120,
                              height: 160,decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child:RtcRemoteView.SurfaceView(
                                    uid: e,
                                  )
                              )
                        ),
                      ),
                          ),
                    )),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
