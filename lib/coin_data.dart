import 'package:http/http.dart' as http;
import 'constants.dart';
import 'dart:convert';

class CoinData {
  Future<dynamic> getData(String crypto, String currency) async {
    String btcUrl = '$apiUrlBase/$crypto/$currency';
    http.Response response =
        await http.get(btcUrl, headers: {'X-CoinAPI-Key': apiKey});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
