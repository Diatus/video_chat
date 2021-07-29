import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingCard extends StatelessWidget {

  final String image;
  final String name;
  final String date;
  final String filter;
  final String status;
  final String amount;

  BookingCard({this.image, this.name, this.date,this.filter, this.status, this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Row(children: [
        Expanded(flex: 2,child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CachedNetworkImage(imageUrl: image,fit: BoxFit.cover,width: MediaQuery.of(context).size.width,height: 80,)
        ),),
        Expanded(flex: 8,
          child: ListTile(title: Row(
            children: [
              Expanded(flex: 8,
                  child: Text('$name',style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600))
              ),
              Expanded(flex: 3,
                  child: Text('$amount',style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600))
              ),
            ],
          ),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$date',style: GoogleFonts.poppins(color: Colors.grey.shade500,fontSize: 13)),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text('$status',
                      style: GoogleFonts.poppins(color: filter=='Awaited'?Color(0xffffda3e):filter=='Scheduled'?Color(0xfff6615e):Color(0xff35b74e),fontSize: 13)),
                )
              ],
            ),
          ),
        )
      ],),
    );
  }
}


