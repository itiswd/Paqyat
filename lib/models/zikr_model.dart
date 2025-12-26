/// نموذج الذكر
class ZikrModel {
  final String text;
  final int count;
  final String? reference;
  final String? description;
  final String? audioPath;
  int currentCount;

  ZikrModel({
    required this.text,
    required this.count,
    this.reference,
    this.description,
    this.audioPath,
    this.currentCount = 0,
  });

  /// هل تم إكمال الذكر؟
  bool get isCompleted => currentCount >= count;

  /// إعادة تعيين العداد
  void reset() {
    currentCount = 0;
  }

  /// زيادة العداد
  void increment() {
    if (currentCount < count) {
      currentCount++;
    }
  }

  /// إنشاء من JSON/Map
  factory ZikrModel.fromMap(Map<String, dynamic> map) {
    return ZikrModel(
      text: map['zekr'] ?? '',
      count: map['int'] ?? 1,
      reference: map['reference'],
      description: map['description'],
      audioPath: map['path'],
      currentCount: map['fint'] ?? map['sabvar'] ?? 0,
    );
  }

  /// تحويل إلى Map
  Map<String, dynamic> toMap() {
    return {
      'zekr': text,
      'int': count,
      'reference': reference,
      'description': description,
      'path': audioPath,
      'fint': currentCount,
    };
  }
}

/// نموذج فئة الأذكار
class ZikrCategory {
  final String name;
  final List<ZikrModel> azkar;

  ZikrCategory({
    required this.name,
    required this.azkar,
  });

  /// عدد الأذكار في الفئة
  int get count => azkar.length;

  /// هل تم إكمال جميع الأذكار؟
  bool get isAllCompleted => azkar.every((z) => z.isCompleted);

  /// إعادة تعيين جميع الأذكار
  void resetAll() {
    for (var zikr in azkar) {
      zikr.reset();
    }
  }
}
