import 'package:church_locator/models/http_exception.dart';
import 'package:church_locator/screens/add_church_screen.dart';
import 'package:church_locator/screens/login_screen.dart';
import 'package:church_locator/screens/profile_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static Future<List> searchChurch(
    String churchName,
    String churchLocation,
    String fullAddress,
  ) async {
    String url = 'http://churchlocates.com/apiTest/search.php';
    FormData formData = FormData.fromMap({
      "churchName": churchName,
      "churchLocation": churchLocation,
      "fullAddress": fullAddress
    });
    try {
      Response response = await Dio().post(url, data: formData);

      return response.data['message'];
    } catch (error) {
      throw error;
    }
  }

  static Future<List> getChurch(
    String churchName,
  ) async {
    String url = 'http://churchlocates.com/apiTest/getchurches.php';
    FormData formData = FormData.fromMap({
      "churchName": churchName,
    });
    try {
      Response response = await Dio().post(url, data: formData);

      return response.data['message'];
    } catch (error) {
      throw error;
    }
  }

  static Future<void> signUpUser(BuildContext context, String firstName,
      String lastName, String email, String password) async {
    final String url = 'http://churchlocates.com/apiTest/signup.php';

    FormData formData = FormData.fromMap({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password
    });
    try {
      Response response = await Dio().post(url, data: formData);

      if (response.data['status'] == false) {
        throw HttpException(response.data['message']);
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()));
      }
    } catch (e) {
      throw e;
    }
  }

  static Future getProfileImage(String userId) async {
    String url = 'http://churchlocates.com/apiTest/getprofileimage.php';
    var status = [];
    FormData formData = FormData.fromMap({
      'userId': userId,
    });

    Response response = await Dio().post(url, data: formData);
    print(response.data['message']);
    return response.data['message'];
  }

  static Future<void> loginUser(
      BuildContext context, String email, String password) async {
    String url = 'http://churchlocates.com/apiTest/auths.php';
    FormData formData =
        FormData.fromMap({"email": email, "password": password});
    try {
      Response response = await Dio().post(url, data: formData);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (response.data['status'] == false) {
        throw HttpException(response.data['message']);
      } else {
        sharedPreferences.setString("userId", response.data['userid']);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ProfileScreen()));
        print(response.data['userid']);
      }
    } catch (e) {
      throw e;
    }
  }
}
