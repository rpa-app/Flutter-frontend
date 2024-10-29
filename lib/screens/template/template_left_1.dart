import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:video_player/video_player.dart';

class TemplateVideo extends StatefulWidget {
  final String videoUrl;
  final bool premiumStatus;
  final bool showCTA;
  final VoidCallback? onVideoAdded;

  TemplateVideo({
    Key? key,
    required this.videoUrl,
    required this.premiumStatus,
    required this.showCTA,
    this.onVideoAdded,
  }) : super(key: key);

  @override
  _TemplateVideoState createState() => _TemplateVideoState();
}

class _TemplateVideoState extends State<TemplateVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Center(child: CircularProgressIndicator()),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     setState(() {
              //       _controller.value.isPlaying
              //           ? _controller.pause()
              //           : _controller.play();
              //     });
              //   },
              //   child: Icon(
              //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              //   ),
              // ),
            ],
          ),
          // widget.showCTA ? returnCTA() : SizedBox()
        ],
      ),
    );
  }

  // Widget returnCTA(TemplatesViewModel viewModel) {
  //   ThemeData themeData = Theme.of(context);
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
  //     child: LayoutBuilder(
  //       builder: (context, constraints) {
  //         bool isWideScreen = constraints.maxWidth > 600;

  //         return Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 Expanded(
  //                   flex: 4,
  //                   child: PrimaryButton(
  //                     iconPath: 'Asset/Icons/Whatsapp-Icon.svg',
  //                     isEnabled: true,
  //                     isLoading: false,
  //                     onTap: () async {
  //                       viewModel.conditionalButtonClick(
  //                         controller: _controller,
  //                         context: context,
  //                         imageUrl: widget.imageUrl,
  //                         isTestUser: false,
  //                         premiumStatus: widget.premiumStatus,
  //                       );
  //                     },
  //                     height: 48,
  //                     color: Colors.green,
  //                     label: "| Share with Photo",
  //                   ),
  //                 ),
  //                 if (isWideScreen)
  //                   SizedBox(width: 8), // Adjust spacing between buttons
  //                 Expanded(
  //                   flex: 1,
  //                   child: ElevatedButton.icon(
  //                     onPressed: () async {
  //                       viewModel.conditionalButtonClick(
  //                         controller: _controller,
  //                         context: context,
  //                         imageUrl: widget.videoUrl,
  //                         premiumStatus: widget.premiumStatus,
  //                         isTestUser: false,
  //                       );
  //                     },
  //                     icon: Icon(
  //                       Icons.download,
  //                       color: Colors.white,
  //                       size: 28,
  //                     ), // Use the download icon
  //                     label: Text(""), // No label
  //                     style: ElevatedButton.styleFrom(primary: Colors.green),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 12),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 Expanded(
  //                   child: CustomSecondaryButton(
  //                     showIcon: false,
  //                     leadingIcon: 'Asset/Icons/Download-Icon.svg',
  //                     onPressed: () async {
  //                       if (widget.premiumStatus) {
  //                         await DownloadShareImage(controller: _controller)
  //                             .downloadPremiumScreenshot();
  //                       } else {
  //                         await DownloadShareImage()
  //                             .nonPremiumShare(imageUrl: widget.imageUrl);
  //                       }
  //                     },
  //                     buttonText: "Share without Photo",
  //                     buttonColor: Colors.black,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  // Future removeBackground(XFile? image) {
  //   ThemeData themeData = Theme.of(context);
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return StreamBuilder(
  //             stream: PhotoBackgroundRemoval().executeEverything(image),
  //             builder: (context, snapshot) {
  //               return AlertDialog(
  //                 backgroundColor: Colors.white,
  //                 title: Text(
  //                   'Removing background, please wait..',
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 content: SingleChildScrollView(
  //                   child: ListBody(
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(vertical: 16),
  //                         child: Container(width: 300, child: snapshot.data),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 actions: [
  //                   snapshot.connectionState == ConnectionState.done
  //                       ? PrimaryButton(
  //                           isEnabled: true,
  //                           isLoading: false,
  //                           onTap: () {
  //                             Navigator.pop(context);
  //                           },
  //                           label: 'Add Image',
  //                           color: themeData.colorScheme.primary,
  //                         )
  //                       : SizedBox(),
  //                 ],
  //               );
  //             });
  //       });
  // }
}
