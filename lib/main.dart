import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafiqy/providers/auth_provider.dart';
import 'package:rafiqy/providers/sheets_list_provider.dart';
import 'package:rafiqy/providers/user_provider.dart';
import 'package:rafiqy/screens/login_page.dart';
import 'screens/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SheetsListProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<AuthProvider>(
          builder:
              (BuildContext context, AuthProvider authProvider, Widget child) {
            if (authProvider.status == Status.Authenticated) {
              return HomePage();
            } else
              return LoginPage();
          },
        ),
      ),
    );
  }
}
