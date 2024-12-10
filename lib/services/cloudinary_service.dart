// cloudinary_service.dart
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';

class CloudinaryService {
  final CloudinaryPublic cloudinary =
      CloudinaryPublic('dpngif7y4', 'ElChinito', cache: false);
  final ImagePicker _picker = ImagePicker();

  Future<String?> uploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      try {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path, folder: 'products'),
        );
        return response.secureUrl;
      } catch (e) {
        print(e);
        return null;
      }
    }
    return null;
  }
}
