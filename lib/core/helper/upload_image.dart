import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

Future<String?> uploadImageToCloudinary(File imageFile) async {
  String cloudName = "dup0vzih4";
  String presetName = "se7ety";
  Uri uri = Uri.parse(
    'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
  );

  var request = http.MultipartRequest('post', uri);

  request.fields['upload_preset'] = presetName;
  request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

  try {
    // 5. Send the request
    final response = await request.send();

    if (response.statusCode == 200) {
      // 6. Read and decode the response
      final responseBody = await response.stream.bytesToString();
      final responseData = json.decode(responseBody);

      // 7. Return the secure URL
      log('responseData: $responseData');
      return responseData['secure_url'];
    } else {
      print('Failed to upload image. Status code: ${response.statusCode}');
      final errorBody = await response.stream.bytesToString();
      print('Error response: $errorBody');
      return null;
    }
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}
//if using Dio
// Future<String?> uploadImage(File imageFile) async {
//   String cloudName = "dup0vzih4";
//   String presetName = "se7ety";
//   final formData = FormData.fromMap({
//     'upload_preset': presetName,
//     "file": await MultipartFile.fromFile(imageFile.path),
//   });
//   var response = await Dio().post(
//     "https://api.cloudinary.com/v1_1/$cloudName/image/upload",

//     data: formData,
//     options: Options(contentType: 'multipart/form-data'),
//   );
//   if (response.statusCode == 200) {
//     return response.data['secure_url'];
//   }
// }
