import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class REFUNDDocument extends StatelessWidget {
  const REFUNDDocument({Key? key}) : super(key: key);

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
                  'Cancellation and Refund Policy',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width *
                        0.07, // Responsive font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '1. Premium Plan Services:'),
                _buildSectionContent(context,
                    'Bharat Posters offers a premium plan that enables users to create and share personalized posters featuring their photos and names. Access to these premium services requires payment of a recurring subscription fee.'),
                _buildSectionTitle(context, '2. Cancellation Process:'),
                _buildSectionContent(context,
                    'Users can initiate a cancellation request anytime by emailing support@rpaventuresllc.com with their registered mobile number or email ID. Membership cancellations will be processed within 24 hours of receiving the request.'),
                _buildSectionTitle(context, '3. Refund Policy:'),
                _buildSectionContent(context,
                    'Payments made prior to cancellation are non-refundable.'),
                _buildSectionTitle(context, '4. Continuation of Benefits:'),
                _buildSectionContent(context,
                    'Users will retain access to premium benefits until the end of the paid term, even if cancellation occurs during the subscription period.'),
                _buildSectionTitle(context, '5. Dispute Resolution:'),
                _buildSectionContent(context,
                    'RPA Ventures LLC reserves the right to arbitrate disputes arising from the cancellation or refund process.'),
                _buildSectionTitle(context, '6. Account Deletion:'),
                _buildSectionContent(context,
                    'Users may request account and data deletion by emailing their concerns to support@rpaventuresllc.com.'),
                _buildSectionContent(context,
                    'Note: It is crucial to review and acknowledge these terms before proceeding with cancellation or account deletion. By submitting the form, you confirm that you have read and agree to the conditions mentioned in this document.'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width *
                0.07, // Responsive font size
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSectionContent(BuildContext context, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        content,
        style: TextStyle(
          fontSize:
              MediaQuery.of(context).size.width * 0.06, // Responsive font size
        ),
      ),
    );
  }
}
