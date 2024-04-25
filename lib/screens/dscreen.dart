import 'package:ap1/sp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class DataDetailScreen extends StatelessWidget {
  final String data;
  final Map<String, dynamic>? item;

  const DataDetailScreen({Key? key, required this.data, this.item, required DataManager dataManager}) : super(key: key);

  Future<void> _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  bool _isURL(String data) {
    return Uri.tryParse(data)?.isAbsolute ?? false;
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard: $text'),
      ),
    );
  }

  void _shareData(BuildContext context, String data) {
    Share.share(data, subject: 'Sharing Data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Data Details',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    _isURL(data)
                        ? InkWell(
                            onTap: () {
                              _launchURL(data); // Open in an external browser
                            },
                            child: Text(
                              data,
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        : Text(
                            data,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _copyToClipboard(context, data);
              },
              child: const Text('Copy to Clipboard'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _shareData(context, data);
              },
              child: const Text('Share Data'),
            ),
          ],
        ),
      ),
    );
  }
}
