import 'package:flutter/material.dart';
import 'package:progressive_image/progressive_image.dart';

/*
  Widget usado para imagens que NÃO vêm de requisições back-end, mas sim de imagens da pasta assets do projeto.
 */

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
          placeholder:
              const AssetImage('assets/images/blurred-placeholder.jpg'),
          thumbnail: imgPath != AssetImage('blurred-placeholder.jpg')
              ? AssetImage(imgPath!)
              : AssetImage('assets/images/blurred-placeholder.jpg'),
          image: imgPath != null
              ? AssetImage(imgPath!)
              : AssetImage('assets/images/blurred-placeholder.jpg'),
          height: heightValue ?? 100,
          width: widthValue ?? 100,
        ),
      );
    }

    return ProgressiveImage(
      placeholder: AssetImage('assets/images/blurred-placeholder.jpg'),
      thumbnail: imgPath != null
          ? AssetImage(imgPath!)
          : AssetImage('assets/images/blurred-placeholder.jpg'),
      image: imgPath != null
          ? AssetImage(imgPath!)
          : AssetImage('assets/images/blurred-placeholder.jpg'),
      height: heightValue ?? 100,
      width: widthValue ?? 100,
    );
  }
}
