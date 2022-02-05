import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; For making the app always on portrait . . .

import './widgets/home_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  //  To allow portrait mode only!
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      colorScheme: ColorScheme.light(
        primary: const Color(0xFF2C0540),
        primaryContainer: const Color(0xff3700b3),
        secondary: const Color(0xFFFFC95B),
        secondaryContainer: const Color(0xff018786),
        surface: Colors.white,
        background: Colors.white,
        error: const Color(0xffb00020),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onBackground: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: const Color(0xFFFFC95B),
        selectionColor: const Color(0xFFFFC95B),
      ),
      fontFamily: 'Quicksand',
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          // color: const Color(0xFFFFC95B),
          fontFamily: 'OpenSans',
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        button: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Quicksand',
        ),
        headline3: TextStyle(
          color: Colors.white,
          // fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'Quicksand',
        ),
        headline4: TextStyle(
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
          fontSize: 14,
        ),
        headline5: TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        headline6: TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Exps',
      theme: theme,
      home: MyHomePage(),
    );
  }
}
