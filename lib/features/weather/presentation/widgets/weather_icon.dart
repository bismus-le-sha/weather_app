import 'dart:ui';

import 'package:flutter/material.dart';

Widget getWeatherIcon(String path, double size) {
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      Positioned(
        top: 10,
        right: 10,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: ShaderMask(
            shaderCallback: (bounds) {
              return RadialGradient(
                colors: [Colors.black.withAlpha(125), Colors.transparent],
                center: Alignment.center,
                radius: 0.8,
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Image.asset(
              path,
              color: Colors.black,
              colorBlendMode: BlendMode.srcATop,
              height: size,
              width: size,
            ),
          ),
        ),
      ),
      Image.asset(
        path,
        height: size,
        width: size,
      ),
    ],
  );
}
