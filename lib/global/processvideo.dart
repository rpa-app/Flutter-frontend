import 'dart:io';
import 'dart:typed_data';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:http/http.dart' as http;
import 'package:screenshot/screenshot.dart';

Future<File> _downloadFile(String url, String fileName) async {
  final Directory dir = await getApplicationDocumentsDirectory();
  final File file = File('${dir.path}/$fileName');
  final http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    await file.writeAsBytes(response.bodyBytes);
    print('Downloaded $url to ${file.path}');
    return file;
  } else {
    throw Exception('Failed to download file from $url');
  }
}

Future<String> processVideoWithOverlay(
    String videoUrl,
    List<String> imageUrls,
    String uniqueIdentifier,
    ScreenshotController controller,
    ScreenshotController userController) async {
  final Directory dir = await getApplicationDocumentsDirectory();
  String outputPath = '${dir.path}/processed_video_$uniqueIdentifier.mp4';

  // Check if the processed video already exists
  if (await File(outputPath).exists()) {
    print('Processed video already exists at $outputPath');
    return outputPath;
  }

  // Download video locally
  File videoFile = await _downloadFile(videoUrl, 'video_$uniqueIdentifier.mp4');
  print('Downloaded video to ${videoFile.path}');

  // Download images locally
  List<File> imageFiles = [];
  for (int i = 0; i < imageUrls.length; i++) {
    File imageFile = await _downloadFile(imageUrls[i],
        'image_$uniqueIdentifier$i.${imageUrls[i].split('.').last}');
    imageFiles.add(imageFile);
    print('Downloaded image to ${imageFile.path}');
  }

  // Set the desired width and height for the overlay images
  int overlayWidth = 100;
  int overlayHeight = 100;

  // Build the FFmpeg command for overlaying images
  String filterGraph = '';
  String inputCmd = '-i ${videoFile.path} ';
  int horizontalOffset = 10; // Initial horizontal offset

  for (int i = 0; i < imageFiles.length; i++) {
    inputCmd += '-i ${imageFiles[i].path} ';
    // Position each image from the top-left corner, incrementing the horizontal offset
    String position = '$horizontalOffset:10';
    horizontalOffset +=
        overlayWidth + 10; // Increment horizontal offset for next image

    // Scale the overlay image
    filterGraph += '[${i + 1}:v] scale=$overlayWidth:$overlayHeight [ovr$i]; ';
    // Overlay the scaled image on the video
    if (i == 0) {
      filterGraph += '[0:v][ovr$i] overlay=$position [tmp$i]; ';
    } else {
      filterGraph += '[tmp${i - 1}][ovr$i] overlay=$position [tmp$i]; ';
    }
  }

  filterGraph =
      filterGraph.substring(0, filterGraph.length - 2); // Remove the last "; "

  String ffmpegCommand =
      '$inputCmd -filter_complex "$filterGraph" -map "[tmp${imageFiles.length - 1}]" -c:a copy $outputPath';

  print("FFmpeg Command: $ffmpegCommand");

  await FFmpegKit.execute(ffmpegCommand).then((session) async {
    final returnCode = await session.getReturnCode();
    final output = await session.getOutput();
    final failStackTrace = await session.getFailStackTrace();

    if (ReturnCode.isSuccess(returnCode)) {
      print("FFmpeg process succeeded for video $uniqueIdentifier");
    } else {
      print("FFmpeg process failed with return code $returnCode");
      print("FFmpeg output: $output");
      print("FFmpeg error: $failStackTrace");
    }
  });

  // Verify if the output file exists
  bool fileExists = await File(outputPath).exists();
  if (!fileExists) {
    print("Error: Processed video file not found at $outputPath");
    return outputPath;
  }

  //capture image and download
  final imageFile = await controller?.capture(pixelRatio: 3);
  Uint8List? imageInUnit8List = imageFile; // store unit8List image here ;
  final tempDir = await getTemporaryDirectory();
  final path = tempDir.path;
  File stripCapture = await File('$path/image.png').create();
  stripCapture.writeAsBytesSync(imageInUnit8List!);

  int BottomoverlayWidth = 1200;
  int BottomoverlayHeight = 200;
  // Share.shareXFiles(
  //   [XFile('$path/image.png')],
  // );
  // Add the last image at the bottom
  String finalOutputPath =
      '${dir.path}/final_processed_video_$uniqueIdentifier.mp4';
  if (imageFiles.isNotEmpty) {
    String bottomOverlayCmd =
        '-i $outputPath -i ${stripCapture.path} -filter_complex "[1:v] scale=$BottomoverlayWidth:$BottomoverlayHeight [ovr]; [0:v][ovr] overlay=(main_w-overlay_w)/2:main_h-overlay_h-10" -c:a copy $finalOutputPath';
    // String bottomOverlayCmd =
    //     '-i $outputPath -i ${stripCapture.path} -filter_complex "[1:v] scale=main_w:-1 [ovr]; [0:v][ovr] overlay=0:main_h-overlay_h-10" -c:a copy $finalOutputPath';

    print("Bottom Overlay FFmpeg Command: $bottomOverlayCmd");

    await FFmpegKit.execute(bottomOverlayCmd).then((session) async {
      final returnCode = await session.getReturnCode();
      final output = await session.getOutput();
      final failStackTrace = await session.getFailStackTrace();

      if (ReturnCode.isSuccess(returnCode)) {
        print(
            "FFmpeg process succeeded for adding bottom overlay image $uniqueIdentifier");
      } else {
        print("FFmpeg process failed with return code $returnCode");
        print("FFmpeg output: $output");
        print("FFmpeg error: $failStackTrace");
      }
    });

    String userOutputPath =
        '${dir.path}/user_processed_video_$uniqueIdentifier.mp4';
    final userimageFile = await userController?.capture(pixelRatio: 3);
    Uint8List? userimageInUnit8List =
        userimageFile; // store unit8List image here ;
    final usertempDir = await getTemporaryDirectory();
    final userpath = usertempDir.path;
    File userCapture = await File('$userpath/image.png').create();
    userCapture.writeAsBytesSync(userimageInUnit8List!);
    int userBottomoverlayWidth = 400;
    int userBottomoverlayHeight = 500;
    if (imageFiles.isNotEmpty) {
      // String bottomOverlayCmd =
      //     '-i $finalOutputPath -i ${userCapture.path} -filter_complex "[1:v] scale=$userBottomoverlayWidth:$userBottomoverlayHeight [ovr]; [0:v][ovr] overlay=(main_w-overlay_w)/2:main_h-overlay_h-10" -c:a copy $userOutputPath';
      String bottomOverlayCmd =
          '-i $finalOutputPath -i ${userCapture.path} -filter_complex "[1:v] scale=$userBottomoverlayWidth:$userBottomoverlayHeight [ovr]; [0:v][ovr] overlay=main_w-overlay_w-10:main_h-overlay_h-10" -c:a copy $userOutputPath';

      print("Bottom Overlay FFmpeg Command: $bottomOverlayCmd");

      await FFmpegKit.execute(bottomOverlayCmd).then((session) async {
        final returnCode = await session.getReturnCode();
        final output = await session.getOutput();
        final failStackTrace = await session.getFailStackTrace();

        if (ReturnCode.isSuccess(returnCode)) {
          print(
              "FFmpeg process succeeded for adding bottom overlay image $uniqueIdentifier");
        } else {
          print("FFmpeg process failed with return code $returnCode");
          print("FFmpeg output: $output");
          print("FFmpeg error: $failStackTrace");
        }
      });
      return userOutputPath;
    }
    return finalOutputPath;
  }
  // Verify if the output file exists
  // bool stripfileExists = await File(finalOutputPath).exists();
  // if (!stripfileExists) {
  //   print("Error: Processed video file not found at $outputPath");
  //   return outputPath;
  // }

  // //capture image and download
  // final userimageFile = await userController?.capture(pixelRatio: 3);
  // Uint8List? userimageInUnit8List =
  //     userimageFile; // store unit8List image here ;
  // final usertempDir = await getTemporaryDirectory();
  // final userpath = usertempDir.path;
  // File userCapture = await File('$userpath/image.png').create();
  // userCapture.writeAsBytesSync(userimageInUnit8List!);

  // int userBottomoverlayWidth = 200;
  // int userBottomoverlayHeight = 200;
  // // Share.shareXFiles(
  // //   [XFile('$path/image.png')],
  // // );
  // // Add the last image at the bottom
  // if (imageFiles.isNotEmpty) {
  //   print("Reached here 11");
  //   String finalOutputPath =
  //       '${dir.path}/final_processed_video_1_$uniqueIdentifier.mp4';

  //   String bottomOverlayCmd =
  //       '-i $outputPath -i ${stripCapture.path} -filter_complex "[1:v] scale=$userBottomoverlayWidth:$userBottomoverlayHeight [ovr]; [0:v][ovr] overlay=(main_w-overlay_w)/2:main_h-overlay_h-10" -c:a copy $finalOutputPath';
  //   // String bottomOverlayCmd =
  //   //     '-i $outputPath -i ${stripCapture.path} -filter_complex "[1:v] scale=main_w:-1 [ovr]; [0:v][ovr] overlay=0:main_h-overlay_h-10" -c:a copy $finalOutputPath';

  //   print("Bottom Overlay FFmpeg Command: $bottomOverlayCmd");

  //   await FFmpegKit.execute(bottomOverlayCmd).then((session) async {
  //     final returnCode = await session.getReturnCode();
  //     final output = await session.getOutput();
  //     final failStackTrace = await session.getFailStackTrace();

  //     if (ReturnCode.isSuccess(returnCode)) {
  //       print(
  //           "FFmpeg process succeeded for adding bottom overlay image $uniqueIdentifier");
  //     } else {
  //       print("FFmpeg process failed with return code $returnCode");
  //       print("FFmpeg output: $output");
  //       print("FFmpeg error: $failStackTrace");
  //     }
  //   });

  //   return finalOutputPath;
  // }

  return outputPath;
}
