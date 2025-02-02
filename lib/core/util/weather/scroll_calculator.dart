import 'package:flutter/material.dart';

double calculateScrollProgress(ScrollController controller) {
  if (controller.hasClients && controller.position.hasContentDimensions) {
    return controller.position.pixels /
        (controller.position.maxScrollExtent == 0
            ? 1
            : controller.position.maxScrollExtent);
  }
  return 0.0;
}
