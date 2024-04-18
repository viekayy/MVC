import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreen extends StatelessWidget {
  final String imageUrl;

  const FullScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: Get.height,
        width: Get.width,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),floatingActionButton: FloatingActionButton(onPressed: Navigator.of(context).pop,child: Text("Back"),backgroundColor: Colors.grey,),
    );
  }
}
