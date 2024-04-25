// import 'package:ap1/bar/btmbar.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   final bool showWalkthrough = prefs.getBool('show_walkthrough') ?? true;

//   runApp(
//     MaterialApp(
//       home: showWalkthrough ? WalkthroughPage() : MyHomePage(),
//     ),
//   );
// }


// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: WalkthroughPage(),
//     );
//   }
// }

// class WalkthroughPage extends StatefulWidget {
//   const WalkthroughPage({Key? key}) : super(key: key);

//   @override
//   _WalkthroughPageState createState() => _WalkthroughPageState();
// }

// class _WalkthroughPageState extends State<WalkthroughPage> {
//   final PageController _pageController = PageController();
//   int currentPage = 0;
//   late SharedPreferences _prefs;
//   bool _showWalkthrough = true;

//   @override
//   void initState() {
//     super.initState();
//     _initSharedPreferences();
//     _pageController.addListener(() {
//       setState(() {
//         currentPage = _pageController.page!.round();
//       });
//     });
//   }

//   void _initSharedPreferences() async {
//     _prefs = await SharedPreferences.getInstance();
//     _showWalkthrough = _prefs.getBool('show_walkthrough') ?? true;
//     if (!_showWalkthrough) {
//       _navigateToHomePage();
//     }
//   }

//   void _navigateToHomePage() {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) => const MyHomePage(),
//       ),
//     );
//     _prefs.setBool('show_walkthrough', false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           PageView(
//             controller: _pageController,
//             children: const [
//               WalkthroughPageItem(
//                 title: 'Scan QR Codes',
//                 description: 'Easily scan QR codes to access information quickly and efficiently.',
//                 animationAssetPath: 'assets/start.json',
//               ),
//               WalkthroughPageItem(
//                 title: 'Save Scanned Data',
//                 description: 'Save the scanned QR code data for future reference or sharing.',
//                 animationAssetPath: 'assets/second.json',
//               ),
//               WalkthroughPageItem(
//                 title: 'Explore Features',
//                 description: 'Discover more features and options within the app to enhance your QR code experience.',
//                 animationAssetPath: 'assets/third.json',
//               ),
//             ],
//           ),
//           Positioned(
//             top: 32,
//             right: 16,
//             child: TextButton(
//               onPressed: () {
//                 _navigateToHomePage();
//               },
//               child: const Text(
//                 'Skip',
//                 style: TextStyle(
//                   color: Colors.greenAccent,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 16,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 3,
//                 (index) => AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   height: 8,
//                   width: currentPage == index ? 24 : 8,
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           if (currentPage == 2)
//             Positioned(
//               bottom: 32,
//               left: 0,
//               right: 0,
//               child: Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     _navigateToHomePage();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: Colors.blue,
//                     elevation: 5,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                   ),
//                   child: const Text('Get Started'),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
// }

// class WalkthroughPageItem extends StatelessWidget {
//   final String title;
//   final String description;
//   final String animationAssetPath;

//   const WalkthroughPageItem({
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.animationAssetPath,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Lottie.asset(
//             animationAssetPath,
//             height: 300,
//             width: 300,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             title,
//             style: Theme.of(context).textTheme.headline6!.copyWith(
//               fontSize: 24,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             description,
//             style: Theme.of(context).textTheme.bodyText2!.copyWith(
//               fontSize: 16,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:ap1/bar/btmbar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   final bool showWalkthrough = prefs.getBool('show_walkthrough') ?? true;

//   runApp(
//     MaterialApp(
//       home: showWalkthrough ? const WalkthroughPage() : const MyHomePage(),
//     ),
//   );
// }

class WalkthroughPage extends StatefulWidget {
  const WalkthroughPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WalkthroughPageState createState() => _WalkthroughPageState();
}

class _WalkthroughPageState extends State<WalkthroughPage> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  late SharedPreferences _prefs;
  bool _showWalkthrough = true;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });
    });
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _showWalkthrough = _prefs.getBool('show_walkthrough') ?? true;
    if (!_showWalkthrough) {
      _navigateToHomePage();
    }
  }

  void _navigateToHomePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MyHomePage(),
      ),
    );
    _prefs.setBool('show_walkthrough', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: const [
              WalkthroughPageItem(
                title: 'Scan QR Codes',
                description: 'Easily scan QR codes to access information quickly and efficiently.',
                animationAssetPath: 'assets/start.json',
              ),
              WalkthroughPageItem(
                title: 'Save Scanned Data',
                description: 'Save the scanned QR code data for future reference or sharing.',
                animationAssetPath: 'assets/second.json',
              ),
              WalkthroughPageItem(
                title: 'Explore Features',
                description: 'Discover more features and options within the app to enhance your QR code experience.',
                animationAssetPath: 'assets/third.json',
              ),
            ],
          ),
          Positioned(
            top: 32,
            right: 16,
            child: TextButton(
              onPressed: () {
                _navigateToHomePage();
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 8,
                  width: currentPage == index ? 24 : 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          if (currentPage == 2)
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    _navigateToHomePage();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('Get Started'),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class WalkthroughPageItem extends StatelessWidget {
  final String title;
  final String description;
  final String animationAssetPath;

  const WalkthroughPageItem({
    Key? key,
    required this.title,
    required this.description,
    required this.animationAssetPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            animationAssetPath,
            height: 300,
            width: 300,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
