import 'dart:io';
import 'package:cloudinary/cloudinary.dart';

Future<String?> uploadImageToCloudinary(String filePath) async {
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "893876956335369",
    apiSecret: "dXqJSXnFwWTHBeSsfgNfaOcTOjg",
    cloudName: "dewdlr275",
  );

  final response = await cloudinary.upload(
    file: filePath,
    resourceType: CloudinaryResourceType.image,
    folder: "flutter_uploads", // Optional: Cloudinary folder name
  );

  return response.secureUrl; // Returns the uploaded image URL
}