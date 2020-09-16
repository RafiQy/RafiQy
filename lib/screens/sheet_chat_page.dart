import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rafiqy/models/message.dart';
import 'package:rafiqy/models/question.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SheetChatPage extends StatefulWidget {
  final String sheetName;
  SheetChatPage({Key key, this.sheetName}) : super(key: key);
  @override
  _SheetChatPageState createState() => _SheetChatPageState();
}

class _SheetChatPageState extends State<SheetChatPage> {
  bool isLoading = false;
  var _scrollController = ScrollController();
  TextEditingController _text = new TextEditingController();
  var childList = <Widget>[];
  String message = '';
  List sheet = [];
  int i = 0;
  int returnTo = 0;
  var bodyResponseSheet = <Question>[];
  List<Message> oldChat1 = [];
  var isBotTyping = false;
  Future<bool> _showMyDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'حفظ الأجابات',
            textDirection: TextDirection.rtl,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'هل ترغب حفظ أجاباتك لحين\n عودتك مرة أخرى؟',
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'لا أرغب',
                textDirection: TextDirection.rtl,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            FlatButton(
              child: Text(
                'أرغب',
                textDirection: TextDirection.rtl,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _showMyDialog,
      child: Scaffold(
        body: SafeArea(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  child: Stack(
                    fit: StackFit.loose,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 15,
                            color: Colors.transparent,
                            child: isLoading
                                ? LinearProgressIndicator()
                                : StepProgressIndicator(
                                    totalSteps: bodyResponseSheet.length + 8,
                                    currentStep: (i + 1),
                                    selectedSize: 8,
                                    selectedColor: Colors.green,
                                    // unselectedColor: Colors.amber,
                                  ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                reverse: true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: childList,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Divider(height: 2, color: Colors.black26),
                          // SizedBox(
                          //   height: 50,
                          Container(
                            color: Colors.white,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        // textInputAction:
                                        //   TextInputAction.newline,
                                        maxLines: 20,
                                        controller: _text,
                                        onChanged: (v) {
                                          message = v;
                                        },
                                        decoration: InputDecoration(
                                            // contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.send),
                                              onPressed: isBotTyping
                                                  ? () {}
                                                  : () {
                                                      if (message.length > 0) {
                                                        // DO NOT FORGET TO CHECK ARRAY BOUNDARY
                                                        setState(() {
                                                          _text.text = '';
                                                        });
                                                        message = '';
                                                      } else {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                'Please enter message',
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                        // print(chatLog);
                                                        // saveChat();
                                                      }
                                                    },
                                            ),
                                            border: InputBorder.none,
                                            hintText: 'Enter Message'),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.done_all),
                                      iconSize: 24.0,
                                      onPressed: isBotTyping
                                          ? () {}
                                          : () async {
                                              //  userMessage('تم');
                                              print(
                                                  "i=$i, sheet = ${bodyResponseSheet.length}");
                                              if (i + 1 >=
                                                  bodyResponseSheet.length) {
                                                //   await sheetDone();
                                              } else {
                                                //  await saveChat();
                                                setState(() {
                                                  //   nextBotMessage();
                                                  isBotTyping = true;
                                                });
                                              }
                                            },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
