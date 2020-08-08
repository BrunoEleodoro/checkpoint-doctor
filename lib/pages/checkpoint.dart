import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:checkpoint_doctor/pages/passos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class CheckPointPage extends StatefulWidget {
  var patientKey = "";
  CheckPointPage({this.patientKey});
  @override
  _CheckPointPageState createState() => _CheckPointPageState();
}

class _CheckPointPageState extends State<CheckPointPage> {
  var address = "a";
  SharedPreferences prefs;
  bool viewCode = false;
  bool isLoading = false;
  TextEditingController controller = TextEditingController();

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

  void registrarAction() async {
    setState(() {
      isLoading = true;
    });
    final client = Web3Client(
        "https://rinkeby.infura.io/v3/6c35b5b0fa1b4010be4f0db6e60002cb",
        http.Client());
    rootBundle.loadString('assets/standardToken.json').then((abi) async {
      final contract = DeployedContract(
          ContractAbi.fromJson(abi, "StandardTOken"),
          EthereumAddress.fromHex(
              "0xEE3f7ac5BEE1388ca89d01A55F02CF93f3003869"));
      Credentials credentials =
          EthPrivateKey.fromHex('0x' + prefs.getString('privKey'));
      var transfer = contract.function('performAction');
      var timestamp = new DateTime.now().millisecondsSinceEpoch;
      print((await credentials.extractAddress()).hex);
      await client
          .sendTransaction(
              credentials,
              Transaction.callContract(
                  contract: contract,
                  function: transfer,
                  maxGas: 500000,
                  parameters: [
                    EthereumAddress.fromHex(widget.patientKey),
                    prefs.getString('hospital'),
                    controller.text,
                    BigInt.from(timestamp),
                    BigInt.from(timestamp)
                  ]),
              chainId: 4)
          .then((hash) {
        print(hash);
        setState(() {
      isLoading = false;
    });
        AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.BOTTOMSLIDE,
            tittle: 'Sucesso',
            desc: 'A transação foi enviada para ser computada.\n\nObrigado.',
            btnCancelOnPress: () {
              Navigator.pop(context);
            },
            btnOkOnPress: () {
              Navigator.pop(context);
            }).show();
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    print(prefs.getString('pubKey'));
    // print([
    //                 widget.patientKey,
    //                 "Nome do Hospital X",
    //                 controller.text,
    //                 BigInt.from(12313),
    //                 BigInt.from(12313)
    //               ]);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
                  Text(
                    'Descreva os detalhes do Atendimento',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 30.0),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                Container(
                  width: double.maxFinite,
                  // height: 200,
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: (isLoading) ? Center(child: CircularProgressIndicator(),) : Card(
                    elevation: 5,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                                hintText: 'Digite a descrição...'),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            autofocus: true,
                            maxLength: 100,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton.icon(
                              onPressed: () {
                                registrarAction();
                              },
                              color: Colors.green[300],
                              label: Text(
                                'REGISTRAR',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
