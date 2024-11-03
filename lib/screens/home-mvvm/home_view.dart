// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:bharatposters0/screens/home-mvvm/home_viewmodel.dart';
// import 'package:bharatposters0/screens/profile-mvvm/profile_view.dart';
// import 'package:bharatposters0/services/user_image_operations.dart';
// import 'package:bharatposters0/screens/template/template_right_1.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'package:stacked/stacked.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ThemeData themeData = Theme.of(context);
//     return ViewModelBuilder<HomeViewModel>.reactive(
//       viewModelBuilder: () => HomeViewModel(),
//       onViewModelReady: (viewModel) =>
//           viewModel.onViewModelReady(context, themeData),
//       builder: (context, viewModel, child) => Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: Scaffold(
//             backgroundColor: themeData.colorScheme.background,
//             body: SingleChildScrollView(
//               controller: viewModel.scrollController,
//               physics: const AlwaysScrollableScrollPhysics(),
//               scrollDirection: Axis.vertical,
//               child: Column(
//                 children: [
//                   _buildTopSegment(viewModel, themeData),
//                   const SizedBox(height: 36),
//                   _buildLazyLoadedView(viewModel, themeData),
//                   const SizedBox(height: 36),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLazyLoadedView(HomeViewModel viewModel, ThemeData themeData) {
//     return ListView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: viewModel.loadedItems.length +
//           (viewModel.showLoadingIndicator ? 1 : 0),
//       itemBuilder: (BuildContext context, int index) {
//         if (viewModel.showLoadingIndicator &&
//             index == viewModel.loadedItems.length) {
//           return _buildLoadingIndicator(themeData);
//         } else {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: Template_right_1(
//               imageUrl: viewModel.loadedItems[index],
//               premiumStatus: viewModel.premiumStatus,
//               showCTA: true,
//               onImageAdded: () => setState(() {}),
//               isPoster: true,
//             ),
//           );
//         }
//       },
//     );
//   }

//   Future<Widget> _userImage(HomeViewModel viewModel) async {
//     if (viewModel.selectedID != null) {
//       var userImage =
//           await UserImage().returnSelectedUserImage(viewModel.selectedID);
//       return Image.file(
//         userImage,
//         fit: BoxFit.contain,
//         width: 260,
//         height: 260,
//         alignment: Alignment.bottomCenter,
//       );
//     } else {
//       return SvgPicture.asset(
//         'assets/svg/ImagePlaceholder.svg',
//         fit: BoxFit.contain,
//         width: 260,
//         height: 260,
//       );
//     }
//   }

//   Widget _buildLoadingIndicator(ThemeData themeData) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(
//             color: themeData.colorScheme.outline,
//             strokeWidth: 2,
//           ),
//           const SizedBox(width: 12),
//           Text(
//             'Loading..',
//             style: themeData.textTheme.bodyLarge,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTopSegment(HomeViewModel viewModel, ThemeData themeData) {
//     return FutureBuilder<Widget>(
//       future: _userImage(viewModel),
//       builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
//         if (snapshot.hasData) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//             child: Row(
//               children: [
//                 Text(
//                   'Bharat Posters',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontFamily: 'Work-Sans',
//                     fontWeight: FontWeight.w600,
//                     color: themeData.colorScheme.onBackground,
//                   ),
//                 ),
//                 const Spacer(),
//                 CircleAvatar(
//                   radius: 36,
//                   backgroundColor: themeData.colorScheme.primary,
//                   child: CircleAvatar(
//                     radius: 32,
//                     backgroundColor: themeData.colorScheme.background,
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProfileView(
//                               onProfileDetailsChange: () => setState(() {}),
//                             ),
//                           ),
//                         );
//                       },
//                       child: CircleAvatar(
//                         radius: 28,
//                         backgroundColor: Colors.white,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(28),
//                           child: snapshot.data,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return const CircularProgressIndicator();
//         }
//       },
//     );
//   }

//   Widget _shareWidget(HomeViewModel viewModel) {
//     return GestureDetector(
//       onTap: () async {
//         // Uncomment if needed
//         // await viewModel.shareOnWhatsapp();
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.green,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SvgPicture.asset('assets/icons/Whatsapp-Icon.svg', height: 40),
//               const SizedBox(width: 12),
//               AutoSizeText(
//                 'पार्टी के समर्थकों के साथ एप्प\nशेयर करें और प्रचार करें',
//                 minFontSize: 20,
//                 maxFontSize: 24,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Mukta',
//                   color: Colors.white,
//                   height: 1.4,
//                 ),
//               ),
//               const Spacer(),
//               SvgPicture.asset(
//                 'assets/icons/Arrow-Right.svg',
//                 height: 24,
//                 colorFilter:
//                     const ColorFilter.mode(Colors.white, BlendMode.srcIn),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bharatposters0/screens/home-mvvm/home_viewmodel.dart';
import 'package:bharatposters0/screens/profile-mvvm/profile_view.dart';
import 'package:bharatposters0/screens/template/template_right_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // 1. Home page
    HomeContent(),
    // 2. Placeholder for "Create Poster"
    Center(child: Text('Create Poster Page -- COming Soon')),
    // 3. Profile page
    ProfileView(onProfileDetailsChange: () {})
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) =>
          viewModel.onViewModelReady(context, themeData),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Bharat Posters',
              style: TextStyle(
                  fontFamily: 'Work-Sans', fontWeight: FontWeight.w600)),
          backgroundColor: Colors.white,
        ),
        // backgroundColor: Colors.grey.shade400,
        // backgroundColor: themeData.colorScheme.background,
        body: SafeArea(
          child: _pages[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box), label: 'Create Poster'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

// Extracted Home content widget for cleaner code
class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => SingleChildScrollView(
        controller: viewModel.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _buildLazyLoadedView(viewModel, themeData),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  Widget _buildLazyLoadedView(HomeViewModel viewModel, ThemeData themeData) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: viewModel.loadedItems.length +
          (viewModel.showLoadingIndicator ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (viewModel.showLoadingIndicator &&
            index == viewModel.loadedItems.length) {
          return _buildLoadingIndicator(themeData);
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Template_right_1(
              imageUrl: viewModel.loadedItems[index],
              premiumStatus: viewModel.premiumStatus,
              showCTA: true,
              onImageAdded: () => setState(() {}),
              isPoster: true,
            ),
          );
        }
      },
    );
  }

  Widget _buildLoadingIndicator(ThemeData themeData) {
    return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centers content vertically
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Animated Loading Spinner or Custom Icon Animation
          SizedBox(
            height: 40,
            width: 40,
            child: LinearProgressIndicator(
              color: themeData.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          // Custom Text Message with Styling
          Text(
            'Curating the best posters just for you...',
            textAlign: TextAlign.center,
            style: themeData.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: themeData.colorScheme.primary,
            ),
          ),
        ],
      ),
    ),
  );
}
  
}
