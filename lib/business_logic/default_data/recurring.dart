import 'package:snapsheetapp/business_logic/default_data/categories.dart';
import 'package:snapsheetapp/business_logic/models/models.dart';

/// Timeframe ID
const FOREVER = 0;
const UNTILDATE = 1;
const FORXTIMES = 2;

List<String> timeFrames = ['Forever', 'Until a date', 'For x times'];

/// Frequency ID
const DAILY = 0;
const WEEKLY = 1;
const MONTHLY = 2;
const YEARLY = 3;

List<int> frequencyIntervals = [for (var i = 1; i < 32; i += 1) i];

List<String> frequencies = [
  'daily',
  'weekly',
  'monthly',
  'yearly',
];

List<String> plural = [
  'days',
  'weeks',
  'months',
  'years',
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

/// For number scroll picker
const frequencyPickerData = '''
[
  [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31
  ],
  [
    "day(s)",
    "week(s)",
    "month(s)",
    "year(s)"
  ]
]
''';
