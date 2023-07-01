library restore_data_package;

import 'package:flutter/cupertino.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;

  ///时间戳
  static String getNowSecond(){
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  ///时间戳转日期2023-5-19 21:14:33
  static String getTimeFormat(String second){
    DateTime time = DateTime.fromMicrosecondsSinceEpoch(int.parse(second));
    return time.toLocal().toString().substring(0, 16);
  }

  /// 根据字符串, 日期格式化（2023-5-19 21:14:33）
  static String dateTimeFormat(String date) {
    String result = '';

    if (date == "刚刚") {
      result = date;
    } else {
      var now = DateTime.now();
      var old = DateTime.parse(date).add(DateTime
          .now()
          .timeZoneOffset);
      var difference = now.difference(old);
      if (difference.inMinutes < 1) {
        result = "刚刚";
      } else if (difference.inMinutes < 60) {
        result =  "${difference.inMinutes}分钟前";
      } else if (difference.inHours <= 23) {
        result =  "${difference.inHours}小时前";
      } else if (difference.inDays < 2) {
        result =  "${difference.inDays}天前";
      } else {
        if (now.year == old.year) {
          result = '${point(old.month.toString())}-${point(old.day.toString())} ${point(old.hour.toString())}:${point(old.minute.toString())}';
        } else {
          result = date;
        }
      }
    }

    return result;
  }

  ///判断时间是否为一位数，补全0
  static String point(String str) {
    if (str.length > 1) {
      return str;
    } else {
      return "0${str}";
    }
  }


  ///判断字符串是否溢出
  static bool outOrNoWith(String text, double width, int lineNum, double fontSize){

    var span = TextSpan(
      text: text,
      style: TextStyle(fontSize: fontSize),
    );
    var tp = TextPainter(
      maxLines: 4,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      text: span,
    );
    tp.layout(maxWidth: width);
    // whether the text overflowed or not
    return tp.didExceedMaxLines;
  }

  static double textWidth(String string, double fontSize){
    if(string.isEmpty){
      return 0.0;
    }
    TextPainter painter = TextPainter(
      maxLines: 1,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: string,
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
    );
    painter.layout(maxWidth: 800);
    return painter.width;
  }

}
