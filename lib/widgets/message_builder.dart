import 'package:flutter/material.dart';
import '../models/check_list_item.dart';
import '../models/question.dart';
import './chat_bubble_typing.dart';
import './chat_bubble_video.dart';
import './chat_buttons.dart';
import './check_list_bubble.dart';

class QuesMsgBuilder extends StatelessWidget {
  final Question question;
  final Function f1;
  final Function f2;
  final bool isPressed;
  QuesMsgBuilder({this.question, this.f1, this.f2, this.isPressed = false});
  itemsToCheckListItems() {
    List<CheckListItem> items = [];
    question.items.forEach((element) {
      var q = Map<String, dynamic>.from(element);
      CheckListItem qst = CheckListItem.fromJson(q);
      items.add(qst);
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Container(
        color: Theme.of(context).accentColor,
        child: Column(
          children: <Widget>[
            question.isTyping
                ? BubbleTyping()
                : SizedBox(
                    height: 0.0,
                  ),
            question.body != null
                ? Text(
                    question.body.replaceAll("&#", "\n"),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                : SizedBox(
                    height: 0.0,
                  ),
            question.videoUrl != null
                ? BubbleVideo(
                    videoUrl: question.videoUrl,
                  )
                : SizedBox(
                    height: 0.0,
                  ),
            question.items != null
                ? checkList(items: itemsToCheckListItems())
                : SizedBox(
                    height: 0.0,
                  ),
            question.btnOne != null && question.btnTwo != null
                ? FittedBox(
                    fit: BoxFit.fitWidth,
                    child: ChatButtons(
                      btn1Title: question.btnOne,
                      btn2Title: question.btnTwo,
                      btn1Func: f1,
                      btn2Func: f2,
                      isPressed: isPressed,
                    ),
                  )
                : SizedBox(
                    height: 0.0,
                  ),
          ],
        ),
      ),
    );
  }
}
