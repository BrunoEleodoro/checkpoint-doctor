import 'package:flutter/material.dart';

class PassosPage extends StatefulWidget {
  var consulta = {};
  PassosPage({this.consulta});
  @override
  _PassosPageState createState() => _PassosPageState();
}

class _PassosPageState extends State<PassosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.maxFinite,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: Color(0XFFA4D266),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        child: Text(
                          'H',
                          style: TextStyle(fontSize: 25),
                        ),
                        radius: 40,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 70,
                        child: Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Hospital Capital Hospital',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '20/04/2020',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 150,
                height: 30,
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/passos.png'),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Passos:',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.consulta['steps'].length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: 8, right: 8, bottom: 16),
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.only(left: 8, right: 8, bottom: 10),
                    child: Card(
                        color: Color(0xFFA4D266),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: CircleAvatar(
                                  backgroundColor: Colors.greenAccent,
                                  child: Text(widget.consulta['steps'][index]
                                          ['title']
                                      .toString()[0]),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 8,
                                child: Text(
                                  widget.consulta['steps'][index]['title'],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
