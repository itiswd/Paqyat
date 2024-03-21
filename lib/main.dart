// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:paqyat/QuranApi/constant.dart';
import 'package:paqyat/quran.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref1 = await SharedPreferences.getInstance();
  SharedPreferences pref3 = await SharedPreferences.getInstance();
  SharedPreferences pref4 = await SharedPreferences.getInstance();
  SharedPreferences pref9 = await SharedPreferences.getInstance();
  SharedPreferences pref10 = await SharedPreferences.getInstance();
  SharedPreferences prefinitpage = await SharedPreferences.getInstance();
  SharedPreferences prefAudio = await SharedPreferences.getInstance();
  SharedPreferences presview = await SharedPreferences.getInstance();
  SharedPreferences prefsa = await SharedPreferences.getInstance();
  SharedPreferences transpref = await SharedPreferences.getInstance();
  SharedPreferences trans2pref = await SharedPreferences.getInstance();
  SharedPreferences trans3pref = await SharedPreferences.getInstance();
  SharedPreferences moodpref = await SharedPreferences.getInstance();
  final tdd = pref1.getInt("Dark") ?? 0;
  final alc = pref3.getInt("allcounter") ?? 0;
  final voc = pref4.getInt("Mute") ?? 0;
  final mahh = pref9.getInt("madina") ?? 0;
  final mobb = pref10.getInt("mobb") ?? 0;
  final pagg = prefinitpage.getInt("initpage") ?? 0;
  final audd = prefAudio.getInt("audio") ?? 0;
  final slide = prefAudio.getDouble("slider") ?? 0;
  final vv = presview.getBool("view") ?? false;
  final aaa = prefsa.getInt("prefsa") ?? 0;
  final tran = transpref.getBool("transvis") ?? false;
  final tran2 = trans2pref.getBool("transvis2") ?? false;
  final tran3 = trans3pref.getBool("transvis3") ?? false;
  final mod = moodpref.getInt('moody') ?? 0;
  runApp(MyApp(
    tdd: tdd,
    alc: alc,
    voc: voc,
    mahh: mahh,
    mobb: mobb,
    pagg: pagg,
    audd: audd,
    slide: slide,
    vv: vv,
    aaa: aaa,
    tran: tran,
    tran2: tran2,
    tran3: tran3,
    mod: mod,
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
  get ayah => null;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getSettings();
    });
    super.initState();
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
