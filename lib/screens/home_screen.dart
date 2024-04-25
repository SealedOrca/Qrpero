import 'dart:io';

import 'package:ap1/setting/about.dart';
import 'package:ap1/setting/autosetting.dart';
import 'package:ap1/setting/customersupport.dart';
import 'package:ap1/setting/faq.dart';

import 'package:ap1/sp.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryItem {
  final String id;
  final String data;

  HistoryItem({required this.id, required this.data});
}

class ScanningPage extends StatefulWidget {
  final DataManager dataManager;
  final ScanSettings scanSettings;

  const ScanningPage({
    Key? key,
    required this.dataManager,
    required this.scanSettings,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ScanningPageState createState() => _ScanningPageState();
}

class _ScanningPageState extends State<ScanningPage> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  List<HistoryItem> _history = [];
  double _zoomLevel = 0.0;
  String _scannedData = '';
  int _scanCounter = 1;
  bool _dataScanned = false;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _initializeCamera() async {
    final cameraPermission = await Permission.camera.request();

    if (cameraPermission.isGranted) {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: defaultTargetPlatform == TargetPlatform.android
            ? ImageFormatGroup.yuv420
            : ImageFormatGroup.bgra8888,
      );
      await _controller!.initialize();
      if (!mounted) {
        return;
      }
      setState(() {
        _isCameraInitialized = true;
      });
    } else {
      // Handle camera permission denied or restricted
      // You can show a dialog or message to the user
    }
  }

  Future<void> _startCameraScan() async {
  if (!_isCameraInitialized) {
    await _initializeCamera();
  }

  try {
    final barcodeResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.QR,
    );

    if (barcodeResult != '-1') {
      final historyItem = HistoryItem(
        id: 'Scan${_scanCounter++}',
        data: barcodeResult,
      );
      setState(() {
        _history.insert(0, historyItem);
        _scannedData = barcodeResult;
        _dataScanned = true;
      });

      // Save scanned data to the database
      widget.dataManager.saveData(barcodeResult);
      _saveHistory();
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error scanning barcode: $e');
    }
  }
}


  Future<void> _startImageScan() async {
    final storagePermission = await Permission.storage.request();

    if (storagePermission.isGranted) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final qrCode =
            await FlutterQrReader.imgScan(File(pickedFile.path).path);
        // ignore: unnecessary_null_comparison
        if (qrCode != null) {
          final historyItem = HistoryItem(
            id: 'Scan${_scanCounter++}',
            data: qrCode,
          );
          setState(() {
            _history.insert(0, historyItem);
            _scannedData = qrCode;
            _dataScanned = true;
          });

          // Save scanned data to the database
          widget.dataManager.saveData(qrCode);
          _saveHistory();
        }
      }
    } else {
      // Handle storage permission denied or restricted
      // You can show a dialog or message to the user
    }
  }

  Future<void> _loadHistory() async {
    final historyData = await widget.dataManager.retrieveAllData();
    final historyItems = historyData!.map((data) {
      return HistoryItem(
        id: 'Scan${_scanCounter++}',
        data: data['data'] as String,
      );
    }).toList();

    setState(() {
      _history = historyItems;
      if (_history.isNotEmpty) {
        _scannedData = _history.first.data;
      }
    });
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyIds = _history.map((item) => item.id).toList();
    await prefs.setStringList('history', historyIds);
    for (final item in _history) {
      await prefs.setString(item.id, item.data);
    }
  }

  @override
  void dispose() {
    if (_controller != null && _controller!.value.isInitialized) {
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QR Scanner',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text(''),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/cpq.jpg'), // Replace with the path to your cover photo
                  fit: BoxFit.cover,
                ),
              ),
              accountEmail: null,
            ),
            // ListTile(
            //   title: const Text('Auto Scan'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => MyApp123()),
            //     );
            //   },
            // ),
            ListTile(
              title: const Text('CustomerSupport'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactSupportSettingsPage()),
                );
              },
            ),
            ListTile(
              title: const Text('FAQ Screen'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAQScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          _isCameraInitialized
              ? SizedBox(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: CameraPreview(_controller!),
                )
              : const SizedBox.shrink(),

          Align(
            alignment: Alignment.bottomCenter,
            child: _dataScanned
                ? ZoomSliderAndDataDisplay(
                    // Display scanned data
                    zoomLevel: _zoomLevel,
                    setZoomLevel: (value) {
                      setState(() {
                        _zoomLevel = value;
                        _controller!.setZoomLevel(_zoomLevel);
                      });
                    },
                    scannedData: _scannedData,
                    onShareData: () {
                      _shareData(_scannedData);
                    },
                    onTryAgain: _reloadPage,
                  )
                : FirstScreenContent(
                    // Display initial buttons
                    startCameraScan: _startCameraScan,
                    startImageScan: _startImageScan,
                  ),
          ),
        ],
      ),
    );
  }

  void _shareData(String data) {
    Share.share(data);
  }

  void _reloadPage() {
    setState(() {
      _scannedData = ''; // Reset scanned data
      _dataScanned = false; // Reset the data scanned flag
    });
  }
}

class FirstScreenContent extends StatelessWidget {
  final Function() startCameraScan;
  final Function() startImageScan;

  const FirstScreenContent({
    Key? key,
    required this.startCameraScan,
    required this.startImageScan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/back.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 800,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: startCameraScan,
                icon: const Icon(Icons.camera),
                label: const Text('Start Camera'),
              ),
              ElevatedButton.icon(
                onPressed: startImageScan,
                icon: const Icon(Icons.image),
                label: const Text('Recognize Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ZoomSliderAndDataDisplay extends StatelessWidget {
  final double zoomLevel;
  final Function(double) setZoomLevel;
  final String scannedData;
  final VoidCallback onShareData;
  final VoidCallback onTryAgain;

  const ZoomSliderAndDataDisplay({
    Key? key,
    required this.zoomLevel,
    required this.setZoomLevel,
    required this.scannedData,
    required this.onShareData,
    required this.onTryAgain,
  }) : super(key: key);

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: scannedData));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
      ),
    );
  }

  void _launchURL(BuildContext context) async {
    final url = scannedData;

    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch the URL'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/back.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 800,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Scanned Data:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchURL(context); // Open the URL in a browser
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    scannedData,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              if (scannedData.isNotEmpty)
                ElevatedButton.icon(
                  onPressed: () {
                    _copyToClipboard(context);
                  },
                  icon: const Icon(Icons.content_copy),
                  label: const Text('Copy to Clipboard'),
                ),
              if (scannedData.isNotEmpty)
                ElevatedButton.icon(
                  onPressed: onShareData,
                  icon: const Icon(Icons.share),
                  label: const Text('Share Data'),
                ),
              ElevatedButton.icon(
                onPressed: onTryAgain,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
