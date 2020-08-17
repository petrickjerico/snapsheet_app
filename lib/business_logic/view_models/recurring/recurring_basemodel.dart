import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data/user_data_impl.dart';

abstract class RecurringBaseModel {
  void init(UserData userData);
  Account getAccountFromUid(String accountUid);
  void undo();
  void addRecurring();
  void newRecurring();
  void editTempRecurring(int recurringIndex);
  void changeTitle(String newTitle);
  void changeValue(double newValue);
  void changeCategory(int newCategoryId);
  void changeAccount(int newAccountId);
  void changeNextRecurrence(DateTime newDateTime);
  void changeFrequencyId(int newFrequencyId);
  void changeTimeFrameId(int newTimeFrameId);
  void changeInterval(int newInterval);
  void changeUntilDate(DateTime newUntilDate);
  void changeXTimes(int newXTimes);
  void deleteRecurring();
}
