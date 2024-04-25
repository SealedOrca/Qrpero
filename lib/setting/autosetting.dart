import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp123());
}

class ScanSettings {
  bool autoScanEnabled = true; // Initialize auto-scan as enabled
  bool isScanning = false; // Track if a scan is currently in progress

  Future<void> performScan(bool isAutoScan) async {
    if (!isScanning) {
      if (kDebugMode) {
        print('Scanning...');
      }
      isScanning = true;

      await Future.delayed(const Duration(seconds: 2), () {
        if (kDebugMode) {
          print('Scan completed!');
        }
        isScanning = false;
      });
    }
  }
}

class MyApp123 extends StatelessWidget {
  final ScanSettings scanSettings = ScanSettings();

  MyApp123({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Scan Settings',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black, // Set the arrow color to white
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ScanSettingsPage(scanSettings: scanSettings),
      ),
    );
  }
}

class ScanSettingsPage extends StatefulWidget {
  final ScanSettings scanSettings;

  const ScanSettingsPage({super.key, required this.scanSettings});

  @override
  // ignore: library_private_types_in_public_api
  _ScanSettingsPageState createState() => _ScanSettingsPageState();
}

class _ScanSettingsPageState extends State<ScanSettingsPage> {
  String scanMode = 'Auto';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Scan Mode: $scanMode'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Radio(
                value: 'Auto',
                groupValue: scanMode,
                onChanged: (value) {
                  setState(() {
                    scanMode = value.toString();
                    widget.scanSettings.autoScanEnabled = true;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Auto-scan mode selected.'),
                      ),
                    );
                  });
                },
              ),
              const Text('Auto'),
              Radio(
                value: 'Manual',
                groupValue: scanMode,
                onChanged: (value) {
                  setState(() {
                    scanMode = value.toString();
                    widget.scanSettings.autoScanEnabled = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Manual scan mode selected.'),
                      ),
                    );
                  });
                },
              ),
              const Text('Manual'),
            ],
          ),
        ),
      ],
    );
  }
}
