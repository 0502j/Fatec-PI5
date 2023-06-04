import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:progressive_image/progressive_image.dart';

class ProgressiveImageWidget extends StatelessWidget {
  final String? imgPath;
  final bool isOval;
  final heightValue;
  final widthValue;

  const ProgressiveImageWidget({
    super.key,
    required this.imgPath,
    this.isOval = false,
    this.heightValue,
    this.widthValue,
  });

  @override
  Widget build(BuildContext context) {
    if (isOval == true) {
      return ClipOval(
        child: ProgressiveImage(
          placeholder: const AssetImage('assets/images/loading.gif'),
          thumbnail: imgPath != AssetImage('assets/images/loading.gif')
              ? AssetImage(imgPath!)
              : AssetImage('assets/images/loading.gif'),
          image: imgPath != null
              ? AssetImage(imgPath!)
              : AssetImage('assets/images/loading.gif'),
          height: heightValue ?? 100,
          width: widthValue ?? 100,
        ),
      );
    }
    return ProgressiveImage(
      placeholder: AssetImage('assets/images/loading.gif'),
      thumbnail: imgPath != null
          ? AssetImage(imgPath!)
          : AssetImage('assets/images/loading.gif'),
      image: imgPath != null
          ? AssetImage(imgPath!)
          : AssetImage('assets/images/loading.gif'),
      height: heightValue ?? 100,
      width: widthValue ?? 100,
    );
  }
}
