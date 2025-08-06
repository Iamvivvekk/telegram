import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  String get toDMY => DateFormat().add_yMd().format(this);
  String get toDMy => DateFormat().add_MMMd().format(this);

  String get toTime => DateFormat().add_jm().format(this);
}
