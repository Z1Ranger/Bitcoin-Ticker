import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'dart:math';

import 'coin_data.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var dataInfo;

  String curVal;
  String btcVal = '?';
  String ethVal = '?';
  String ltcVal = '?';

  DropdownButton<String> getDropDownMenu() {
    List<DropdownMenuItem<String>> dropDownElements = [];
    for (int i = 0; i < currenciesList.length; i++) {
      var element = DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      );
      dropDownElements.add(element);
    }
    return DropdownButton<String>(
      value: curVal,
      items: dropDownElements,
      onChanged: (value) {
        print(value);
        setState(
          () {
            curVal = value;
            getVal('BTC');
            getVal('ETH');
            getVal('LTC');
          },
        );
      },
    );
  }

  CupertinoPicker iosDropDown() {
    List<Widget> dropDownElements = [];
    for (String currency in currenciesList) {
      var element = Text(currency);
      dropDownElements.add(element);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: dropDownElements,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void getVal(String crypto) async {
    CoinData _coinData = CoinData();
    try {
      var data = await _coinData.getData(crypto, curVal);
      dataInfo = data['rate'];
      updateUI(crypto);
    } catch (e) {
      print(e);
    }
  }

  void updateUI(String crypto) {
    setState(() {
      if (crypto == 'BTC') {
        btcVal = dataInfo.round().toString();
      } else if (crypto == 'ETH') {
        ethVal = dataInfo.round().toString();
      } else {
        ltcVal = dataInfo.round().toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: cryptoBlock(
              'BTC',
              btcVal,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
            child: cryptoBlock(
              'ETH',
              ethVal,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
            child: cryptoBlock(
              'LTC',
              ltcVal,
            ),
          ),
          Container(
            height: 100.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosDropDown() : getDropDownMenu(),
          ),
        ],
      ),
    );
  }

  Card cryptoBlock(String crypto, String val) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $crypto = $val $curVal',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
