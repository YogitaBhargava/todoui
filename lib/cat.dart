import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';





import 'dbhelper.dart';
import 'main.dart';



class Cat extends StatefulWidget {
  @override
  _CatState createState() => _CatState();
}

class _CatState extends State<Cat> {
  String newTask;

  final dbhelper = Databasehelper.instance;

  final texteditingcontroller = TextEditingController();
  bool validated = true;
  String errtext = "";
  String todoedited = "";
  var myitems = List();
  List<Widget> children = new List<Widget>(

  );




  void addtodo( ) async {

    Map<String, dynamic> row = {
      Databasehelper.columnName: todoedited,
    };
    final id = await dbhelper.insert(row);
    print(id);

    Navigator.push(context,MaterialPageRoute(builder: (context)=> MyApp()));
    todoedited = "";
    setState(() {
      validated = true;
      errtext = "";

    });
  }
  @override
  void initState(){
    super.initState();
    setState(() {
      newTask = '';

    });}


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "New Todo",
            style: TextStyle(
                fontSize: 22,  color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black26),
        ),
        body: Container( height: 900,

            width: 600,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 40,),

                  TextField(

                    controller: texteditingcontroller,
                    autofocus: true,
                    onChanged: (_val) {
                      todoedited = _val;
                    },
                    style: TextStyle(
                        fontSize: 28.0,
                        color: Colors.black

                    ),

                    decoration: InputDecoration(
                        errorText: validated ? null : errtext,
                        border: InputBorder.none,

                        hintText: "   Name...",
                        hintStyle: TextStyle(color: Colors.grey[400],fontSize: 36)
                    ),
                  ),

                  SizedBox(height: 60,),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 47, width: 200, child:
                        RaisedButton(
                          color: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            onPressed: () {
                              if (texteditingcontroller.text.isEmpty) {
                                setState(() {

                                  errtext = "      Ummm... It seems that you are trying to add an invisible task \n      which is not allowed in this realm";

                                  validated = false;
                                });
                              } else if (texteditingcontroller.text.length >
                                  512) {
                                setState(() {
                                  errtext = "Too may Characters";
                                  validated = false;
                                });
                              } else {
                                addtodo(

                                );

                              }
                            },

                            child:Row(
                                children: <Widget>[
                                  Icon(Icons.save),
                                  SizedBox(width: 11,),
                                  Text("Create New Todo",
                                      style: TextStyle(
                                        fontSize: 16.0,

                                      )),])
                        )),

                      ],
                    ),
                  ),]
            )

        )
    );
  }}

