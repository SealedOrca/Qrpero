import 'package:ap1/setting/privacy.dart';
import 'package:ap1/setting/terms.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(
            color: Colors.black, // Set app bar text color to black
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true, // Set app bar background color to white
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center content horizontally
            children: <Widget>[
              Image.asset(
                'assets/scanner.jpeg', // Replace with your app's logo image asset
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 16),
              const Text(
                'Qrpero Scanner',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Version: 1.0.0',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Text(
                'Description:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Scan QR codes and Share and use QR codes for various purposes with ease. Also, scan QR codes from images.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center, // Center the text
              ),
              const SizedBox(height: 16),
              const Text(
                'Our Mission:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Empowering users to simplify information sharing and access through QR codes, enhancing connectivity in the digital world.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center, // Center the text
              ),
              const SizedBox(height: 16),
              const Text(
                'Developer:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'SoftwarFlare/OZ',
                style: TextStyle(fontSize: 18),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PrivacyPolicyScreen(),
                    ),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                    children: [
                      TextSpan(text: 'Privacy Policy'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TermsOfServiceScreen(),
                    ),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                    children: [
                      TextSpan(text: 'Terms of Service'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
