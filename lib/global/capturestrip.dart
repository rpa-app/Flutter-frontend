import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

Future<File> captureStripAsImage(GlobalKey key) async {
  RenderRepaintBoundary boundary =
      key.currentContext!.findRenderObject() as RenderRepaintBoundary;
  var image = await boundary.toImage();
  ByteData? byteData = await image.toByteData(format: ImageByteFormat.png)!;
  Uint8List? pngBytes = byteData?.buffer.asUint8List();

  final Directory dir = await getApplicationDocumentsDirectory();
  final String filePath = '${dir.path}/strip.png';
  File file = File(filePath);
  await file.writeAsBytes(pngBytes!);

  return file;
}
