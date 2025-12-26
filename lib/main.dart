import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:paqyat/QuranApi/constant.dart';
import 'package:paqyat/core/services/preferences_service.dart';
import 'package:paqyat/quran.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Firebase
  await Firebase.initializeApp();

  // تحميل الإعدادات باستخدام الخدمة الجديدة
  final prefs = await PreferencesService.getInstance();
  final settings = prefs.getAllSettings();

  runApp(MyApp(
    tdd: settings.darkMode,
    alc: settings.allCounter,
    voc: settings.mute,
    mahh: settings.madina,
    mobb: settings.mobtahelen,
    pagg: settings.initPage,
    audd: settings.audio,
    slide: settings.slider,
    vv: settings.view,
    aaa: settings.prefSa,
    tran: settings.transVis,
    tran2: settings.transVis2,
    tran3: settings.transVis3,
    mod: settings.mood,
  ));
}

class MyApp extends StatefulWidget {
  final int? tdd;
  final int? alc;
  final int? voc;
  final int? mahh;
  final int? mobb;
  final int? pagg;
  final int? audd;
  final int? aaa;
  final double? slide;
  final bool? vv;
  final bool? tran;
  final bool? tran2;
  final bool? tran3;
  final int? mod;

  const MyApp({
    super.key,
    required this.tdd,
    required this.alc,
    required this.voc,
    required this.mahh,
    required this.mobb,
    required this.pagg,
    required this.audd,
    required this.aaa,
    required this.slide,
    required this.vv,
    required this.tran,
    required this.tran2,
    required this.tran3,
    required this.mod,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'),
      ],
      home: Qrrr(
        tdd: widget.tdd,
        alc: widget.alc,
        voc: widget.voc,
        mahh: widget.mahh,
        mobb: widget.mobb,
        pagg: widget.pagg,
        audd: widget.audd,
        slide: widget.slide,
        vv: widget.vv,
        aaa: widget.aaa,
        tran: widget.tran,
        tran2: widget.tran2,
        tran3: widget.tran3,
        mod: widget.mod,
      ),
    );
  }
}
