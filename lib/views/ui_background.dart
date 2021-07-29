import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
         Container(height: MediaQuery.of(context).size.height*0.33,
         color: Color(0xfff69492),),
        Container(height: MediaQuery.of(context).size.height*0.33,
          color: Color(0xfff78481),),
        Container(height: MediaQuery.of(context).size.height*0.34,width: MediaQuery.of(context).size.width,
          color: Color(0xfff6615e),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [
          Text('REACH',style: GoogleFonts.poppins(color: Colors.white,fontSize: 28,letterSpacing: 1,fontWeight: FontWeight.bold)),
          Text('R.O for it',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500))
        ],),),
      ],),
    );
  }
}
