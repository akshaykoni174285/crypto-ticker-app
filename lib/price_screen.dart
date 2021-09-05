import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'networking.dart';

var currency = 'USD';
var pricebit;
var priceeth;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Networking networking = Networking(currency: currency);

  DropdownButton<String> androidropdown() {
    List<DropdownMenuItem<String>> dropdownitems = [];
    for (String currency in currenciesList) {
      var dropdownmenu = DropdownMenuItem(
          child: Text(
            currency,
            style: TextStyle(
              color: Color(0xFFD08770),
              fontWeight: FontWeight.bold,
            ),
          ),
          value: currency);
      dropdownitems.add(dropdownmenu);
    }
    return DropdownButton<String>(
      dropdownColor: Color(0xFF3B4252),
      value: currency,
      items: dropdownitems,
      onChanged: (String? value) {
        setState(() {
          currency = value.toString();
          updateUI();
        });
      },
    );
  }

  CupertinoPicker ioselctor() {
    List<Widget> currency = [];
    for (String name in currenciesList) {
      currency.add(Text(
        name,
        style: TextStyle(
          letterSpacing: 1,
          color: Color(0xFFA3BE8C),
          fontWeight: FontWeight.bold,
        ),
      ));
    }

    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (value) {
        setState(() {
          // currency = currenciesList[value];
          // updateUI();
        });
      },
      children: currency,
    );
  }

  Widget getpicker() {
    if (Platform.isAndroid) {
      return androidropdown();
    } else if (Platform.isIOS) {
      return ioselctor();
    } else
      return androidropdown();
  }

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  void updateUI() async {
    var data = await networking.bitcoin(currency);
    var ethdata = await networking.eth(currency);
    setState(() {
      priceeth = ethdata;
      pricebit = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 1,
        title: Text('Crypto Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Color(0xFF4C566A),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $pricebit $currency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Color(0xFF4C566A),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $priceeth $currency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Color(0xFF4C566A),
            child: getpicker(),
          ),
        ],
      ),
    );
  }
}
