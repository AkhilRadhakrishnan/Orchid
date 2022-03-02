import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:orchid/util/shared_preferences_helper.dart';

class Network {
  //Implementing Singleton Class
  // static final Network _network = Network._internal();
  // factory Network() => _network;
  // Network._internal(); // Private Constructor

  var accessToken;

  _getToken() async {
    accessToken = await SharedPreferencesHelper.getAccessToken();
    return accessToken;
  }

  Map<String, String>? _setAuthHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $accessToken'
      };

  Map<String, String>? _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  getRequest({url}) async {
    var fullUrl = Uri.parse(url);
    return await http.get(fullUrl, headers: _setHeaders());
  }
  getAuthRequest({url}) async {
    var fullUrl = Uri.parse(url);
    // await _getToken();
    return await http.get(fullUrl, headers: _setAuthHeaders());
  }

  postRequest({url, data}) async {
    var fullUrl = Uri.parse(url);
    return await http.post(fullUrl,
        headers: _setHeaders(), body: jsonEncode(data));
  }

  postAuthRequest({url, data}) async {
    var fullUrl = Uri.parse(url);
    // await _getToken();
    return await http.post(fullUrl,
        headers: _setAuthHeaders(), body: jsonEncode(data));
  }
}
