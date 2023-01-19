import 'package:http/http.dart' as http;
import 'dart:convert';

class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        //the page is found and  the connect is successed
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error $e");
    }
  }

  postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        //the page is found and  the connect is successed
        // var responsebody = jsonDecode(jsonEncode(response.body));
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error $e");
    }
  }

  postRequest2(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        //the page is found and  the connect is successed
        var responsebody = jsonDecode(jsonEncode(response.body));
        // var responsebody = jsonDecode(response.body);
        return jsonDecode(responsebody);
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
