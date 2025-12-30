import "package:flutter/material.dart";

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:pos_app/utils/constants.dart';

class FullScreenImageScreen extends StatefulWidget {
  final List<dynamic> imagePaths;
  final int initialIndex;

  const FullScreenImageScreen({
    super.key,
    required this.imagePaths,
    required this.initialIndex,
  });

  @override
  _FullScreenImageScreenState createState() => _FullScreenImageScreenState();
}

class _FullScreenImageScreenState extends State<FullScreenImageScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            child: PhotoViewGallery.builder(
              itemCount: widget.imagePaths.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: AssetImage(widget.imagePaths[index]),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 2.0,
                  initialScale: PhotoViewComputedScale.contained,
                );
              },
              scrollPhysics: const BouncingScrollPhysics(),
              backgroundDecoration: BoxDecoration(color: black),
              pageController: _pageController,
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios, color: grey),
            ),
          ),
        ],
      ),
    );
  }
}
