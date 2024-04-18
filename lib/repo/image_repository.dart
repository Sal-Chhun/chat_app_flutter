import 'dart:convert';
import 'dart:io';

import '../models/image_model.dart';
import 'package:http/http.dart' as http;

class ImageRepository{
  // Get Network Images from API
  Future <List<PixelfordImage>> getNetworkImages() async{
    try {
      var apiUrl = Uri.parse('https://jsonplaceholder.typicode.com/photos');

      final response =  await http.get(apiUrl);

      if(response.statusCode == 200){

        final List<dynamic> decodeList = jsonDecode(response.body);

        final List<PixelfordImage> _imageList = decodeList.map((listItem) {
          return PixelfordImage.fromJson(listItem as Map<String, dynamic>);
        }).toList();
        print(_imageList[0].url);

        return _imageList;
      }else{
        throw Exception('API not successful');
      }
    } on SocketException{
      throw Exception('No internet connection');
    } on HttpException{
      throw Exception('Couldn not retrive the image! Sorry!');
    } on FormatException{
      throw Exception('Bad response format!');
    }
    catch (e){
      print(e);
      throw Exception('Unknown error');
    }

  }

}