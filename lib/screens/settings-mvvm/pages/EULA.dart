import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EULADocument extends StatelessWidget {
  const EULADocument({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('End-User License Agreement'),
            leading: IconButton(
              icon: SvgPicture.asset(
                'Asset/Icons/ArrowLeft.svg',
                height: 24,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Colors.white),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'End-User License Agreement (EULA) for Bharat Poster',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'This End-User License Agreement ("EULA") is a legal agreement between you (referred to as "User" or "You") and RPAventures LLC (referred to as "Developer" or "We") for the use of the Bharat Poster (referred to as "App"). By installing or using the App, You agree to be bound by the terms and conditions of this EULA.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ..._buildEULATexts(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildEULATexts() {
    const eulaTexts = [
      '1. Grant of License: Developer grants You a limited, non-exclusive, non-transferable, revocable license to use the App for personal, non-commercial purposes on compatible devices that You own or control. You may not use the App for any other purpose or on any other device without obtaining written consent from Developer.',
      '2. User-Generated Content: The App allows You to upload Your own photo to create a shareable poster. You acknowledge that You are solely responsible for the content You upload and You warrant that You have the necessary rights, permissions, and consents to use such content. Developer does not claim ownership of Your content, but You grant Developer a worldwide, royalty-free, perpetual, irrevocable, and sublicensable right to use, reproduce, modify, adapt, publish, translate, distribute, and display Your content for the purpose of providing the App and its features.',
      '3. Restrictions: You may not, and You agree not to, without prior written consent from Developer: (a) copy, modify, or distribute the App; (b) reverse engineer, decompile, or disassemble the App; (c) remove, alter, or obscure any proprietary notices or labels on the App; (d) use the App in any way that violates applicable laws or regulations; (e) use the App to infringe upon the intellectual property rights or privacy rights of any third party; (f) use the App to create, distribute, or share any offensive, harmful, or illegal content; (g) use the App to engage in any fraudulent or unauthorized activities.',
      '4. Intellectual Property: The App, including but not limited to its design, graphics, logos, trademarks, and content, are owned by Developer and protected by intellectual property laws. You acknowledge that You do not acquire any ownership or intellectual property rights in the App by using it, and all rights not expressly granted to You are reserved by Developer.',
      '5. Privacy: Developer may collect and use Your personal information in accordance with its Privacy Policy, which is available within the App. By using the App, You consent to the collection and use of Your personal information as described in the Privacy Policy.',
      '6. Warranty Disclaimer: The App is provided "as is" and without any warranty or representation, express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, and non-infringement. Developer does not warrant that the App will be error-free, uninterrupted, or free from viruses or other harmful components.',
      '7. Limitation of Liability: To the maximum extent permitted by applicable law, Developer and its affiliates, officers, directors, employees, agents, and contractors shall not be liable for any direct, indirect, incidental, consequential, special, or exemplary damages arising out of or in connection with the use or inability to use the App, even if Developer has been advised of the possibility of such damages.',
      '8. Indemnification: You agree to indemnify, defend, and hold harmless Developer and its affiliates, officers, directors, employees, agents, and contractors from and against any claims, damages, losses, liabilities, and expenses (including attorney fees) arising out of or in connection with Your use of the App, Your content, or any violation of this EULA.',
      '9. Termination: Developer may terminate this EULA and Your access to the App at any time, without notice or liability, for any reason or no reason, including but not limited to Your breach of this EULA. Upon termination, You must cease all use of the App and delete any copies of the App that You have in Your possession or control.',
      '10. Updates and Modifications: Developer may, in its sole discretion, release updates, modifications, or new versions of the App from time to time, which may include bug fixes, improvements, or new features. You agree that such updates or modifications may be installed automatically and You consent to receive such updates or modifications.',
      '11. Governing Law and Jurisdiction: This EULA shall be governed by and construed in accordance with the laws of the jurisdiction where Developer is located, without regard to conflicts of law principles. Any disputes arising out of or in connection with this EULA shall be resolved exclusively by the competent courts of the jurisdiction where Developer is located.',
      '12. Entire Agreement: This EULA constitutes the entire agreement between You and Developer regarding the subject matter hereof and supersedes all prior or contemporaneous agreements, understandings, and representations, whether oral or written. Any modifications or amendments to this EULA must be in writing and signed by both parties.',
      '13. Severability: If any provision of this EULA is held to be invalid, illegal, or unenforceable, the remaining provisions shall continue in full force and effect.',
      '14. Waiver: The failure of Developer to enforce any provision of this EULA shall not constitute a waiver of such provision or any other provision of this EULA.',
      '15. Assignment: You may not assign or transfer this EULA or any of Your rights or obligations hereunder without prior written consent from Developer. Developer may freely assign or transfer this EULA without restriction.',
      '16. Contact Information: If You have any questions or comments about this EULA or the App, please contact Developer at [support@govmatters.in].',
    ];

    return eulaTexts
        .map((text) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
            ))
        .toList();
  }
}
