import 'package:ap1/bar/btmbar.dart';
import 'package:ap1/sp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ap1/walk/walkthorughpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataManager.instance.initializeDatabases();
  // Initialize the database
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: MaterialApp(
        title: 'Qrpero',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          useMaterial3: true,
        ),
        home: FutureBuilder<bool>(
          future: isFirstRun(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == true) {
                // First run, show the walkthrough page
                return const WalkthroughPage();
              } else {
                // Not the first run, go to the home page
                return const MyHomePage(); // Replace with your actual home page widget
              }
            } else {
              return const CircularProgressIndicator(); // Loading indicator
            }
          },
        ),
      ),
    );
  }

  Future<bool> isFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool('firstRun') ?? true;

    if (isFirstRun) {
      // Set firstRun to false to indicate that the walkthrough has been shown
      await prefs.setBool('firstRun', false);
    }

    return isFirstRun;
  }
}
