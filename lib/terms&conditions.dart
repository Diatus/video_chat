import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(backgroundColor: Colors.white,elevation: 4,
            leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
              Navigator.pop(context);
            },),
            title: Text('Terms & Conditions', style: GoogleFonts.poppins(color: Colors.black,),),
            bottom: TabBar(
              isScrollable: true,
              labelStyle: GoogleFonts.poppins(color: Color(0xfffdfdfc),),
              indicatorWeight: 2.0,
              unselectedLabelColor: Colors.grey.shade500,
              labelColor: Colors.black,
              unselectedLabelStyle: GoogleFonts.poppins(color: Colors.green.withOpacity(0.5),),
              indicatorPadding: EdgeInsets.all(0),
              labelPadding: EdgeInsets.all(0),
              indicator:  ShapeDecoration(
                  shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,)),
                  gradient: LinearGradient(begin: Alignment.bottomLeft,end: Alignment.bottomRight,colors: [Color(0xff00f6615e),Color(0xfff6615e),Color(0xff00ffffff),])),
              tabs: <Widget>[
                Container(color: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Terms of Service"),
                ),
                Container(color: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Terms of Payment"),
                ),
                Container(color: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Usage of Policy"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              TOS(),
              TOP(),
              UOP(),
            ],
          ),
        )
    );
  }
}


class TOS extends StatefulWidget {
  @override
  _TOSState createState() => _TOSState();
}

class _TOSState extends State<TOS> {
  @override
  Widget build(BuildContext context) {
    return Container(child: ListView(children: [
      SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text('Terms and Conditions', style: GoogleFonts.poppins(color: Color(0xff363636).withOpacity(0.9),fontWeight: FontWeight.w600),),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text('Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur.',
          style: GoogleFonts.poppins(color: Color(0xff363636).withOpacity(0.5),),),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text('Services', style: GoogleFonts.poppins(color: Color(0xff363636).withOpacity(0.8),fontWeight: FontWeight.w600),),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text('Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur.',
          style: GoogleFonts.poppins(color: Color(0xff363636).withOpacity(0.5),),),
      ),
    ],),);
  }
}

class TOP extends StatefulWidget {
  @override
  _TOPState createState() => _TOPState();
}

class _TOPState extends State<TOP> {
  @override
  Widget build(BuildContext context) {
    return Container(child: ListView(children: [
      SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text('Terms and Conditions', style: GoogleFonts.poppins(color: Color(0xff363636).withOpacity(0.8),fontWeight: FontWeight.w600),),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text('Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur.',
          style: GoogleFonts.poppins(color: Color(0xff363636).withOpacity(0.5),),),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text('Services', style: GoogleFonts.poppins(color: Color(0xff363636).withOpacity(0.8),fontWeight: FontWeight.w600),),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text('Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur.',
          style: GoogleFonts.poppins(color: Color(0xff363636).withOpacity(0.5),),),
      ),
    ],),);
  }
}

class UOP extends StatefulWidget {
  @override
  _UOPState createState() => _UOPState();
}

class _UOPState extends State<UOP> {
  @override
  Widget build(BuildContext context) {
    return Container(child: ListView(children: [
      SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text('Terms and Conditions', style: GoogleFonts.poppins(color: Color(0xff363636).withOpacity(0.8),fontWeight: FontWeight.w600),),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text('Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur.',
          style: GoogleFonts.poppins(color: Color(0xff363636).withOpacity(0.5),),),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text('Services', style: GoogleFonts.poppins(color: Color(0xff363636).withOpacity(0.8),fontWeight: FontWeight.w600),),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text('Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur.',
          style: GoogleFonts.poppins(color: Color(0xff363636).withOpacity(0.5),),),
      ),
    ],),);
  }
}
