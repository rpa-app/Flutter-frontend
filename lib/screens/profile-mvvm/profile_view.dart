// import 'dart:io';
// import 'package:auto_route/auto_route.dart';
// import 'package:bharatposters0/global/primarybutton.dart';
// import 'package:bharatposters0/route/route.gr.dart';
// import 'package:bharatposters0/screens/profile-mvvm/profile_viewmodel.dart';
// import 'package:bharatposters0/services/user_image_operations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'package:stacked/stacked.dart';
// import '../../global/CustomSecondaryButton.dart';

// @RoutePage()
// class ProfileView extends StatefulWidget {
//   final VoidCallback onProfileDetailsChange;
//   const ProfileView({
//     super.key,
//     required this.onProfileDetailsChange,
//   });

//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   @override
//   Widget build(BuildContext context) {
//     ThemeData themeData = Theme.of(context);
//     return ViewModelBuilder<ProfileViewModel>.reactive(
//         viewModelBuilder: () => ProfileViewModel(),
//         builder: (context, viewModel, child) => SafeArea(
//               child: Scaffold(
//                 backgroundColor: Colors.grey.shade400,
//                 body: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       // photoElements(viewModel),
//                       // const SizedBox(height: 24),
//                       profileName(viewModel),
//                       const SizedBox(height: 24),
//                       callToActions(viewModel),
//                       const SizedBox(height: 24),
//                       profileImageGrid(viewModel),
//                       const SizedBox(height: 44, width: 44)
//                     ],
//                   ),
//                 ),
//               ),
//             ));
//   }

//   Widget photoElements(ProfileViewModel viewModel) {
//     return FutureBuilder(
//         future: userImage(viewModel),
//         builder: (context, snapshot) {
//           return Stack(
//             children: [
//               // Container(
//               //   height: 100,
//               //   width: MediaQuery.of(context).size.width,
//               //   // color: Colors.blue,
//               //   child: snapshot.data,
//               // ),
//               Positioned(
//                 top: 12,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   width: MediaQuery.of(context).size.width,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                             // AutoRouter.of(context).pop();
//                           },
//                           child: SvgPicture.asset(
//                             'Asset/Icons/Arrow-Back-BG.svg',
//                             width: 36,
//                           )),
//                       Spacer(),
//                       GestureDetector(
//                         onTap: () async {
//                           AutoRouter.of(context)
//                               .push(EditProfileViewRoute(onDetailsSaved: () {
//                             widget.onProfileDetailsChange.call();
//                             setState(() {});
//                           }));
//                         },
//                         child: Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 6),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(30),
//                               color: Colors.black.withAlpha(120),
//                             ),
//                             child: Text(
//                               'प्रोफाइल एडिट करें',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontFamily: 'Mukta'),
//                             )),
//                       ),
//                       SizedBox(
//                         width: 12,
//                       ),
//                       GestureDetector(
//                           onTap: () {
//                             AutoRouter.of(context).push(SettingsViewRoute());
//                           },
//                           child: SvgPicture.asset(
//                             'Asset/Icons/Settings-Icon.svg',
//                             width: 36,
//                           )),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         });
//   }

//   Widget profileName(ProfileViewModel viewModel) {
//     return FutureBuilder(
//         future: viewModel.fetchLabelData(),
//         builder: (BuildContext context, AsyncSnapshot nameSnapshot) {
//           List<String>? collection = nameSnapshot.data;
//           if (nameSnapshot.hasData && nameSnapshot.data != null) {
//             return Container(
//               padding: EdgeInsets.symmetric(horizontal: 24),
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     collection![0],
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Mukta',
//                         color: Colors.black87),
//                   ),
//                   Text(
//                     collection[1],
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                         fontSize: 20, color: Colors.black87.withAlpha(150)),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return CircularProgressIndicator();
//           }
//         });
//   }

