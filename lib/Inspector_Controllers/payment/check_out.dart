
import 'dart:convert';

import 'package:http/http.dart' as http;
class CheckOut {

  static const _tokenUrl= 'https://apitest.myfatoorah.com/';
  static const _paymentUrl='https://api.tap.company/v2/authorize';

  static const String _publicKey='ysmJ16OyFhr5--iXW0hFB1zmwYl392ydDVUtuQB9bD9ePyTC70O5pjfxI3ci-vLLlYaVklMRqNhdXUNmOAFSVfaG2Nx9YIeqZ2GEEWm5YKknN3Terc0BUQgLs8zXINBe57BwsRteeL4ZJy_AQFKLLJaH7OClCjx-CJ0sHXjOosEhQLvjOdJEbaSuDgF5gr4CwWEYjLES-EGZouKOVCarm0X-6vi0K_TLG1vvgLeWlenzmkVgOKlgxRoRACqdDusQm-UXIJbXkBZPnAtm3B3UK1BaG2zLDkA7PKdT9TRUTEeTWaXGoZOZtoechBRRe0JkoqUdXmLqYP39-3UjDDlWtH8lmt9ns0OZmA3v6vLw0bca3Gs0Ethv258vQhHVGuf5RsZOYPeL7c2xJdHUHpldnQAL-_X8rLAyHYDZFjvxnkAsTRJEEeRRR00cT1TlLswRHD6lRncmFicu3NhJyV1oCVvdVxOzVBpF9DQUYDWSgYxsJD6XMNrtp93pvOykginnnUZHH6wDG5vKXcl0AHSjFuJgZ9yMhlMqqDHl_NK8vbrVfKcwKmwe5v6ojMcXCL4UPr1Klx7TaaRVe1BNYyezEOu_iGrt8JUmkDVuE5PRmjIbIopnV5vWNvtGtXCHUWuq3MiWBRNbndsJjco7iy3rUH5MhmEkK1nPndbBxWcePALUuVwU';
  static const String _secretKey='sk_test_aWSxHM3pfCKJwXQ5487hzjbE';
  static const String _url_InitialPayment = _tokenUrl+'/v2/InitiatePayment';
  static const String _url_ExecutePayment = _tokenUrl+'/v2/ExecutePayment';

  static const Map<String,String> _tokenHeader = {
    'Accept': 'application/json',
    'Content-Type':'Application/json',
    'Authorization':'Bearer '+_publicKey
  };
  static const Map<String,String> _paymentHeader = {
    'Content-Type':'Application/json',
    'Authorization':_secretKey
  };

  Future<String> getToken ()async{
    Map<String,dynamic> body = {
      'body': { 'InvoiceAmount': 100, 'CurrencyIso': 'KWD' },
      'json': true
    };
     http.Response response = await http.post(Uri.parse(_url_InitialPayment),headers: _tokenHeader,body:jsonEncode(body) );
     print(response.body);
    return response.body;
  }

  //my Fatoorh Payment
  var token =
      'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL'; //token value to be placed here;
  var baseURL = 'https://apitest.myfatoorah.com/';

  Future initialPayment(int amount,int paymentMethodId ) async {
    var response = await http.post(
      Uri.parse(baseURL + 'v2/InitiatePayment'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
        'Content-Type': 'application/json'
      },
      body: jsonEncode({ 'InvoiceAmount': amount, 'CurrencyIso': 'KWD' }),
    );
    print(response.statusCode);
    print(response.body);

    _executePayment(paymentMethodId, amount);
    return response;
  }

  //
  void _executePayment(int paymentMethodId,int amount) async {
    var response = await http.post(
      Uri.parse(baseURL + 'v2/ExecutePayment'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
        'Content-Type': 'application/json'
      },
      body: jsonEncode( { 'PaymentMethodId': paymentMethodId,
        'CustomerName': 'Ahmed',
        'DisplayCurrencyIso': 'KWD',
        'MobileCountryCode': '+965',
        'CustomerMobile': '12345678',
        'CustomerEmail': 'xx@yy.com',
        'InvoiceValue': amount,
        'CallBackUrl': 'https://google.com',
        'ErrorUrl': 'https://google.com',
        'Language': 'en',
        'CustomerReference': 'ref 1',
        'CustomerCivilId': 12345678,
        'UserDefinedField': 'Custom field',
        'ExpireDate': '12/22',
        'CustomerAddress':
        { 'Block': '',
          'Street': '',
          'HouseBuildingNo': '',
          'Address': '',
          'AddressInstructions': '' },
        'InvoiceItems': [ { 'ItemName': 'Product 01', 'Quantity': 1, 'UnitPrice': amount } ] },),
    );
    print(response.statusCode);
    print(response.body);

  }

  Future<String> makePayment()async{
    Map<String,dynamic> body = {

        "PaymentType":"card",
        "Bypass3DS":false,
        "Card":{
          "Number":"5123450000000008",
          "ExpiryMonth":"05",
          "ExpiryYear":"21",
          "SecurityCode":"100",
          "HolderName":"KHAKED ALI"
        }
       };


    http.Response response = await http.post(Uri.parse('https://apitest.myfatoorah.com/v2/ExecutePayment'),headers: _tokenHeader,body:jsonEncode(body) );
    print(response.body);
    return response.body;
  }

}