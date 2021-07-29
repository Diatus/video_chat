import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController search=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,appBar: AppBar(elevation: 1,backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(padding: EdgeInsets.only(left: 8),
          height: 45,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(32)),
              color: Color(0xffe5e5e5)),
          child: Row(
            children: [
              Expanded(flex: 8,
                child: TextField(controller: search,
                  showCursor: true,textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Color(0xFF666666),),
                    hintText: 'Search',
                  ),
                ),
              ),
              Expanded(flex: 2,
                child: search.text.length>2?IconButton(icon: Icon(Icons.close,color: Color(0xff919191),size: 20,),
                  onPressed: (){
                  search.clear();
                },):Icon(Icons.search,color: Color(0xff919191),size: 20,),
              )
            ],
          ),
        ),
      ),
    ),
      body: Container(height: MediaQuery.of(context).size.height,
        child: ListView(children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 12,top: 8),
            child: Text('Recent searches',style: GoogleFonts.poppins(color: Colors.grey.shade500,)),
          ),
          ListTile(title: Text('Chris Hemsworth', style: GoogleFonts.poppins(color: Colors.black,),),
            trailing: IconButton(icon: Icon(Icons.close,color: Colors.grey,size: 20,),onPressed: (){

            },),),
          ListTile(title: Text('Chris Hemsworth', style: GoogleFonts.poppins(color: Colors.black,),),
            trailing: IconButton(icon: Icon(Icons.close,color: Colors.grey,size: 20,),onPressed: (){

            },),),
          ListTile(title: Text('Chris Hemsworth', style: GoogleFonts.poppins(color: Colors.black,),),
            trailing: IconButton(icon: Icon(Icons.close,color: Colors.grey,size: 20,),onPressed: (){

            },),),
        ],),
      ),
      bottomSheet: Container(height: 65,decoration: BoxDecoration(gradient: LinearGradient(colors: [
        Color(0xff00f6615e),
        Color(0xfff6615e),
        Color(0xff00f6615e),
      ],begin: Alignment.topLeft,end: Alignment.topRight)),
          padding: EdgeInsets.only(top: 3),
          child: Container(height: 64,child: BNavigation())),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.white,onPressed: () {
        BNavigation.index=1;
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => MyHome(),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 10),
          ),
        );
      },child: BNavigation.index!=1?Image.asset(
        'assets/home.png',
        width: 25,
        height: 25,
        fit: BoxFit.cover,
      ):Image.asset(
        'assets/home.png',
        width: 25,
        height: 25,
        color: Color(0xfff6615e),
        fit: BoxFit.cover,
      ),),
    );
  }
}
