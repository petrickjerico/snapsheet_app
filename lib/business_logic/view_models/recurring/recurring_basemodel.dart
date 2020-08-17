import 'package:snapsheetapp/business_logic/models/models.dart';
import 'package:snapsheetapp/business_logic/view_models/user_data/user_data_impl.dart';

abstract class RecurringBaseModel {
  /// Initialize the model with UserData.
  void init(UserData userData);
  Account getAccountFromUid(String accountUid);

  /// Disard all the edits that have been made.
  void undo();

  /// Initialize a new recurring record.
  void newRecurring();

  /// Initialization for editing the selected recurring record.
  void editTempRecurring(int recurringIndex);

  /// Add the new recurring record / Update the selected recurring record.
  void addRecurring();

  /// Update the new/selected record's attribute with the new value.
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

  /// Deletion.
  void deleteRecurring();
}
