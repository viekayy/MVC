import 'dart:ui';

import 'package:assignment/controller/images_controller.dart';
import 'package:assignment/view/full_screen_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final ImageController controller = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 800, sigmaY: 800),
          child: FutureBuilder(
            future: Future.delayed(
                Duration(seconds: 1)), // Simulate loading for 1 second
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Obx(() {
                  return Column(
                    children: [
                      Container(
                        height: Get.height * 0.95,
                        width: Get.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              controller.imageList.isNotEmpty
                                  ? controller.imageList[9].largeImageURL!
                                  : '', // Set the background image to the URL of the first image in the list
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                ((MediaQuery.of(context).size.width) / 200)
                                    .round(),
                            childAspectRatio: 1,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                          ),
                          itemCount: controller.imageList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Get.to(FullScreen(
                                  imageUrl: controller
                                      .imageList[index].largeImageURL!)),
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                color: Colors.amberAccent,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        controller
                                            .imageList[index].largeImageURL!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            8), // Add spacing between image and text
                                    Text(
                                      'Likes: ${controller.imageList[index].likes}',
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                        height:
                                            4), // Add spacing between likes and comments
                                    Text(
                                      'Views: ${controller.imageList[index].views}',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        color: Colors.yellow,
                        width: Get.width,
                        child: Center(
                          child: Text(
                            "VSIMEIKLAEYYY",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
