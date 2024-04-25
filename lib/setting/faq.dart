import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class FAQScreen extends StatelessWidget {
  final List<FAQItem> faqItems = [
    FAQItem(
      question: 'What is a QR code?',
      answer:
          'A QR code (Quick Response code) is a two-dimensional barcode that can store various types of data, such as URLs, text, contact information, and more. It is designed to be quickly scanned and provides easy access to information.',
    ),
    FAQItem(
      question: 'How do I scan a QR code?',
      answer:
          'To scan a QR code, open the QR Scanner app, press the start scan button and point your device\'s camera at the code, and ensure it is properly framed within the scanner. The app will automatically recognize the QR code and provide the associated information or action.',
    ),
    FAQItem(
      question: 'What can I do with scanned QR codes?',
      answer:
          'You can perform various actions with scanned QR codes, such as opening URLs in your web browser, adding contact information to your address book, viewing PDF documents, and more. The actions depend on the type of QR code and the app\'s capabilities.',
    ),
    FAQItem(
      question: 'Is my data safe when scanning QR codes?',
      answer:
          'Yes, your data is safe when scanning QR codes with our app. We prioritize user privacy and security. We do not collect or store any information from scanned QR codes without your consent.',
    ),
    FAQItem(
      question: 'What is Image Scan?',
      answer:
          'Let\'s say that you have an image of the QR code in your gallery. You would just go to the scanning page and select the image of the QR, and then the app would scan directly from the image.',
    ),
    // Add more FAQs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQs',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final item in faqItems) FAQListItem(item: item),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

class FAQListItem extends StatelessWidget {
  final FAQItem item;

  const FAQListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item.question,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.answer,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
