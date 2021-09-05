import 'package:http/http.dart' as http;
import 'dart:convert';

const api_key = '5155D2D6-667C-4950-8538-37B66BC964F0';
const URL = 'https://rest.coinapi.io/v1/exchangerate';

class Networking {
  Networking({required this.currency});
  final currency;

  Future<dynamic> crypto() async {
    var url = Uri.parse('${URL}/BTC/${currency}?apikey=${api_key}');
    var Response = await http.get(url);
    var data = json.decode(Response.body);
    var lastprice = data['rate'];
    return lastprice;
  }
}