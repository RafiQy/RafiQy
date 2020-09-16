import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafiqy/providers/auth_provider.dart';
import 'package:rafiqy/providers/user_provider.dart';
import 'package:rafiqy/screens/sheets_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user;
  @override
  void initState() {
    user = Provider.of<AuthProvider>(context, listen: false).user;
    Provider.of<UserProvider>(context, listen: false).getUserInfo(user.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<UserProvider>(
              builder: (BuildContext context, value, Widget child) {
                if (value.user != null)
                  return Text(value.user.id);
                else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              },
            ),
            FlatButton(
              child: Text('Sign out'),
              onPressed: () =>
                  Provider.of<AuthProvider>(context, listen: false).signOut(),
            ),
            FlatButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SheetsPage(),
                  )),
              child: Text('To Sheets'),
            ),
          ],
        ),
      ),
    );
  }
}
