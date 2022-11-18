import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movie/model/model.dart';


abstract class Service {

  static Future<ResponseListMovie?> readMovie() async {
    try {
      var response = await Dio().get("https://dlabs-test.irufano.com/api/movie?size=10&page=1");
      if(response.statusCode == 200) {
        return ResponseListMovie.fromJson(response.data);
      }
      return null;
    }catch(e){
      throw Exception(e.toString());
    }
  }

  static Future<CreateMovie?> createMovie(String title, String dec, File file) async {
    try {
      var formData = FormData.fromMap({
        'title': title,
        'description': dec,
        'poster': await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),

      });

      var response = await Dio().post("https://dlabs-test.irufano.com/api/movie", data: formData);
      if(response.statusCode == 201) {
        return CreateMovie.fromJson(response.data);
      }
      return null;
    }catch(e){
      throw Exception(e.toString());
    }
  }



}
