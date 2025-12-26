import 'package:audioplayers/audioplayers.dart';

/// خدمة إدارة الصوت
class AudioService {
  static AudioService? _instance;
  AudioPlayer? _player;
  AudioPlayer? _effectPlayer;

  AudioService._();

  /// الحصول على instance واحد من الخدمة (Singleton)
  static AudioService getInstance() {
    _instance ??= AudioService._();
    return _instance!;
  }

  /// الحصول على مشغل الصوت الرئيسي
  AudioPlayer get player {
    _player ??= AudioPlayer();
    return _player!;
  }

  /// الحصول على مشغل المؤثرات الصوتية
  AudioPlayer get effectPlayer {
    _effectPlayer ??= AudioPlayer();
    return _effectPlayer!;
  }

  /// تشغيل صوت من رابط
  Future<void> playFromUrl(String url) async {
    await player.play(UrlSource(url));
  }

  /// تشغيل صوت من الـ assets
  Future<void> playFromAsset(String path) async {
    await player.play(AssetSource(path));
  }

  /// تشغيل مؤثر صوتي
  Future<void> playEffect(String path) async {
    await effectPlayer.play(AssetSource(path));
  }

  /// إيقاف الصوت مؤقتاً
  Future<void> pause() async {
    await player.pause();
  }

  /// استئناف الصوت
  Future<void> resume() async {
    await player.resume();
  }

  /// إيقاف الصوت
  Future<void> stop() async {
    await player.stop();
  }

  /// التحكم في الموضع
  Future<void> seek(Duration position) async {
    await player.seek(position);
  }

  /// الحصول على مدة الصوت
  Future<Duration?> getDuration() async {
    return await player.getDuration();
  }

  /// الاستماع لتغيرات الموضع
  Stream<Duration> get onPositionChanged => player.onPositionChanged;

  /// الاستماع لتغيرات الحالة
  Stream<PlayerState> get onPlayerStateChanged => player.onPlayerStateChanged;

  /// الاستماع لانتهاء الصوت
  Stream<void> get onPlayerComplete => player.onPlayerComplete;

  /// التخلص من المشغلات
  void dispose() {
    _player?.dispose();
    _effectPlayer?.dispose();
    _player = null;
    _effectPlayer = null;
  }
}
