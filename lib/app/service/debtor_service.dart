// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:akm/app/common/constant.dart';
import 'package:akm/app/common/style.dart';
import 'package:akm/app/models/debtor.dart';

class DebtorService {
  final httpClient = http.Client();

  // Create a debtor
  Future<Debtor> addDebtor(body) async {
    try {
      const apiUrl = '${baseUrl}debiturs';
      final response = await httpClient.post(
        Uri.parse(apiUrl),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      debugPrint('response: ${response.body}');

      if (response.statusCode == 201) {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          dialogBackgroundColor: primaryColor,
          titleTextStyle: GoogleFonts.poppins(
            color: secondaryColor,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
          descTextStyle: GoogleFonts.poppins(
            color: secondaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          title: 'Sukses',
          desc: 'Data berhasil ditambahkan',
          btnOkOnPress: () {
            Get.back();
          },
        ).show();
      }
      return Debtor.fromJson(json.decode(response.body));
    } catch (e) {
      debugPrint('error: $e');

      AwesomeDialog(
        context: Get.context!,
        dialogBackgroundColor: primaryColor,
        titleTextStyle: GoogleFonts.poppins(
          color: secondaryColor,
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
        descTextStyle: GoogleFonts.poppins(
          color: secondaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Error',
        desc: 'Terjadi kesalahan',
        btnOkOnPress: () {},
      ).show();
      throw Exception('Failed to create post');
    }
  }

  // Fetch debitur data from API
  Future<List<Debtor>> getDebtors() async {
    try {
      const apiUrl = '${baseUrl}debiturs';
      final response = await httpClient.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        debugPrint('response: ${response.body}');

        Iterable it = json.decode(response.body);
        List<Debtor> list = it.map((model) => Debtor.fromJson(model)).toList();
        return list;
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      debugPrint('error: $e');
      throw Exception('Failed to load post');
    }
  }

  // Fetch debtor by id from API
  Future<Debtor> getDebtorById(id) async {
    try {
      final apiUrl = '${baseUrl}debiturs/$id';
      final response = await httpClient.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        debugPrint('response: ${response.body}');

        return Debtor.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      debugPrint('error: $e');
      throw Exception('Failed to load post');
    }
  }

  // Delete a debtor
  Future<void> deleteDebtor(id) async {
    try {
      final apiUrl = '${baseUrl}debiturs/$id';
      final response = await httpClient.delete(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        AwesomeDialog(
          context: Get.context!,
          dialogBackgroundColor: primaryColor,
          titleTextStyle: GoogleFonts.poppins(
            color: secondaryColor,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
          descTextStyle: GoogleFonts.poppins(
            color: secondaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Sukses',
          desc: 'Data berhasil dihapus',
          btnOkOnPress: () {},
        ).show();
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      debugPrint('error: $e');
      throw Exception('Failed to load post');
    }
  }

  // Update a debtor
  Future<void> updateDebtor(id, body) async {
    try {
      final apiUrl = '${baseUrl}debiturs/$id';
      final response = await httpClient.put(
        Uri.parse(apiUrl),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
  

        AwesomeDialog(
          context: Get.context!,
          dialogBackgroundColor: primaryColor,
          titleTextStyle: GoogleFonts.poppins(
            color: secondaryColor,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
          descTextStyle: GoogleFonts.poppins(
            color: secondaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Sukses',
          desc: 'Data berhasil diubah',
          btnOkOnPress: () {},
        ).show();
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      debugPrint('error: $e');
      throw Exception('Failed to load post');
    }
  }
}