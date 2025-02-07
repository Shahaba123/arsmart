import 'package:cloudinary/cloudinary.dart';

Future<String?>  getClodinaryUrl(String image) async {

  final cloudinary = Cloudinary.signedConfig(
    cloudName: 'dewdlr275',
    apiKey: '893876956335369',
    apiSecret: 'dXqJSXnFwWTHBeSsfgNfaOcTOjg',
  );

   final response = await cloudinary.upload(
        file: image,
        resourceType: CloudinaryResourceType.image,
      );
  return response.secureUrl;
  
} 