import "package:flutter/material.dart";

class InfoImageTile extends StatelessWidget {
  const InfoImageTile({
    super.key,
    // required this.index,
    this.image,
    this.extent,
    this.bottomSpace,
  });
  // final int index;
  final String? image;
  final double? extent;
  final double? bottomSpace;
  @override
  Widget build(BuildContext context) {
    final child = Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey.shade200,
      ),
      height: extent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image(fit: BoxFit.cover, image: AssetImage(image.toString())),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        child,
        Container(height: bottomSpace, color: Colors.grey),
      ],
    );
  }
}
