import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:clinic/logic/auth/sup_auth_service.dart';

class ImageService {
  static final ImageService instance = ImageService._internal();
  factory ImageService() => instance;
  ImageService._internal();

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }

  Future<String?> uploadAndSaveImage(File imageFile) async {
    try {
      final userId = SupAuthService.instance.getCurrentUserId();
      final path = 'profile/$userId';

      await Supabase.instance.client.storage
          .from('images')
          .upload(
            path,
            imageFile,
            fileOptions: const FileOptions(upsert: true),
          );

      final imageUrl = Supabase.instance.client.storage
          .from('images')
          .getPublicUrl(path);

      return imageUrl;
    } catch (e) {
      log('Error uploading or saving image: $e');
      return null;
    }
  }
}
//await DoctorService.instance.updateUserData(imageUrl: imageUrl);