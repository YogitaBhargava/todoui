import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoin/main.dart';



import 'cat.dart';
import 'dbhelper.dart';


class todoui extends StatefulWidget {
  @override
  _todouiState createState() => _todouiState();
}

class _todouiState extends State<todoui> {
  String welcomeMsg;




  @override
  void initState(){
    super.initState();


    welcomeMsg= Utils.getWelcomeMessage();}

  final dbhelper = Databasehelper.instance;

  final texteditingcontroller = TextEditingController();

  var myitems = List();

  var items = new List<String>();
  List<Widget> children = new List<Widget>();
  var txtDDone = new List<String>();



  var edt = false;
  var txtDList = new List<TextDecoration>();

  Future<bool> query() async {
    myitems = [];
    children = [];
    var allrows = await dbhelper.queryall();
    allrows.forEach((row) {
      myitems.add(row.toString());
      children.add(GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          }, child: Column(
          children: <Widget>[ Container( height: 298,width: 360, child:
          Card(

              elevation: 5.0,
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              child:Column(children: <Widget>
              [ Row(
                    mainAxisAlignment:MainAxisAlignment.end,children: <Widget>[
                  GestureDetector(
                      onTap: () {

                        dbhelper.deletedata(row['id']);
                        setState(() {});
                      },
                      child: Icon(Icons.delete, color:Colors.red,size: 30, )
                  ),]),

                Container(

                  padding: EdgeInsets.all(5.0),
                  child: ListTile(
                    title: Text(
                      row['todo'],
                      style: TextStyle(
                        fontSize: 18.0,

                      ),
                    ),

                  ),
                ),
              ])))])));
    });
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('    EEEE\n    d MMMM').format(now);

    return FutureBuilder(
      builder: (context, snap) {
        if (snap.hasData == null) {
          return Center(
            child: Text(
              "No Data",
            ),
          );
        }  else {
          var isCompleted;
          var task;

          return Scaffold(


            appBar: AppBar(
              centerTitle: true,

              backgroundColor: Colors.grey[600],
              elevation: 0,

              actions: <Widget>[





              ],


            ),

            backgroundColor: Colors.grey[600],
            body: SingleChildScrollView(
              child: Column(

                children: <Widget>[

                  Header(
                    msg: welcomeMsg,
                  ),

                  Text( formattedDate,style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 32.0,color: Colors.black, fontStyle: FontStyle.italic) ),


                  Container(

                      height:298,
                      width: 350,child: Card(child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>Cat()),
                          );
                        },
                        child
                            :
                        Icon(
                          Icons.add,
                          color: Colors.white,

                          size: 70,
                        ),),
                      Text("Add Todo",style: TextStyle(fontSize: 28,color: Colors.white,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
                    ],),


                  )),
                  Column(
                    children: children,
                  )
                ],
              ),
            ),
          );
        }

      },
      future: query(),
    );
  }
}


class Utils {


  static String getWelcomeMessage() {
    final hour = DateTime
        .now()
        .hour;
    String msg;

    if (hour < 12) {
      msg = 'Good Morning Yogita';
    } else if (hour < 18) {
      msg = 'Good Afternoon Yogita';
    } else {
      msg = 'Good Evening Yogita';
    }

    return msg;
  }
}


class Header extends StatelessWidget {
  final String msg;

  Header({this.msg});

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      child: Container(
        padding: EdgeInsets.only(left: 105.0, top: 10.0,),
        child: Text(
          msg,
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(fontSize: 22,color: Colors.white,fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}