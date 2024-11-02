import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 28),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    'Asset/Icons/ArrowLeft.svg',
                    height: 36,
                  ),
                ),
                const SizedBox(height: 36),
                Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width *
                        0.065, // Responsive font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "At Bharat Posters, we are committed to delivering innovative and user-friendly "
                  "mobile applications that empower individuals to express their creativity. "
                  "With our Bharat Posters app, we provide a simple yet powerful tool for users "
                  "to create impactful posters using their own photos. Our mission is to enable "
                  "users to share their political views, support causes, and spark conversations "
                  "through visually engaging and shareable content. Join us and let your voice "
                  "be heard with Bharat Posters by RPA Ventures LLC.",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width *
                        0.05, // Lower responsive font size
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
