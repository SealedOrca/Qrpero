import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Last Updated: [9/26/2023]',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '1. Introduction',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Welcome to our QR Scanner App ("Qrpero"). This Privacy Policy outlines how we collect, use, safeguard, and disclose information when you use our mobile application. By using the App, you consent to the practices described in this policy.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '2. Information We Collect',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'We may collect and store the following types of information:',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- **Scanned Data:** The App may access your device\'s camera to scan QR codes. Scanned data, including URLs, text, or other content, is processed locally on your device. We do not store or transmit this data to our servers.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- **Usage Information:** We collect anonymous usage data, such as app usage frequency, crash reports, and performance metrics, to enhance the App\'s functionality and user experience. This information is collected anonymously and does not personally identify you.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '3. How We Use Your Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'We utilize the collected information for the following purposes:',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- To provide and improve the App\'s features and functionality.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- To monitor and analyze usage patterns.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- To troubleshoot technical issues.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- To respond to user inquiries and support requests.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '4. Data Security',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'We take reasonable measures to protect your information from unauthorized access or disclosure. However, please be aware that no method of data transmission over the Internet or electronic storage is entirely secure, and we cannot guarantee the security of your data.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '5. Third-Party Services',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'The App may include links to third-party websites, services, or advertisements. We are not responsible for the privacy practices of these third parties. Please review the privacy policies of those websites or services.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '6. Changes to This Privacy Policy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'We may update this Privacy Policy to reflect changes in our practices or for other operational, legal, or regulatory reasons. We will notify you of any material changes by posting the new policy on this page. We encourage you to review this Privacy Policy periodically.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '7. Contact Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'If you have any questions or concerns about this Privacy Policy, please contact us at [Contact Email].',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'By using the App, you agree to this Privacy Policy. If you do not agree with the terms of this policy, please do not use the App.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'This Privacy Policy was last updated on [9/26/2023].',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
