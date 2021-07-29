import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:reach/services/auth.dart';
import 'package:reach/services/data_provider.dart';
import 'package:reach/services/payment_services.dart';


class Wallet extends StatefulWidget {
  const Wallet({Key key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();

}

class _WalletState extends State<Wallet> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white10.withOpacity(0.95),appBar: AppBar(backgroundColor: Colors.white,elevation: 1,
      leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
        Navigator.pop(context);
      },),
      title: Text('Wallet', style: GoogleFonts.poppins(color: Colors.black,),),
    ),
      body: ListView(shrinkWrap: true,children: [
        SizedBox(height: 10),
        StreamBuilder<DocumentSnapshot>(
          stream: dataBase.profile(),
          builder: (context, snapshot) {
            if(snapshot.hasData&&snapshot.data.exists){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(elevation: 0,child: ListTile(contentPadding: EdgeInsets.all(12),leading: Icon(Icons.account_balance_wallet_outlined,size: 45),
                  title: Text('Wallet Summary', style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('Current Balance  \$${snapshot.data['wallet']??0}', style: GoogleFonts.poppins(color: Colors.black,),),
                  ),),),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(elevation: 0,child: ListTile(contentPadding: EdgeInsets.all(12),leading: Icon(Icons.account_balance_wallet_outlined,size: 45),
              title: Text('Wallet Summary', style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('Current Balance  \$ 0', style: GoogleFonts.poppins(color: Colors.black,),),
              ),),),
            );
          }
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(width: MediaQuery.of(context).size.width*0.8,
            height: 50,
            child: MaterialButton(elevation: 0,
                color: Color(0xfff6615e),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),side: BorderSide(color: Color(0xffffffff))),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 52.0),
                  child: Text("Recharge Wallet", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
                onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>RechargeWallet()));
                }
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(elevation: 0,child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,children: [
            Padding(
              padding: const EdgeInsets.only(left: 8,top: 12,bottom: 12),
              child: Text("Wallet Activity", style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: dataBase.payments(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return snapshot.data.documents.length>0?ListView.builder(shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                    title: Text('${snapshot.data.documents[index]['time']}',style: GoogleFonts.poppins(color: Colors.black,)),
                      subtitle: Text('${DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data.documents[index]['time']))}'),
                      trailing: Text('+${double.parse(snapshot.data.documents[index]['amount'].toString())}',
                          style: GoogleFonts.poppins(color: Color(0xfff6615e),fontWeight: FontWeight.bold,fontSize: 18)),
                    );
                  },):Center(child: Padding(
                    padding: const EdgeInsets.only(top: 12,bottom: 12),
                    child: Text('No activities found', style: GoogleFonts.poppins(color: Colors.black,),),
                  ),);
                }
              return Center(child: Padding(
                padding: const EdgeInsets.only(top: 12,bottom: 12),
                child: CircularProgressIndicator(),
              ));
              }
            )
          ],),),
        )
      ],),
    );
  }
}



class RechargeWallet extends StatefulWidget {
  const RechargeWallet({Key key}) : super(key: key);

  @override
  _RechargeWalletState createState() => _RechargeWalletState();
}

class _RechargeWalletState extends State<RechargeWallet> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController amount=new TextEditingController();
  String method='card';
  String apiKey = '';


  payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    await UserServices().getWallet();
    dialog.style(
        message: 'Please wait...'
    );
    await dialog.show();
    var response = await StripeService.payWithNewCard(
        amount: (int.parse(amount.text)*100).toString(),
        currency: 'INR'
    );
    if(response.success){
      CollectionReference reference=Firestore.instance.collection('Payments');
     await reference.document().setData({
        'paymentID':response.paymentID,
        'methodID':response.methodID,
        'user':UserServices.uid,
        'amount':double.parse(amount.text),
        'time':DateTime.now().millisecondsSinceEpoch
      },merge: true);
     CollectionReference collectionReference=Firestore.instance.collection('Users');
     await collectionReference.document(UserServices.uid).setData({
       'wallet':(double.parse(amount.text)+double.parse(UserServices.wallet.toString())).toDouble()
     },merge: true);
     await UserServices().getWallet();
      await dialog.hide();
      Fluttertoast.showToast(msg: 'Transaction successful');
      Navigator.pop(context);
    }
    else{
      await dialog.hide();
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(response.message),
            duration: new Duration(milliseconds: response.success == true ? 1200 : 3000),
          )
      );
    }

  }

  bitCoinPayment()async{
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(
        message: 'Please wait...'
    );


  }
  @override
  void initState() {
    // TODO: implement initState
    StripeService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,backgroundColor: Colors.white10.withOpacity(0.95),appBar: AppBar(backgroundColor: Colors.white,elevation: 1,
      leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
        Navigator.pop(context);
      },),
      title: Text('Recharge Wallet', style: GoogleFonts.poppins(color: Colors.black,),),
    ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(controller: amount,
            showCursor: true,textAlign: TextAlign.left,
            style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Color(0xFF666666),),
              hintText: "",
              labelText: 'Amount',
              labelStyle: GoogleFonts.poppins(color: Colors.black,)
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(elevation: 0,child: ListTile(contentPadding: EdgeInsets.all(12),
            title: Text('Credit/debit Cards', style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500),),
            trailing: Radio(activeColor:Color(0xfff6615e),onChanged: (value) {
              setState(() {
                method=value;
              });
            }, value: 'card', groupValue: method,),
            ),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(elevation: 0,child: ListTile(contentPadding: EdgeInsets.all(12),
            title: Text('Bit Coin', style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500),),
            trailing: Radio(activeColor:Color(0xfff6615e),onChanged: (value) {
              setState(() {
                method=value;
              });
            }, value: 'coin', groupValue: method,),
          ),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(width: MediaQuery.of(context).size.width*0.8,
            height: 50,
            child: MaterialButton(elevation: 0,
                color: Color(0xfff6615e),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),side: BorderSide(color: Color(0xffffffff))),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 52.0),
                  child: Text("Recharge Wallet", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),
                ),
                onPressed: (){
                  if(amount.text.length>0){
                    if(method=='card'){
                      payViaNewCard(context);
                    }else{
                      bitCoinPayment();
                    }
                  }else{
                    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Enter a valid amount')));
                  }
                }
            ),
          ),
        ),
      ],),
    );
  }
}
