import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class TermsOfServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms of Service',
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
              'Terms of Service',
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
              '1. Acceptance of Terms',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'By downloading, installing, or using our QR Scanner App ("Qrpero"), you agree to comply with these Terms of Service ("Terms"). If you do not agree with these Terms, please do not use the App.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '2. Use of the App',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '- You may use the App for personal or commercial purposes, subject to these Terms.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- You must be at least 13 years old to use the App.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- You agree not to use the App for any illegal, harmful, or unauthorized activities.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '3. Content Usage',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '- The App allows you to scan QR codes and access related content. You are responsible for the content you access through the App.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- We do not guarantee the accuracy, availability, or safety of the content linked to QR codes.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '4. Privacy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '- We may collect and use your information as described in our Privacy Policy.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- You are responsible for keeping your device and access to the App secure.',
              style: TextStyle(fontSize: 16),
            ),
            // Continue to add more sections following a similar structure.
            SizedBox(height: 16),
            Text(
              '5. Governing Law',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'These Terms are governed by and construed in accordance with the laws of playstore.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '6. Contact Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'If you have any questions or concerns about these Terms, please contact us at [info@softwareflare.com].',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'By using the App, you agree to these Terms. If you do not agree with these Terms, please uninstall the App and discontinue its use.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'These Terms were last updated on [9/26/2023].',
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
