import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';

const FOREVER = 0;
const UNTILDATE = 1;
const FORXTIMES = 2;

List<String> timeFrames = ['Forever', 'Until a date', 'For x times'];

const DAILY = 0;
const WEEKLY = 1;
const MONTHLY = 2;
const YEARLY = 3;

List<String> frequencies = [
  'daily',
  'weekly',
  'monthly',
  'yearly',
];

List<String> singular = [
  'day',
  'week',
  'month',
  'year',
];

List<String> plural = [
  'days',
  'weeks',
  'months',
  'years',
];

List<String> singularAndPlural = [
  'day(s)',
  'week(s)',
  'month(s)',
  'year(s)',
];

List<Recurring> demoRecurrings = [universityFee, mobileData, scholarship];

Recurring universityFee = Recurring(
    title: "University Fee",
    value: 9100,
    categoryId: EDUCATION,
    isIncome: false,
    nextRecurrence: DateTime(2021, 1, 1),
    frequencyId: MONTHLY,
    interval: 6,
    timeFrameId: FORXTIMES,
    xTimes: 8,
    untilDate: DateTime(2050, 1, 1));

Recurring mobileData = Recurring(
  title: "Mobile Data",
  value: 20,
  categoryId: ELECTRONICS,
  isIncome: false,
  nextRecurrence: DateTime(2020, 8, 1),
  frequencyId: MONTHLY,
  interval: 1,
  timeFrameId: FOREVER,
  xTimes: 1,
  untilDate: DateTime(2050, 1, 1),
);

Recurring scholarship = Recurring(
  title: "Scholarship",
  value: 2800,
  categoryId: INCOME,
  isIncome: true,
  nextRecurrence: DateTime(2020, 9, 1),
  frequencyId: MONTHLY,
  interval: 6,
  timeFrameId: UNTILDATE,
  xTimes: 1,
  untilDate: DateTime(2023, 7, 1),
);
