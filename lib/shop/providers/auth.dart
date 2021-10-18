import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token = '';
  DateTime _expiryDate = DateTime.now();
  String _userId = '';

  Future<void> signup(String email, String password) async {
    final url = Uri.https(
        'identitytoolkit.googleapis.com',
        '/v1/accounts:signUp',
        {'key': 'AIzaSyBzC5D7xlUXuNJRFYfbdcuMmcPieefDA1s'});
  
    final response = await http.post(url,
        body: json.encode({
          "email": email,
          "password": password,
          "returnSecureToken": true,
        }));

    print(json.decode(response.body));
  }
}
