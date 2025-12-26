/// ملف التصدير الرئيسي للتطبيق
/// يجمع جميع الملفات المشتركة في مكان واحد لسهولة الاستيراد
library paqyat;

export 'QuranApi/arabic_sura_number.dart';
export 'QuranApi/constant.dart';
// ============ Quran Offline (القرآن بدون نت) ============
export 'QuranApi/index.dart';
export 'QuranApi/settings.dart';
export 'QuranApi/surah_builder.dart';
export 'QuranApi/to_arabic_no_converter.dart';
// ============ Core ============
// Constants
export 'core/constants/app_constants.dart';
// Services
export 'core/services/audio_service.dart';
export 'core/services/preferences_service.dart';
// Theme
export 'core/theme/app_colors.dart';
// Utils
export 'core/utils/helpers.dart';
// ============ Data ============
export 'data/azkar_data.dart';
// ============ Models ============
export 'models/reciter_model.dart';
export 'models/zikr_model.dart';
export 'pages/Masaa.dart';
export 'pages/Praytimes.dart';
export 'pages/Sabah.dart';
export 'pages/Sebha.dart';
export 'pages/azkar.dart' hide size, iColor;
export 'pages/muslimtube.dart' hide size, iColor;
// ============ Pages ============
export 'pages/unified_azkar.dart';
// ============ Main ============
export 'quran.dart';
// ============ Widgets ============
export 'widgets/common_widgets.dart';
export 'widgets/zikr_widgets.dart';
