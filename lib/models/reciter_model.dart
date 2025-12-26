/// نموذج القارئ
class ReciterModel {
  final String id;
  final String name;
  final String baseUrl;
  final String? imageUrl;

  ReciterModel({
    required this.id,
    required this.name,
    required this.baseUrl,
    this.imageUrl,
  });

  /// الحصول على رابط السورة
  String getSurahUrl(int surahNumber) {
    String number = surahNumber.toString().padLeft(3, '0');
    return '$baseUrl$number.mp3';
  }

  /// إنشاء من Map
  factory ReciterModel.fromMap(Map<String, dynamic> map) {
    return ReciterModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      baseUrl: map['url'] ?? '',
      imageUrl: map['image'],
    );
  }

  /// تحويل إلى Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': baseUrl,
      'image': imageUrl,
    };
  }
}

/// قائمة القراء المتاحين
class RecitersData {
  static final List<ReciterModel> reciters = [
    ReciterModel(
      id: 'husr',
      name: 'محمود خليل الحصري',
      baseUrl: 'https://server13.mp3quran.net/husr/',
      imageUrl:
          'https://is5-ssl.mzstatic.com/image/thumb/Purple49/v4/73/14/23/731423bc-28a2-378b-956b-0ac5586cac47/source/512x512bb.jpg',
    ),
    ReciterModel(
      id: 'maher',
      name: 'ماهر المعيقلي',
      baseUrl: 'https://server12.mp3quran.net/maher/',
      imageUrl: '',
    ),
    ReciterModel(
      id: 'afs',
      name: 'مشاري العفاسي',
      baseUrl: 'https://server8.mp3quran.net/afs/',
      imageUrl: '',
    ),
    ReciterModel(
      id: 'abdul_basit',
      name: 'عبد الباسط عبد الصمد',
      baseUrl: 'https://server7.mp3quran.net/basit/',
      imageUrl: '',
    ),
    ReciterModel(
      id: 'sudais',
      name: 'عبد الرحمن السديس',
      baseUrl: 'https://server11.mp3quran.net/sds/',
      imageUrl: '',
    ),
    ReciterModel(
      id: 'shuraim',
      name: 'سعود الشريم',
      baseUrl: 'https://server7.mp3quran.net/shur/',
      imageUrl: '',
    ),
    ReciterModel(
      id: 'minshawi',
      name: 'محمد صديق المنشاوي',
      baseUrl: 'https://server10.mp3quran.net/minsh/',
      imageUrl: '',
    ),
  ];

  /// الحصول على قارئ بواسطة المعرف
  static ReciterModel? getById(String id) {
    try {
      return reciters.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  /// الحصول على قارئ بواسطة الفهرس
  static ReciterModel getByIndex(int index) {
    if (index >= 0 && index < reciters.length) {
      return reciters[index];
    }
    return reciters.first;
  }
}
