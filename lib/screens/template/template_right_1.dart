import 'dart:io';
import 'package:bharatposters0/screens/edit-profile-mvvm/edit_profile_view.dart';
import 'package:bharatposters0/global/CustomSecondaryButton.dart';
import 'package:bharatposters0/global/custom_toast.dart';
import 'package:bharatposters0/global/customloader.dart';
import 'package:bharatposters0/global/primarybutton.dart';
import 'package:bharatposters0/services/download_share_image.dart';
import 'package:bharatposters0/services/photo_background_removal.dart';
import 'package:bharatposters0/screens/template/templates_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

class Template_right_1 extends StatefulWidget {
  final String imageUrl;
  final bool premiumStatus;
  final bool isPoster;
  final bool showCTA;
  final VoidCallback? onImageAdded;
  final VoidCallback? onLeaderImageAdded;

  const Template_right_1({
    Key? key,
    required this.imageUrl,
    required this.isPoster,
    required this.premiumStatus,
    required this.showCTA,
    this.onLeaderImageAdded,
    this.onImageAdded,
  }) : super(key: key);

  @override
  State<Template_right_1> createState() => _Template_right_1State();
}

class _Template_right_1State extends State<Template_right_1> {
  final ScreenshotController _controller = ScreenshotController();
  final ScreenshotController _Stripcontroller = ScreenshotController();
  final ScreenshotController _userscreenshotController = ScreenshotController();
  final ImagePicker _picker = ImagePicker();
  final GlobalKey _stripKey = GlobalKey(); // Add GlobalKey for the strip
  bool _isLoading = false;
  List<File> _uploadedLogos = [];
  TemplatesViewModel viewm = TemplatesViewModel();

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  bool _isLoadingShare = false;

  @override
  void initState() {
    super.initState();
    _loadUploadedLogos();
    _getImageData();
  }

  // var image = [];
  // _getImageData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? selectedParty = prefs.getString('selectedParty');
  //   String? selectedCategory = prefs.getString('CategorySelected');
  //   print("Selected category for state: $selectedCategory");
  //   print("Selected party: $selectedParty");

  //   //   // Assuming viewm is an instance of your ViewModel
  //   List<String> image = await viewm.getSelectedStateInfo2(
  //       selectedCategory ?? "", selectedParty ?? "");
  //   print("Images received: $image");

  //   int check = prefs.getInt('count') ?? 0;
  //   String checkState = prefs.getString("checkstate") ?? '';
  //   print("Check count: $check, Check state: $checkState");

  //   if (check == 0 || selectedParty != checkState) {
  //     await prefs.setString('checkstate', selectedParty ?? "");
  //     print("Updated check state: ${prefs.getString('checkstate')}");
  //     await prefs.setInt('count', 1);
  //     print("Updated count: ${prefs.getInt('count')}");

  //     List<String> stringList =
  //         image.map((element) => element.toString()).toList();
  //     await prefs.setStringList('my_string_list', stringList);
  //     print("Stored string list: ${prefs.getStringList('my_string_list')}");
  //   }
  // }
  List<String> imageList = [];

  Future<void> _getImageData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? selectedParty = prefs.getString('selectedParty');
    final String? selectedCategory = prefs.getString('CategorySelected');
    print("Selected category for state: $selectedCategory");
    print("Selected party: $selectedParty");

    // Assuming viewm is an instance of your ViewModel
    List<String> images = await viewm.getSelectedStateInfo2(
        selectedCategory ?? "", selectedParty ?? "");
    print("Images received: $images");

    int check = prefs.getInt('count') ?? 0;
    String checkState = prefs.getString("checkstate") ?? '';
    print("Check count: $check, Check state: $checkState");

    if (check == 0 || selectedParty != checkState) {
      await prefs.setString('checkstate', selectedParty ?? "");
      print("Updated check state: ${prefs.getString('checkstate')}");
      await prefs.setInt('count', 1);
      print("Updated count: ${prefs.getInt('count')}");

      await prefs.setStringList('my_string_list', images);
      print("Stored string list: ${prefs.getStringList('my_string_list')}");
    }