//   Widget callToActions(ProfileViewModel viewModel) {
//     ThemeData themeData = Theme.of(context);
//     return Column(
//       children: [
//         Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: PrimaryButton(
//               iconPath: 'Asset/Icons/User-Photo.svg',
//               isEnabled: true,
//               height: 48,
//               isLoading: false,
//               onTap: () async {
//                 viewModel.userImageChange(context);
//               },
//               label: 'फोटो बदलें',
//               color: themeData.colorScheme.primary,
//             )),
//         const SizedBox(height: 12),
//         Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: CustomSecondaryButton(
//               leadingIcon: 'Asset/Icons/EditIcon.svg',
//               onPressed: () async {
//                 viewModel.onTapChangeParty(context);
//               },
//               buttonText: 'पार्टी बदलें',
//               buttonColor: null,
//             )),
//       ],
//     );
//   }

//   Widget profileImageGrid(ProfileViewModel viewModel) {
//     ThemeData themeData = Theme.of(context);
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//           alignment: Alignment.topLeft,
//           child: Text('Saved Profile Pictures',
//               style: TextStyle(
//                   fontSize: 16,
//                   fontFamily: 'Work-Sans',
//                   fontWeight: FontWeight.w500,
//                   color: themeData.colorScheme.onBackground)),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12),
//           child: FutureBuilder(
//             future: UserImage().returnListFileAddress(),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData && snapshot.data != null) {
//                 List<File> returnedUserAddress = snapshot.data;
//                 returnedUserAddress = returnedUserAddress.reversed.toList();
//                 return GridView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   itemCount: snapshot.data.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 12,
//                     mainAxisSpacing: 12,
//                   ),
//                   itemBuilder: (BuildContext GridContext, int index) {
//                     return GestureDetector(
//                         onTap: () {
//                           showCustomModalBottomSheet(index, context, viewModel);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.blue,
//                             border: Border.all(
//                               color: viewModel.selectedID == index
//                                   ? Colors.green
//                                   : Colors.white54,
//                               width: 3,
//                               strokeAlign: BorderSide.strokeAlignOutside,
//                             ),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           clipBehavior: Clip.hardEdge,
//                           child: Image.file(
//                             returnedUserAddress[index],
//                             fit: BoxFit.cover,
//                             alignment: Alignment.topCenter,
//                           ),
//                         ));
//                   },
//                 );
//               } else {
//                 return SizedBox();
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Future<Widget> userImage(ProfileViewModel viewModel) async {
//     int? selectedID = viewModel.prefs.getInt('SelectedID');
//     dynamic userImage = Container(
//       color: Colors.blueGrey.shade50,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.image_rounded,
//             color: Colors.blueGrey,
//             size: 56,
//           ),
//           SizedBox(
//             height: 12,
//           ),
//           Text(
//             'You will see your\nphoto here',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//             textAlign: TextAlign.center,
//           )
//         ],
//       ),
//     );
//     if (selectedID == null) {
//       //do nothing
//     } else {
//       userImage = await UserImage().returnSelectedUserImage(selectedID);
//     }
//     if (userImage is File) {
//       return Image.file(
//         userImage,
//         alignment: Alignment.bottomCenter,
//         fit: BoxFit.contain,
//         width: 200,
//         height: 200,
//       );
//     } else {
//       return userImage;
//     }
//   }

//   Future<void> showCustomModalBottomSheet(
//       int index, BuildContext gridContext, ProfileViewModel viewModel) async {
//     await showModalBottomSheet(
//       isScrollControlled: true,
//       context: gridContext,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(20),
//           topLeft: Radius.circular(20),
//         ),
//       ),
//       builder: (BuildContext context) {
//         return Container(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           alignment: Alignment.center,
//           height: 100,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 alignment: Alignment.center,
//                 width: 52,
//                 height: 4,
//                 decoration: BoxDecoration(
//                     color: Colors.grey.withAlpha(100),
//                     borderRadius: BorderRadius.circular(40)),
//               ),
//               SizedBox(height: 24),
//               GestureDetector(
//                 onTap: () async {
//                   viewModel.prefs.setInt('SelectedID', index);
//                   widget.onProfileDetailsChange.call();
//                   Navigator.pop(context);
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     content: Text('Photo Updated'),
//                     duration: Duration(seconds: 1),
//                   ));
//                 },
//                 child: Row(
//                   children: [
//                     Icon(Icons.account_box, color: Colors.black87, size: 32),
//                     SizedBox(width: 12),
//                     Text('Make this primary',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'Work-Sans',
//                             fontSize: 16,
//                             color: Colors.black87)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'dart:io';
import 'package:bharatposters0/screens/settings-mvvm/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:auto_route/auto_route.dart';

import '../../global/primarybutton.dart';
import '../../global/CustomSecondaryButton.dart';
import 'profile_viewmodel.dart';
import 'package:bharatposters0/services/user_image_operations.dart';

@RoutePage()
class ProfileView extends StatefulWidget {
  final VoidCallback onProfileDetailsChange;

  const ProfileView({
    super.key,
    required this.onProfileDetailsChange,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Profile', style: themeData.textTheme.headline6),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon:
                  SvgPicture.asset('Asset/Icons/Settings-Icon.svg', width: 28),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      SettingsView(), // replace with your Settings page widget
                ),
              ),

              // onPressed: () => AutoRouter.of(context).push(SettingsViewRoute()),
            ),
          ],
        ),
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              _buildProfileHeader(viewModel),
              const SizedBox(height: 20),
              _buildCallToActions(viewModel, themeData),
              const SizedBox(height: 20),
              _buildProfileImageGrid(viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ProfileViewModel viewModel) {
    return FutureBuilder(
      future: viewModel.fetchLabelData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var nameData = snapshot.data as List<String>;
          return Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade300,
                child: FutureBuilder<Widget>(
                  future: _userImage(viewModel),
                  builder: (context, imageSnapshot) {
                    return imageSnapshot.hasData
                        ? imageSnapshot.data!
                        : Icon(Icons.person,
                            size: 50, color: Colors.grey.shade700);
                  },
                ),
              ),
              const SizedBox(height: 12),
              Text(
                nameData[0],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Mukta',
                  color: Colors.black87,
                ),
              ),
              Text(
                nameData[1],
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontFamily: 'Mukta',
                ),
              ),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildCallToActions(ProfileViewModel viewModel, ThemeData themeData) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: PrimaryButton(
            iconPath: 'Asset/Icons/User-Photo.svg',
            isEnabled: true,
            height: 48,
            isLoading: false,
            onTap: () async {
              viewModel.userImageChange(context);
            },
            label: 'Update Photo',
            color: themeData.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomSecondaryButton(
            leadingIcon: 'Asset/Icons/EditIcon.svg',
            onPressed: () async {
              viewModel.onTapChangeParty(context);
            },
            buttonText: 'Change Party',
            buttonColor: null,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImageGrid(ProfileViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: FutureBuilder(
        future: UserImage().returnListFileAddress(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            List<File> returnedUserAddress = snapshot.data;
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: returnedUserAddress.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _showCustomModalBottomSheet(index, viewModel),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(
                        color: viewModel.selectedID == index
                            ? Colors.green
                            : Colors.white54,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        returnedUserAddress[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<Widget> _userImage(ProfileViewModel viewModel) async {
    int? selectedID = viewModel.prefs.getInt('SelectedID');
    return selectedID == null
        ? Icon(Icons.person, size: 80, color: Colors.grey.shade400)
        : Image.file(
            await UserImage().returnSelectedUserImage(selectedID),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          );
  }

  Future<void> _showCustomModalBottomSheet(
      int index, ProfileViewModel viewModel) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading:
                    Icon(Icons.account_circle, color: Colors.black87, size: 30),
                title: Text(
                  'Set as Primary',
                ),
                onTap: () {
                  viewModel.prefs.setInt('SelectedID', index);
                  widget.onProfileDetailsChange.call();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Profile picture updated!'),
                    duration: Duration(seconds: 1),
                  ));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
