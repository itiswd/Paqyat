import 'package:shared_preferences/shared_preferences.dart';

/// خدمة إدارة التفضيلات المحفوظة
class PreferencesService {
  static PreferencesService? _instance;
  static SharedPreferences? _preferences;

  PreferencesService._();

  /// الحصول على instance واحد من الخدمة (Singleton)
  static Future<PreferencesService> getInstance() async {
    _instance ??= PreferencesService._();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  // مفاتيح التفضيلات
  static const String _keyDarkMode = 'Dark';
  static const String _keyAllCounter = 'allcounter';
  static const String _keyMute = 'Mute';
  static const String _keyMadina = 'madina';
  static const String _keyMobtahelen = 'mobb';
  static const String _keyInitPage = 'initpage';
  static const String _keyAudio = 'audio';
  static const String _keySlider = 'slider';
  static const String _keyView = 'view';
  static const String _keyPrefSa = 'prefsa';
  static const String _keyTransVis = 'transvis';
  static const String _keyTransVis2 = 'transvis2';
  static const String _keyTransVis3 = 'transvis3';
  static const String _keyMood = 'moody';
  static const String _keyArabicFontSize = 'arabicFontSize';
  static const String _keyMushafFontSize = 'mushafFontSize';
  static const String _keySurah = 'surah';
  static const String _keyAyah = 'ayah';
  static const String _keyGovernorate = 'governorate';

  // ========== الحصول على القيم ==========

  /// الحصول على وضع الظلام
  int getDarkMode() => _preferences?.getInt(_keyDarkMode) ?? 0;

  /// الحصول على العداد الكلي
  int getAllCounter() => _preferences?.getInt(_keyAllCounter) ?? 0;

  /// الحصول على حالة الصوت
  int getMute() => _preferences?.getInt(_keyMute) ?? 0;

  /// الحصول على وضع المدينة
  int getMadina() => _preferences?.getInt(_keyMadina) ?? 0;

  /// الحصول على وضع المبتهلين
  int getMobtahelen() => _preferences?.getInt(_keyMobtahelen) ?? 0;

  /// الحصول على الصفحة الابتدائية
  int getInitPage() => _preferences?.getInt(_keyInitPage) ?? 0;

  /// الحصول على الصوت المحدد
  int getAudio() => _preferences?.getInt(_keyAudio) ?? 0;

  /// الحصول على قيمة الـ slider
  double getSlider() => _preferences?.getDouble(_keySlider) ?? 0;

  /// الحصول على حالة العرض
  bool getView() => _preferences?.getBool(_keyView) ?? false;

  /// الحصول على prefsa
  int getPrefSa() => _preferences?.getInt(_keyPrefSa) ?? 0;

  /// الحصول على حالة الترجمة 1
  bool getTransVis() => _preferences?.getBool(_keyTransVis) ?? false;

  /// الحصول على حالة الترجمة 2
  bool getTransVis2() => _preferences?.getBool(_keyTransVis2) ?? false;

  /// الحصول على حالة الترجمة 3
  bool getTransVis3() => _preferences?.getBool(_keyTransVis3) ?? false;

  /// الحصول على المزاج
  int getMood() => _preferences?.getInt(_keyMood) ?? 0;

  /// الحصول على حجم خط القرآن
  double getArabicFontSize() =>
      _preferences?.getDouble(_keyArabicFontSize) ?? 20.0;

  /// الحصول على حجم خط المصحف
  double getMushafFontSize() =>
      _preferences?.getDouble(_keyMushafFontSize) ?? 24.0;

  /// الحصول على السورة المحفوظة
  int getBookmarkedSurah() => _preferences?.getInt(_keySurah) ?? 1;

  /// الحصول على الآية المحفوظة
  int getBookmarkedAyah() => _preferences?.getInt(_keyAyah) ?? 1;

  /// الحصول على المحافظة
  String getGovernorate() =>
      _preferences?.getString(_keyGovernorate) ?? 'القاهرة';

  // ========== حفظ القيم ==========

  /// حفظ وضع الظلام
  Future<void> setDarkMode(int value) async {
    await _preferences?.setInt(_keyDarkMode, value);
  }

  /// حفظ العداد الكلي
  Future<void> setAllCounter(int value) async {
    await _preferences?.setInt(_keyAllCounter, value);
  }

  /// حفظ حالة الصوت
  Future<void> setMute(int value) async {
    await _preferences?.setInt(_keyMute, value);
  }

  /// حفظ وضع المدينة
  Future<void> setMadina(int value) async {
    await _preferences?.setInt(_keyMadina, value);
  }

  /// حفظ وضع المبتهلين
  Future<void> setMobtahelen(int value) async {
    await _preferences?.setInt(_keyMobtahelen, value);
  }

  /// حفظ الصفحة الابتدائية
  Future<void> setInitPage(int value) async {
    await _preferences?.setInt(_keyInitPage, value);
  }

  /// حفظ الصوت المحدد
  Future<void> setAudio(int value) async {
    await _preferences?.setInt(_keyAudio, value);
  }

  /// حفظ قيمة الـ slider
  Future<void> setSlider(double value) async {
    await _preferences?.setDouble(_keySlider, value);
  }

  /// حفظ حالة العرض
  Future<void> setView(bool value) async {
    await _preferences?.setBool(_keyView, value);
  }

  /// حفظ prefsa
  Future<void> setPrefSa(int value) async {
    await _preferences?.setInt(_keyPrefSa, value);
  }

  /// حفظ حالة الترجمة 1
  Future<void> setTransVis(bool value) async {
    await _preferences?.setBool(_keyTransVis, value);
  }

  /// حفظ حالة الترجمة 2
  Future<void> setTransVis2(bool value) async {
    await _preferences?.setBool(_keyTransVis2, value);
  }

  /// حفظ حالة الترجمة 3
  Future<void> setTransVis3(bool value) async {
    await _preferences?.setBool(_keyTransVis3, value);
  }

  /// حفظ المزاج
  Future<void> setMood(int value) async {
    await _preferences?.setInt(_keyMood, value);
  }

  /// حفظ حجم خط القرآن
  Future<void> setArabicFontSize(double value) async {
    await _preferences?.setDouble(_keyArabicFontSize, value);
  }

  /// حفظ حجم خط المصحف
  Future<void> setMushafFontSize(double value) async {
    await _preferences?.setDouble(_keyMushafFontSize, value);
  }

  /// حفظ الإشارة المرجعية
  Future<void> setBookmark(int surah, int ayah) async {
    await _preferences?.setInt(_keySurah, surah);
    await _preferences?.setInt(_keyAyah, ayah);
  }

  /// حفظ المحافظة
  Future<void> setGovernorate(String value) async {
    await _preferences?.setString(_keyGovernorate, value);
  }

  // ========== دوال مساعدة ==========

  /// الحصول على جميع الإعدادات دفعة واحدة
  AppSettings getAllSettings() {
    return AppSettings(
      darkMode: getDarkMode(),
      allCounter: getAllCounter(),
      mute: getMute(),
      madina: getMadina(),
      mobtahelen: getMobtahelen(),
      initPage: getInitPage(),
      audio: getAudio(),
      slider: getSlider(),
      view: getView(),
      prefSa: getPrefSa(),
      transVis: getTransVis(),
      transVis2: getTransVis2(),
      transVis3: getTransVis3(),
      mood: getMood(),
    );
  }
}

/// كائن يحمل جميع إعدادات التطبيق
class AppSettings {
  final int darkMode;
  final int allCounter;
  final int mute;
  final int madina;
  final int mobtahelen;
  final int initPage;
  final int audio;
  final double slider;
  final bool view;
  final int prefSa;
  final bool transVis;
  final bool transVis2;
  final bool transVis3;
  final int mood;

  AppSettings({
    required this.darkMode,
    required this.allCounter,
    required this.mute,
    required this.madina,
    required this.mobtahelen,
    required this.initPage,
    required this.audio,
    required this.slider,
    required this.view,
    required this.prefSa,
    required this.transVis,
    required this.transVis2,
    required this.transVis3,
    required this.mood,
  });
}
