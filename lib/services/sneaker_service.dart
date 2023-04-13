import 'dart:convert';
import 'dart:developer';

import 'package:crud_sneakers/config/api_config.dart';
import 'package:crud_sneakers/models/sneaker.dart';
import 'package:http/http.dart' as http;

abstract class SneakerService {
  SneakerService._();

  static Future<List<Sneaker>?> getSneakers() async {
    try {
      const url = "${ApiConfig.baseUrl}/${ApiConfig.sneakerEndpoint}";
      final response = await http.get(Uri.parse(url));
      // log(response.body);
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body) as Map;
        final status = responseJson['status'];
        if (status == true) {
          final List listDataJson = responseJson['data'];
          List<Sneaker> sneakers = [];
          for (final json in listDataJson) {
            sneakers.add(Sneaker.fromJson(json));
          }
          return sneakers;
        }
        return null;
      }
      return null;
    } catch (e) {
      log('$e');
      return null;
    }
  }

  static Future<void> createSneakers({
    required String name,
    required String brand,
    required String type,
  }) async {
    try {
      const url = "${ApiConfig.baseUrl}/${ApiConfig.sneakerEndpoint}";
      final Map<String, dynamic> body = {
        'nama': name,
        'brand': brand,
        'type': type
      };
      final response = await http.post(
        Uri.parse(url),
        body: body,
      );
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final status = responseJson['status'];
        if (status == true) {}
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> updateSneaker({
    required int id,
    required String name,
    required String brand,
    required String type,
  }) async {
    try {
      final url = "${ApiConfig.baseUrl}/${ApiConfig.sneakerEndpoint}/$id";
      final Map<String, dynamic> body = {
        'nama': name,
        'brand': brand,
        'type': type
      };
      final response = await http.put(
        Uri.parse(url),
        body: body,
      );
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final status = responseJson['status'];
        if (status == true) {}
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> deleteSneaker(int id) async {
    try {
      final url = "${ApiConfig.baseUrl}/${ApiConfig.sneakerEndpoint}/$id";
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final status = responseJson['status'];
        if (status == true) {}
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
