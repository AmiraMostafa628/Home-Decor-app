import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ImageUploadService {
  static const String _apiKey = '92690bf12730e614604535b7f3430675';

  static Future<String> upload(File imageFile) async {
    final url = Uri.parse('https://api.imgbb.com/1/upload?key=$_apiKey');

    final base64Image = base64Encode(await imageFile.readAsBytes());

    final response = await http.post(
      url,
      body: {
        'image': base64Image,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['url'];
    } else {
      throw Exception('Failed to upload image');
    }
  }
}
