import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'custom_exception .dart';

class SheetsListApi {
  Future<List> getSheetsList() async {
    List sheetsList = [];
    try {
      final url = 'http://rafiq.somee.com/api/GetSheetsName';

      final response = await http.get(url);
      print(response.body);
      final body = json.decode(response.body);
      // if (body["Message"].contains(
      //     "No HTTP resource was found that matches the request URI")) {
      //   throw BadRequestException('Try again later');
      // }
      if (body['status'] == null) throw BadRequestException('Try again later');
      sheetsList = body['data'];
      print(sheetsList);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return sheetsList;
    // var sheetsDoc = await FirebaseFirestore.instance.collection('sheets').get();
    // sheetsDoc.docs.forEach((e) {
    //   sheetsList.add(e.id);
    // });
  }
}
