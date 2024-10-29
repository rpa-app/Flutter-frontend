import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrivacyDocument extends StatelessWidget {
  const PrivacyDocument({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 28,
                ),
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'Asset/Icons/ArrowLeft.svg',
                      height: 36,
                    )),
                SizedBox(
                  height: 36,
                ),
                Text(
                  'Privacy Policy',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Effective Date: 3rd April 2024\nRPAVentures LLC ("Developer," "we," "our," or "us") is committed to protecting your privacy. This Privacy Policy outlines how we collect, use, disclose, and safeguard your personal information while you use the Bharat Poster app ("App"). Bharat Poster is owned and operated by RPAVentures LLC.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  '1. Information Collection: We may collect personal information, such as your name, email address, and uploaded images, as well as non-personal data like usage statistics and device information to enhance the App’s functionality and performance.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  '2. Use of Information: Your personal information is used to provide and improve the App, respond to inquiries, send promotional content, perform analysis, and comply with legal obligations.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  '3. Disclosure of Information: We may share your information with third-party service providers who support the App, as required by law, or to protect our rights and property. We ensure that any such sharing is lawful and necessary.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  '4. Security: We implement measures to protect your data from unauthorized access or misuse. However, data transmission and storage cannot be guaranteed as fully secure. Users are responsible for maintaining their account’s security and confidentiality.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  '5. Third-Party Links: The App may contain links to third-party sites that we do not control. We are not responsible for their content or privacy practices. Please review their privacy policies before sharing personal information.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  '6. Children’s Privacy: Bharat Poster is not intended for children under 13. We do not knowingly collect information from children under 13. If we learn of any such data collected inadvertently, we will delete it promptly.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  '7. Changes to the Privacy Policy: We may update this Privacy Policy as needed. Any substantial changes will be communicated by posting an updated version within the App or by other means. Continued use of the App after changes implies acceptance of the revised Privacy Policy.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  '8. Contact Information: For questions or concerns regarding this Privacy Policy or Bharat Poster, please reach out to us at support@rpaventures.in.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'By using Bharat Poster, you acknowledge that you have read, understood, and agree to the terms outlined in this Privacy Policy.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
