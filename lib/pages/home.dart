import 'package:barcode_scan/barcode_scan.dart';
import 'package:checkpoint_doctor/pages/checkpoint.dart';
import 'package:checkpoint_doctor/pages/passos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var address = "a";
  SharedPreferences prefs;
  bool viewCode = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      prefs = await SharedPreferences.getInstance();
      setState(() {
        address = prefs.getString('pubKey');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(address);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                'Seja bem vindo(a), Doutor!',
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                child: QrImage(
                  data: address,
                  version: QrVersions.auto,
                  size: 180.0,
                ),
              ),
            ),
            Text((viewCode) ? address : ""),
            Center(
              child: Container(
                width: 100,
                child: Divider(
                  thickness: 2,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 80,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 60,
                      height: 60,
                      child: Card(
                        elevation: 3,
                        child: Center(
                          child: Image.asset('assets/print.png'),
                        ),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        viewCode = !viewCode;
                      });
                    },
                    child: Container(
                        width: 60,
                        height: 60,
                        child: Card(
                          elevation: 3,
                          color: (viewCode) ? Colors.grey : Colors.white,
                          child: Center(
                            child: Image.asset('assets/view_code.png'),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: 100,
                child: Divider(
                  thickness: 2,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      try {
                        var result = await BarcodeScanner.scan();
                        if (result != null && result != "") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckPointPage(
                                    patientKey: result,
                                  )));
                        }
                      } catch (ex) {
                        print('exception');
                      }
                    },
                    child: Container(
                        width: 120,
                        height: 120,
                        child: Card(
                          elevation: 3,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/add.png'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Nova Consulta')
                              ],
                            ),
                          ),
                        )),
                  ),
                  ],
              ),
            ),
            Center(
              child: Container(
                width: 100,
                child: Divider(
                  thickness: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
