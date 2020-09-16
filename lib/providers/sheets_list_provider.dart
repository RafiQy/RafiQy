import 'package:flutter/foundation.dart';
import 'package:rafiqy/repository/sheets_repo.dart';

class SheetsListProvider with ChangeNotifier {
  List sheets;

  getSheetsList() async {
    sheets = await SheetsListRepo().getSheetsListFromApi();
    notifyListeners();
  }
}
