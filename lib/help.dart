import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {

  bool general=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Help',style: GoogleFonts.poppins(color: Colors.black,)),
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
          Navigator.pop(context);
        },),
      backgroundColor: Colors.white,elevation: 1,),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('How can we\n help you?',style: GoogleFonts.poppins(color: Colors.black,fontSize: 32,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(decoration: BoxDecoration(color: Color(0xff2c2c2c),borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade700,blurRadius: 12,),
                BoxShadow(color: Colors.grey),
              ]),
            padding: EdgeInsets.all(8),
            child: ListTile(leading: Image.asset('assets/guide.png',width: 40,height: 40,),
              title:  Text('Guide',style: GoogleFonts.poppins(color: Color(0xfffdfdfc),fontWeight: FontWeight.w600,fontSize: 18)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(decoration: BoxDecoration(color: Color(0xff2c2c2c),borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade700,blurRadius: 12,),
                BoxShadow(color: Colors.grey),
              ]),
            padding: EdgeInsets.all(8),
            child: ListTile(leading: Image.asset('assets/faq.png',width: 40,height: 40,),
              title:  Text('FAQ',style: GoogleFonts.poppins(color: Color(0xfffdfdfc),fontWeight: FontWeight.w600,fontSize: 18)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(decoration: BoxDecoration(color: Color(0xff2c2c2c),borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade700,blurRadius: 12,),
                BoxShadow(color: Colors.grey),
              ]),
            padding: EdgeInsets.all(8),
            child: ListTile(leading: Image.asset('assets/group.png',width: 40,height: 40,),
              title:  Text('Community',style: GoogleFonts.poppins(color: Color(0xfffdfdfc),fontWeight: FontWeight.w600,fontSize: 18)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Getting Started',style: GoogleFonts.poppins(color: Colors.black,fontSize: 32,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(decoration: BoxDecoration(color: Color(0xfff4f4f4),borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(8),
            child: ExpansionTile(title: Text('General Description',style: GoogleFonts.poppins(color: Color(0xfff6615e),fontWeight: FontWeight.w500,fontSize: 18)),
              trailing: CircleAvatar(backgroundColor: Color(0xfff6615e).withOpacity(0.2),child: !general?Icon(Icons.keyboard_arrow_down,color: Color(0xfff6615e),):Icon(Icons.keyboard_arrow_up,color: Color(0xfff6615e),),),
              onExpansionChanged: (v){
              setState(() {
                general=v;
              });
              },initiallyExpanded: general,
              children: [
                Text("In my serious point, General discussion, as spoken by the community, is anything that is within the game's grasp for ideas and personal thoughts within that game. If you have opinions to contrast others with, you discuss it to the General discussion page.",style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5),)),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(decoration: BoxDecoration(color: Color(0xfff4f4f4),borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(8),
            child: ExpansionTile(title: Text('Profile Edit',style: GoogleFonts.poppins(color: Color(0xfff6615e),fontWeight: FontWeight.w500,fontSize: 18)),
              trailing: CircleAvatar(backgroundColor: Color(0xfff6615e).withOpacity(0.2),child: !general?Icon(Icons.keyboard_arrow_down,color: Color(0xfff6615e),):Icon(Icons.keyboard_arrow_up,color: Color(0xfff6615e),),),
              onExpansionChanged: (v){
                setState(() {
                  general=v;
                });
              },initiallyExpanded: general,
              children: [
                Text("In my serious point, General discussion, as spoken by the community, is anything that is within the game's grasp for ideas and personal thoughts within that game. If you have opinions to contrast others with, you discuss it to the General discussion page.",style: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5),)),
              ],
            ),
          ),
        ),
        SizedBox(height: 10,)
      ],),
    );
  }
}
