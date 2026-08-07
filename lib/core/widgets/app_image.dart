import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class AppImage extends StatelessWidget {
  final String path;
  final double? height, width, bottomSpace;
  final BoxFit fit;
  final bool isCircle;
  final Color? color;

  const AppImage(
      this.path, {
        super.key,
        this.height,
        this.width,
        this.fit = BoxFit.scaleDown,
        this.color,
        this.bottomSpace,
        this.isCircle = false,
      });

  @override
  Widget build(BuildContext context) {
    final myFit = isCircle ? BoxFit.cover : fit;

    return Padding(
      padding: bottomSpace != null
          ? EdgeInsets.only(bottom: bottomSpace!)
          : EdgeInsets.zero,
      child: Builder(
        builder: (context) {
          Widget child;

          if(path.isEmpty) return SizedBox.shrink();

          if (path.contains("com.example.avon/cache")) {
            child = Image.file(
              File(path),
              height: height,
              width: width,
              fit: myFit,
              color: color,
              errorBuilder: (context, error, stackTrace) => _errorWidget(),
            );
          } else if (path.endsWith("svg")) {
            child = FutureBuilder(
              future: DefaultAssetBundle.of(context).load("assets/svg/$path"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(height: height ?? 24, width: width ?? 24);
                }
                if (snapshot.hasError) {
                  return _errorWidget();
                }
                return SvgPicture.asset(
                  "assets/svg/$path",
                  height: height,
                  width: width,
                  fit: myFit,
                  colorFilter: color != null
                      ? ColorFilter.mode(color!, BlendMode.srcIn)
                      : null,
                );
              },
            );
          } else if (path.startsWith("http")) {
            child = CachedNetworkImage(
              imageUrl: path,
              height: height,
              width: width,
              fit: myFit,
              color: color,
              placeholder: (context, url) => SizedBox(
                height: height ?? 24,
                width: width ?? 24,
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
              errorWidget: (context, url, error) => _errorWidget(),
            );
          } else if (path.endsWith("png") || path.endsWith("jpg")) {
            child = Image.asset(
              "assets/images/$path",
              height: height,
              width: width,
              fit: myFit,
              color: color,
              errorBuilder: (context, error, stackTrace) => _errorWidget(),
            );
          } else if (path.endsWith("json")) {
            child = Lottie.asset(
              "assets/lotties/$path",
              height: height,
              width: width,
              fit: myFit,
              errorBuilder: (context, error, stackTrace) => _errorWidget(),
            );
          } else {
            child = _errorWidget();
          }

          if(isCircle) return ClipOval(child: child,);

          return child;
        },
      ),
    );
  }

  Widget _errorWidget() {
    return Icon(
      Icons.error_outline_rounded,
      color: Colors.red,
      size: width ?? height ?? 24,
    );
  }
}