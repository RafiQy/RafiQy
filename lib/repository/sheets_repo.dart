import 'package:rafiqy/api/sheets_list_api.dart';

class SheetsListRepo {
  Future<List> getSheetsListFromApi() async {
    return await SheetsListApi().getSheetsList();
  }
}
