import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class DownloadShareImage {
  final ScreenshotController? controller;

  const DownloadShareImage({Key? key, this.controller});

  Future<void> shareScreenshot() async {
    final imageFile = await controller?.capture(pixelRatio: 3);
    Uint8List? imageInUnit8List = imageFile; // store unit8List image here ;
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    File file = await File('$path/image.png').create();
    file.writeAsBytesSync(imageInUnit8List!);
    Share.shareXFiles(
      [XFile('$path/image.png')],
    );
  }

  Future<void> shareIDCard() async {
    final imageFile = await controller?.capture(pixelRatio: 3);
    Uint8List? imageInUnit8List = imageFile; // store unit8List image here ;
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    File file = await File('$path/image.png').create();
    file.writeAsBytesSync(imageInUnit8List!);
    Share.shareXFiles([XFile('$path/image.png')],
        text:
            'Get your BJP id Card and daily BJP Posters-Dwonload app now \n App Link: https://play.google.com/store/apps/details?id=com.bharat.posters');
  }

  Future<void> downloadPremiumScreenshot() async {
    final imageFile = await controller?.capture(pixelRatio: 3);
    Uint8List? imageInUnit8List = imageFile; // store unit8List image here ;
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    File file = await File('$path/image.png').create();
    file.writeAsBytesSync(imageInUnit8List!);
    OpenFilex.open(file.path);
  }

  void shareVideos(String videoPath) async {
    final file = File(videoPath);
    if (await file.exists()) {
      Share.shareFiles([videoPath], text: 'Check out this video!');
    } else {
      print("Error: Video file not found at $videoPath");
    }
  }

  Future<void> shareVideo(String videoUrl) async {
    final url = Uri.parse(videoUrl);
    final response = await http.get(url);
    final bytes = response.bodyBytes;
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    // File file = await File('$path/video.mp4').create();
    File file = await File('$path/video.mp4').create();
    file.writeAsBytesSync(bytes);
    await Share.shareXFiles(
      [XFile('$path/video.mp4')],
      text: 'Check out this video!',
    );
  }

  Future<void> nonPremiumShare({required String imageUrl}) async {
    String? urlImage = imageUrl;
    final url = Uri.parse(urlImage);
    final response = await http.get(url);
    final bytes = response.bodyBytes;
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    File file = await File('$path/image.jpg').create();
    file.writeAsBytesSync(bytes);
    await Share.shareXFiles([XFile('$path/image.jpg')],
        text:
            'अभी डाउनलोड करें: https://play.google.com/store/apps/details?id=com.govmatter.political_poster');
  }
}
