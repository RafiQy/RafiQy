import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rafiqy/api/sheets_list_api.dart';
import 'package:rafiqy/providers/sheets_list_provider.dart';
import 'package:rafiqy/providers/user_provider.dart';
import 'package:rafiqy/repository/sheets_repo.dart';
import 'package:rafiqy/screens/sheet_chat_page.dart';

class SheetsPage extends StatefulWidget {
  const SheetsPage({Key key}) : super(key: key);

  @override
  _SheetsPageState createState() => _SheetsPageState();
}

class _SheetsPageState extends State<SheetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Consumer<SheetsListProvider>(builder: (_, value, __) {
                if (value.sheets != null) {
                  var sheets = value.sheets;
                  return ListView.builder(
                    itemBuilder: (_, index) => Card(
                      margin: EdgeInsets.all(15),
                      elevation: 10,
                      shadowColor: Color(0xFF519FE7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SheetChatPage(
                                sheetName: sheets[index].toString(),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Text(
                              sheets[index].toString(),
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemCount: sheets.length,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ),
            FlatButton(
              child: Text('getsheets'),
              onPressed: () async {
                try {
                  await Provider.of<SheetsListProvider>(context, listen: false)
                      .getSheetsList();
                } catch (e) {
                  print(e);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(e.toString()),
                      actions: [
                        FlatButton(
                          child: Text("Okay"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                }
                // List<String> x = await SheetsListRepo().getSheetsListFromApi();
                // print(x);
                // x.forEach((element) {
                //   print(element.reference.id);
                // });
              },
            )
          ],
        ),
      ),
    );
  }
}
