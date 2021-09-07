import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'networking.dart';
import 'constants.dart';

var currency = 'USD';
var pricebit;
var priceeth;
var priceltc;

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
      underline: Container(
        color: Colors.transparent,
      ),
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
    var bitdata = await networking.bitcoin(currency);
    var ethdata = await networking.eth(currency);
    var ltcdata = await networking.ltc(currency);
    setState(() {
      priceeth = ethdata;
      pricebit = bitdata;
      priceltc = ltcdata;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Crypto Ticker',
          style: TextStyle(
            fontFamily: 'Allison',
            letterSpacing: 1,
            color: Color(0xFFD8DEE9),
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Color(0xFF2E3440),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          card(
            text: Text(
              '1 BTC = $pricebit $currency',
              textAlign: TextAlign.center,
              style: KTextstyle,
            ),
          ),
          card(
            text: Text(
              '1 ETH = $priceeth $currency',
              textAlign: TextAlign.center,
              style: KTextstyle,
            ),
          ),
          card(
            text: Text(
              '1 LTC = $priceltc $currency',
              textAlign: TextAlign.center,
              style: KTextstyle,
            ),
          ),
          Container(
            height: 130.0,
            alignment: Alignment.center,
            // padding: EdgeInsets.only(bottom: 30.0),
            color: Color(0xFF2E3440),
            child: getpicker(),
          ),
        ],
      ),
    );
  }
}

class card extends StatelessWidget {
  card({required this.text});
  Widget text;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Card(
          color: Color(0xFF4C566A),
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              child: text,
            ),
          ),
        ),
      ),
    );
  }
}
