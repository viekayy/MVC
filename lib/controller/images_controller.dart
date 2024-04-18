import 'dart:convert';
import 'package:get/get.dart';
import 'package:assignment/model/images_model.dart';
import 'package:http/http.dart' as http;
import 'package:assignment/view/full_screen_image.dart';

class ImageController extends GetxController {
  var images_model = Images().obs;
  var imageList = <Hits>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchImages();
  }

  fetchImages() async {
    final response = await http.get(Uri.parse(
        "https://pixabay.com/api/?key=43460937-afb85a94ff75e567da6c27dc5&q=black+magic&image_type=photo"));
    if (response.statusCode == 200) {
      // Parse the JSON string into a Map
      Map<String, dynamic> responseData = jsonDecode(response.body);
      // Assuming your ImagesModel class has a constructor that takes a Map<String, dynamic>
      images_model.value = Images.fromJson(responseData);
      if (images_model.value.hits != null) {
        for (var hit in images_model.value.hits!) {
          // print(hit.largeImageURL);
          imageList.add(hit); // Accessing the largeImageURL of each hit
        }
      }
    }
  }

  void navigateToFullScreen(String imageUrl) {
    Get.to(
      () => FullScreen(imageUrl: imageUrl),
      transition: Transition.downToUp, // Use custom fade in transition
      opaque: false,
    );
  }
}
