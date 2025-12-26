library arabic_numbers;

/// تحويل الأرقام إلى الأرقام العربية
class ArabicNumbers {
  static String convert(Object value) {
    assert(
      value is int || value is String,
      "The value object must be of type 'int' or 'String'.",
    );

    if (value is int) {
      return _toArabicNumbers(value.toString());
    } else {
      return _toArabicNumbers(value as String);
    }
  }

  static String _toArabicNumbers(String value) {
    return value
        .replaceAll('0', '٠')
        .replaceAll('1', '١')
        .replaceAll('2', '٢')
        .replaceAll('3', '٣')
        .replaceAll('4', '٤')
        .replaceAll('5', '٥')
        .replaceAll('6', '٦')
        .replaceAll('7', '٧')
        .replaceAll('8', '٨')
        .replaceAll('9', '٩');
  }
}

/// امتداد للأرقام الصحيحة
extension IntToArabic on int {
  String get toArabicNumbers => ArabicNumbers.convert(this);
}

/// امتداد للنصوص
extension StringToArabic on String {
  String get toArabicNumbers => ArabicNumbers.convert(this);
}

/// دوال مساعدة للتاريخ الهجري
class HijriHelper {
  static String getMonthName(int month) {
    const months = {
      1: 'مُحَرَّم',
      2: 'صَفَر',
      3: 'ربيع الأول',
      4: 'ربيع الآخر',
      5: 'جمادى الأولى',
      6: 'جمادى الآخرة',
      7: 'رجب',
      8: 'شَعْبَان',
      9: 'رمضان',
      10: 'شَوَّال',
      11: 'ذو القعدة',
      12: 'ذو الحجة',
    };
    return months[month] ?? '';
  }
}

/// دوال مساعدة للوقت
class TimeHelper {
  /// تنسيق المدة إلى نص
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  /// تحويل رقم السورة إلى صيغة ثلاثية
  static String padSurahNumber(int number) {
    return number.toString().padLeft(3, '0');
  }
}