    // Update state with the fetched images
    setState(() {
      imageList = images;
    });
  }

  // _getImageData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String? selectedParty = prefs.getString('selectedParty');
  //   String? selectedCategory = prefs.getString('CategorySelected');
  //   print("Selected category for state: $selectedCategory");

  //   // Assuming viewm is an instance of your ViewModel
  //   List<String> image = await viewm.getSelectedStateInfo2(
  //       selectedCategory ?? "", selectedParty ?? "");
  //   print("Images received: $image");

  //   int check = prefs.getInt('count') ?? 0;
  //   String checkState = prefs.getString("checkstate") ?? '';

  //   if (check == 0 || selectedParty != checkState) {
  //     await prefs.setString('checkstate', selectedParty ?? "");
  //     print("Check, $check"); // This will print 0
  //     await prefs.setInt('count', 1);

  //     List<String> stringList =
  //         image.map((element) => element.toString()).toList();
  //     await prefs.setStringList('my_string_list', stringList);
  //     print("stringimage1234:$stringList");
  //   }
  // }

  // _getImageData() async {
  //   var data = await viewm.getSelectedStateInfo1();
  //   image = data['data'];
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int check = prefs.getInt('count') ?? 0;
  //   String checkstate = prefs.getString("checkstate") ?? '';

  //   if (check == 0 || data['stateName'] != checkstate) {
  //     await prefs.setString('checkstate', data['stateName']);
  //     print(check); // This will print 0
  //     await prefs.setInt('count', 1);

  //     print(prefs.getInt('count'));

  //     List<String> stringList =
  //         image.map((element) => element.toString()).toList();

  //     await prefs.setStringList('my_string_list', stringList);
  //   }
  // }

  Future<void> _loadUploadedLogos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? logoPaths = prefs.getStringList('uploadedLogos');
    if (logoPaths != null) {
      setState(() {
        _uploadedLogos = logoPaths.map((path) => File(path)).toList();
      });
    }
  }

  Future<void> _addLogo() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _uploadedLogos.add(File(pickedFile.path));
      });
      viewm.addImage(pickedFile.path);
      await _saveUploadedLogos();
    }
  }

  Future<void> _saveUploadedLogos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> logoPaths = _uploadedLogos.map((file) => file.path).toList();
    await prefs.setStringList('uploadedLogos', logoPaths);
  }

  void _rebuildUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ViewModelBuilder<TemplatesViewModel>.reactive(
            viewModelBuilder: () => TemplatesViewModel(),
            onViewModelReady: (viewModel) async {
              await viewModel.initialize();
            },
            builder: (context, viewModel, child) => RefreshIndicator(
                onRefresh: () => viewModel.getImageList(),
                child: politicalTemplate_id_left1(viewModel, _rebuildUI, context))),
        if (_isLoading)
          CustomLoader(
            message: 'Processing Video..',
          ),
      ],
    );
  }

  bool isValidMediaUrl(bool isPoster, String url) {
    if (isPoster) {
      return url.endsWith('.jpg') ||
          url.endsWith('.jpeg') ||
          url.endsWith('.png') ||
          url.endsWith('.gif') ||
          url.endsWith('.bmp') ||
          url.endsWith('.webp') ||
          url.contains('images');
    } else {
      return url.endsWith('.mp4') ||
          url.endsWith('.avi') ||
          url.endsWith('.mov') ||
          url.endsWith('.wmv') ||
          url.endsWith('.flv') ||
          url.endsWith('.mkv') ||
          url.contains('video');
    }
  }

  Widget politicalTemplate_id_left1(
      TemplatesViewModel viewModel, VoidCallback onloaded, BuildContext context) {
    return !isValidMediaUrl(widget.isPoster, widget.imageUrl)
        ? Container()
        : Card(
          color: Colors.green.shade100, // Mint green background color
          elevation: 8, // Set elevation for the card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          margin: EdgeInsets.all(8), // Optional margin for spacing
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Add padding within the card
            child: Column(
              children: [
                if (_isLoadingShare) LinearProgressIndicator(),
                Screenshot(
                  controller: _controller,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  child: FadeInImage.memoryNetwork(
                                      image: widget.imageUrl,
                                      placeholder: kTransparentImage)),
                              // child: widget.isPoster
                              //     ? FadeInImage.memoryNetwork(
                              //         image: widget.imageUrl,
                              //         placeholder: kTransparentImage)
                              //     : TemplateVideo(
                              //         videoUrl: widget.imageUrl,
                              //         premiumStatus: false,
                              //         showCTA: false)),
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: FutureBuilder<List<dynamic>>(
                                  future: viewModel.getImageList(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text('Error: ${snapshot.error}'));
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return Center(child: Text(''));
                                    } else {
                                      List<dynamic> imageData = snapshot.data!;
                                      return Container(
                                        height: 100,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                          itemCount: imageData.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              height: imageData.length < 6
                                                  ? 60
                                                  : 35,
                                              width: imageData.length < 6
                                                  ? 50.0
                                                  : 35,
                                              margin: EdgeInsets.only(
                                                  bottom: 40, left: 5, top: 5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.green),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                image: DecorationImage(
                                                  image: imageData[index]
                                                          .startsWith('http')
                                                      ? NetworkImage(
                                                          imageData[index])
                                                      : FileImage(File(
                                                              imageData[index]))
                                                          as ImageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          Screenshot(
                            controller: _Stripcontroller,
                            child: RepaintBoundary(
                              key: _stripKey,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    left: 16,
                                    right:
                                        MediaQuery.of(context).size.width / 2.2,
                                    top: 12,
                                    bottom: 8),
                                color: Color.fromARGB(255, 103, 86, 60),
                                // color: viewModel.containerColor,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      viewModel.userDetails[0],
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      maxFontSize: 24,
                                      minFontSize: 18,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            fontFamily: 'Arya',
                                            color: Colors.white,
                                            height: 1.2,
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    AutoSizeText(
                                      viewModel.userDetails[1],
                                      maxFontSize: 18,
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(
                                              color: Colors.white,
                                              fontFamily: 'Mukta',
                                              height: 1.4),
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: Screenshot(
                            controller: _userscreenshotController,
                            child: GestureDetector(
                              onTap: () async {
                                var changedImage =
                                    await viewModel.userImageChange(context);
                                if (changedImage != null) {
                                  await removeBackground(changedImage, false);
                                  widget.onImageAdded?.call();
                                }
                              },
                              child: FutureBuilder(
                                  future: viewModel.leaderImage(),
                                  builder: (context, snapshot) {
                                    return Container(
                                      alignment: Alignment.bottomRight,
                                      height: 180,
                                      width: 180,
                                      child: snapshot.data,
                                    );
                                  }),
                            ),
                          )),
                    ],
                  ),
                ),
                widget.showCTA ? returnCTA(viewModel, _rebuildUI) : SizedBox(),
              ],
            ),
          ));
  }

  Widget returnUploadPhoto(
      TemplatesViewModel viewModel, VoidCallback onloaded) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomSecondaryButton(
          showIcon: false,
          leadingIcon: 'Asset/Icons/Download-Icon.svg',
          // bgcolor: Colors.orange,
          onPressed: () async {
            _showUpEditPoster(context, viewModel, onloaded);
          },
          buttonText: "Edit Poster",
          buttonColor: Colors.black,
        ));
  }

  Future<void> _showUpEditPoster(BuildContext context,
      TemplatesViewModel viewModel, VoidCallback onloaded) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.grey.shade400,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    _showUploadLogoDialog(
                        context, imageList, viewModel, onloaded);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withAlpha(120),
                    ),
                    child: Text(
                      'Add leaders photo',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Mukta'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileView(
                                onDetailsSaved: () {
                                  setState(() {});
                                },
                              )),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withAlpha(120),
                    ),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Mukta'),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> _showUploadLogoDialog(BuildContext context, var data,
      TemplatesViewModel viewModel, VoidCallback onloaded) async {
    ThemeData themeData = Theme.of(context);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var imageData = await prefs.getStringList('my_string_list');
    print("imagedata,$imageData");
    var isselect = [];
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          height: 350,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Photo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        await _addLogo();
                        showToast(context, "Photo has been added !");
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
                SizedBox(height: 16.0),
                data == null
                    ? SizedBox()
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.29,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 2,
                          ),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            String imagePath = data[index];
                            print("imagepath234,$imagePath");
                            print("imagepath234567,$data");
                            bool isSelected = imageData!.contains(imagePath);
                            return GestureDetector(
                                onTap: () async {
                                  if (isSelected) {
                                    viewModel.removeImage(imagePath);
                                    widget.onLeaderImageAdded?.call();
                                    onloaded();
                                    showToast(
                                        context, "Photo has been removed !");
                                    Navigator.pop(context);
                                  } else {
                                    viewModel.addImage(imagePath);
                                    widget.onLeaderImageAdded?.call();
                                    onloaded();
                                    showToast(
                                        context, "Photo has been added !");
                                    Navigator.pop(context);
                                  }
                                  widget.onLeaderImageAdded?.call();
                                },
                                child: Container(
                                    margin: EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                      border: isSelected
                                          ? Border.all(
                                              color: Colors.green, width: 3.0)
                                          : null,
                                    ),
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          data[index],
                                          height: 100,
                                          width: 100,
                                        ),
                                        isSelected
                                            ? Container(
                                                padding: EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    color: Colors.green),
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                ))
                                            : SizedBox()
                                      ],
                                    )));
                          },
                        ),
                      ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.29,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: _uploadedLogos.length,
                    itemBuilder: (BuildContext context, int index) {
                      File imagePath = _uploadedLogos[index];
                      bool isSelected = imageData!.contains(imagePath.path);

                      return GestureDetector(
                        onTap: () async {
                          if (isSelected) {
                            viewModel.removeImage(imagePath);
                            widget.onLeaderImageAdded?.call();
                            onloaded();
                            showToast(context, "Photo has been removed !");
                            Navigator.pop(context);
                          } else {
                            viewModel.addImage(imagePath);
                            widget.onLeaderImageAdded?.call();
                            onloaded();
                            showToast(context, "Photo has been added !");
                            Navigator.pop(context);
                          }

                          widget.onLeaderImageAdded?.call();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: isSelected
                                ? Border.all(color: Colors.green, width: 3.0)
                                : null,
                          ),
                          child: Stack(
                            children: [
                              Image.file(
                                _uploadedLogos[index],
                                fit: BoxFit.cover,
                              ),
                              isSelected
                                  ? Container(
                                      padding: EdgeInsets.all(3),
                                      decoration:
                                          BoxDecoration(color: Colors.green),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ))
                                  : SizedBox()
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget returnCTA(TemplatesViewModel viewModel, VoidCallback onloaded) {
    ThemeData themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: PrimaryButton(
                      iconPath: 'Asset/Icons/Whatsapp-Icon.svg',
                      isEnabled: true,
                      isLoading: false,
                      fontSize: 16,
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await viewModel.conditionalButtonClick1(
                          controller:
                              widget.isPoster ? _controller : _Stripcontroller,
                          context: context,
                          imageUrl: widget.imageUrl,
                          isTestUser: false,
                          // premiumStatus: widget.premiumStatus,
                          premiumStatus: true,
                          isPoster: widget.isPoster,
                          setLoading: setLoading,
                          userController: _userscreenshotController,
                          // stripKey: _stripKey, // Pass the GlobalKey
                        );
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      height: 48,
                      color: Colors.green,
                      label: "| Share with Photo",
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  // if (isWideScreen) SizedBox(width: 4),
                  // Expanded(
                  //   flex: 1,
                  //   child: PrimaryButton(
                  //     iconPath: 'Asset/Icons/-Icon.svg',
                  //     isEnabled: true,
                  //     isLoading: false,
                  //     fontSize: 16,
                  //     onTap: () async {
                  //       setState(() {
                  //         _isLoading = true;
                  //       });
                  //       await viewModel.conditionalButtonClick1(
                  //         controller:
                  //             widget.isPoster ? _controller : _Stripcontroller,
                  //         context: context,
                  //         imageUrl: widget.imageUrl,
                  //         isTestUser: false,
                  //         premiumStatus: widget.premiumStatus,
                  //         isPoster: widget.isPoster,
                  //         setLoading: setLoading,
                  //         userController: _userscreenshotController,
                  //         // stripKey: _stripKey, // Pass the GlobalKey
                  //       );
                  //       setState(() {
                  //         _isLoading = false;
                  //       });
                  //     },
                  //     height: 48,
                  //     color: Colors.green,
                  //     label: "| Download",
                  //   ),
                  //   // child: ElevatedButton.icon(
                  //   //   onPressed: () async {
                  //   //     setState(() {
                  //   //       _isLoading = true;
                  //   //     });
                  //   //     await viewModel.conditionalButtonClick1(
                  //   //       controller:
                  //   //           widget.isPoster ? _controller : _Stripcontroller,
                  //   //       context: context,
                  //   //       imageUrl: widget.imageUrl,
                  //   //       premiumStatus: widget.premiumStatus,
                  //   //       isTestUser: false,
                  //   //       isPoster: widget.isPoster,
                  //   //       setLoading: setLoading,
                  //   //       userController: _userscreenshotController,
                  //   //       // stripKey: _stripKey, // Pass the GlobalKey
                  //   //     );
                  //   //     setState(() {
                  //   //       _isLoading = false;
                  //   //     });
                  //   //   },
                  //   //   icon: Icon(
                  //   //     Icons.download,
                  //   //     color: Colors.white,
                  //   //     size: 28,
                  //   //   ),
                  //   //   label: Text("Download"),
                  //   //   style: ElevatedButton.styleFrom(primary: Colors.),
                  //   // ),
                  // ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: CustomSecondaryButton(
                      showIcon: false,
                      leadingIcon: 'Asset/Icons/Download-Icon.svg',
                      onPressed: () async {
                        setState(() {
                          _isLoadingShare = true;
                        });
                        try {
                          if (widget.premiumStatus) {
                            await DownloadShareImage(controller: _controller)
                                .downloadPremiumScreenshot();
                          } else {
                            await DownloadShareImage()
                                .nonPremiumShare(imageUrl: widget.imageUrl);
                          }
                         } finally {
                            setState(() {
                              _isLoadingShare = false;
                            });
                         }
                      },
                      buttonText: "Share without Photo",
                      buttonColor: Colors.black,
                    ),
                  ),
                  Expanded(
                      flex: 3, child: returnUploadPhoto(viewModel, onloaded))
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Future removeBackground(XFile? image, bool? leader) {
    ThemeData themeData = Theme.of(context);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StreamBuilder(
              stream: PhotoBackgroundRemoval().executeEverything(image),
              builder: (context, snapshot) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Column(
                  children: [
                    Text(
                      'Processing Image',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'We’re removing the background. This may take a few moments.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Container(width: 300, child: snapshot.data),
                        ),
                         if (snapshot.connectionState == ConnectionState.waiting) 
                    LinearProgressIndicator(),
                      ],
                    ),
                  ),
                  actions: [
                    snapshot.connectionState == ConnectionState.done
                        ? PrimaryButton(
                            isEnabled: true,
                            isLoading: false,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            label: 'Add Image',
                            color: themeData.colorScheme.primary,
                          )
                        : SizedBox(),
                  ],
                );
              });
        });
  }

  // Future<void> conditionalButtonClick1({
  //   required ScreenshotController controller,
  //   required BuildContext context,
  //   required premiumStatus,
  //   required bool isPoster,
  //   required String imageUrl,
  //   required bool isTestUser,
  //   required Function(bool) setLoading,
  //   required GlobalKey stripKey, // Receive the GlobalKey
  // }) async {
  //   setLoading(true); // Show loader
  //   int? selectedID = await SharedPreferences.getInstance()
  //       .then((prefs) => prefs.getInt('SelectedID'));
  //   if (selectedID == null) {
  //     // await showPhotoWarning(premiumStatus, context);
  //     print("abcd");
  //     print(premiumStatus);
  //     setLoading(false); // Hide loader
  //   } else {
  //     // Generate a unique identifier for the video
  //     String uniqueIdentifier = generateUniqueIdentifier(imageUrl);

  //     String? processedVideoPath = processedVideoCache[uniqueIdentifier];
  //     if (processedVideoPath == null) {
  //       // Capture the strip as an image
  //       File stripFile = await captureStripAsImage(stripKey);

  //       // Process video with overlay
  //       List<String> imagePaths = await getImageList();
  //       imagePaths.add(stripFile.path); // Add the strip image to the list
  //       print('Image paths: $imagePaths'); // Debug print

  //       processedVideoPath = await processVideoWithOverlay(imageUrl, imagePaths, uniqueIdentifier);
  //       print('Original video path: $imageUrl');
  //       print('Processed video path: $processedVideoPath');

  //       // Save the processed video path in the cache
  //       processedVideoCache[uniqueIdentifier] = processedVideoPath;
  //     } else {
  //       print('Using cached processed video path: $processedVideoPath');
  //     }

  //     setLoading(false); // Hide loader

  //     if (premiumStatus) {
  //       if (isPoster) {
  //         DownloadShareImage(controller: controller).shareScreenshot();
  //       } else {
  //         DownloadShareImage().shareVideo(processedVideoPath);
  //         print(processedVideoPath);
  //       }
  //     } else {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => PremiumView(
  //             imageUrl: processedVideoPath,
  //             isPoster: isPoster,
  //             isTestUser: isTestUser,
  //           ),
  //         ),
  //       );
  //     }
  //   }
}
// }
