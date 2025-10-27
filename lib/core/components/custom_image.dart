import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:decor/core/resources/assets_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


enum ImagesType { svg, png, network, asset, file, memory }

class CustomImage extends StatelessWidget {
  final ImagesType imageType;
  final String imagePath;
  final double? height;
  final double borderRadius;
  final double? width;
  final BoxFit boxFit;
  final Color? color;
  final bool applySvgColor;

  const CustomImage({
    required this.imageType,
    required this.imagePath,
    super.key,
    this.height,
    this.borderRadius = 5.0,
    this.width,
    this.boxFit = BoxFit.fill,
    this.color,
    this.applySvgColor = false,
  });

  bool _isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && uri.hasAbsolutePath && uri.hasScheme;
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    switch (imageType) {
      case ImagesType.svg:
        imageWidget = SvgPicture.asset(
          imagePath,
          height: height,
          width: width,
          fit: boxFit,
          colorFilter: applySvgColor
              ? ColorFilter.mode(color ?? Colors.red, BlendMode.srcIn)
              : null,
        );
      case ImagesType.png:
      case ImagesType.asset:
        imageWidget = Image.asset(
          imagePath,
          height: height,
          width: width,
          color: color,
          fit: boxFit,
          errorBuilder: (context, error, stackTrace) {
            return _errorImage();
          },
        );
      case ImagesType.file:
        imageWidget = Image.file(
          File(imagePath),
          height: height,
          width: width,
          color: color,
          fit: boxFit,
          errorBuilder: (context, error, stackTrace) {
            return _errorImage();
          },
        );
      case ImagesType.memory:
        imageWidget = Image.memory(
          base64Decode(imagePath.split('base64,').last),
          height: height,
          width: width,
          color: color,
          fit: boxFit,
          errorBuilder: (context, error, stackTrace) {
            return _errorImage();
          },
        );
      case ImagesType.network:
        if (!_isValidUrl(imagePath)) return _errorImage();
        imageWidget = kIsWeb
            ? Image.network(
                imagePath,
                height: height,
                width: width,
                color: color,
                fit: boxFit,
                errorBuilder: (context, error, stackTrace) {
                  return _errorImage();
                },
              )
            : CachedNetworkImage(
                imageUrl: imagePath,
                height: height,
                width: width,
                color: color,
                fit: boxFit,
                errorWidget: (context, error, stackTrace) {
                  return _errorImage();
                },
              );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageWidget,
    );
  }

  Widget _errorImage() {
    return ErrorImage(errorHeight: height, errorWidth: width, fit: boxFit);
  }
}

class ErrorImage extends StatelessWidget {
  final double? errorWidth;
  final double? errorHeight;
  final BoxFit? fit;

  const ErrorImage({super.key, this.errorWidth, this.errorHeight, this.fit});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsManager.logo,
      height: errorHeight ?? 92,
      width: errorWidth ?? 143,
      fit: fit ?? BoxFit.fitHeight,
    );
  }
}
