import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TERMSDocument extends StatelessWidget {
  const TERMSDocument({Key? key}) : super(key: key);

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
                SizedBox(height: 28),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    'Asset/Icons/ArrowLeft.svg',
                    height: 36,
                  ),
                ),
                SizedBox(height: 36),
                Text(
                  'Terms and Conditions for Bharat Poster',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 16),
                _buildSectionTitle(context, '1. Introduction'),
                _buildSectionContent(
                  context,
                  'Welcome to the Bharat Poster App! These Terms of Use ("Terms") and the Bharat Poster mobile application (collectively, the "Platform") are provided by RPAVentures LLC ("Bharat Poster," "Company," "we," "us," and "our"). By accessing and using our Platform, you agree to abide by these Terms. Please read them carefully. These Terms should be read in conjunction with the Bharat Poster Privacy Policy. If you do not agree with these Terms and Conditions, please refrain from using the Platform.',
                ),
                _buildSectionTitle(context, '2. Changes to Terms and Services'),
                _buildSectionContent(
                  context,
                  'Bharat Poster is dynamic, and our services may evolve. We reserve the right to modify the services and features offered on the Platform without notice. Be sure to check this page periodically for updates on changes and developments. Your continued use of the Platform constitutes acceptance of any revised terms.',
                ),
                _buildSectionTitle(context, '3. User Eligibility'),
                _buildSectionContent(
                  context,
                  'The Bharat Poster App is designed to help you connect with your community and share content. You may use our services if you can enter into a binding agreement with us and are legally permitted to do so in your jurisdiction. If you are accepting these Terms on behalf of a company or legal entity, you represent that you have the authority to bind such entities.',
                ),
                _buildSectionTitle(context, '4. How to Use Our Services'),
                _buildSectionContent(
                  context,
                  'The Bharat Poster App offers a unique platform that encourages community engagement by supporting your political party. To use our services, you need to register on our app by providing your name and mobile number. We respect your privacy and do not access information on your device without permission.',
                ),
                _buildSectionTitle(context, '5. Cancellation and Refund'),
                _buildSectionContent(
                  context,
                  '• Bharat Poster App offers a premium plan for access to new templates with monthly or annual payment options.\n'
                  '• You can cancel your subscription at any time by emailing support@rpaventures.com with your registered mobile number or email ID.\n'
                  '• Membership cancellation occurs within 24 hours of receiving the cancellation request.\n'
                  '• Payments made prior to cancellation are non-refundable.\n'
                  '• Premium benefits continue until the end of the charged plan.\n'
                  '• The company reserves the right to interpret any terms in case of disputes.',
                ),
                _buildSectionTitle(context, '6. Privacy Policy'),
                _buildSectionContent(
                  context,
                  'To enhance our services, we collect information in compliance with the Bharat Poster Privacy Policy. This includes your phone number and name, stored securely on AWS and Google Cloud servers.',
                ),
                _buildSectionTitle(context, '7. Your Commitments'),
                _buildSectionContent(
                  context,
                  '• Provide accurate information on the Platform.\n'
                  '• Maintain device security with antivirus software.\n'
                  '• Abide by Bharat Poster App’s content removal and termination policies.\n'
                  '• Ensure lawful use of the Platform in compliance with Indian laws.',
                ),
                _buildSectionTitle(
                    context, '8. Content Rights and Liabilities'),
                _buildSectionContent(
                  context,
                  'Bharat Poster App respects freedom of expression. Users retain ownership of shared content, and Bharat Poster does not claim intellectual property rights over user-generated content.',
                ),
                _buildSectionTitle(
                    context, '9. Intermediary Status and No Liability'),
                _buildSectionContent(
                  context,
                  'Bharat Poster App operates as an intermediary under Indian law, providing a platform for users. Bharat Poster is not liable for user actions and does not endorse content.',
                ),
                _buildSectionTitle(context, '10. Permissions You Give to Us'),
                _buildSectionContent(
                  context,
                  '• Accept automatic downloads and updates for the Bharat Poster mobile application.\n'
                  '• Provide permission to use cookies for Platform functionality.\n'
                  '• Agree to data retention policies outlined in the Bharat Poster Privacy Policy.',
                ),
                _buildSectionTitle(context, '11. Limitation of Liability'),
                _buildSectionContent(
                  context,
                  'Bharat Poster App is not liable for loss or damage arising from information inaccuracies or breaches. The Platform is provided as is, and Bharat Poster’s liability is limited to the charges paid for Platform use.',
                ),
                _buildSectionTitle(context, '12. Indemnification'),
                _buildSectionContent(
                  context,
                  'Users agree to indemnify Bharat Poster App against claims arising from Platform use, including breaches of obligations and violations of third-party rights.',
                ),
                _buildSectionTitle(context, '13. Unsolicited Material'),
                _buildSectionContent(
                  context,
                  'Bharat Poster App appreciates feedback but may use suggestions without obligation to compensate. Bharat Poster is not obligated to keep suggestions confidential.',
                ),
                _buildSectionTitle(context, '14. General'),
                _buildSectionContent(
                  context,
                  'Unenforceable aspects of these Terms will not affect the rest. Amendments or waivers to these Terms require written agreement. Failure to enforce any aspect of these Terms does not waive Bharat Poster’s rights. Bharat Poster reserves all rights not expressly granted.',
                ),
                _buildSectionTitle(context, '15. Dispute Resolution'),
                _buildSectionContent(
                  context,
                  'All disputes are subject to the laws of the Republic of India, with the courts of Mumbai having exclusive jurisdiction.',
                ),
                _buildSectionTitle(context, '16. Grievance Officer'),
                _buildSectionContent(
                  context,
                  'Contact our Grievance Officer at admin@rpaventures.com for concerns related to data safety, privacy, and Platform usage.',
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize:
              MediaQuery.of(context).size.width * 0.07, // Responsive font size
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSectionContent(BuildContext context, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        content,
        style: TextStyle(
          fontSize:
              MediaQuery.of(context).size.width * 0.060, // Responsive font size
        ),
      ),
    );
  }
}
