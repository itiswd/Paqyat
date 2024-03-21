// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:paqyat/QuranApi/arabic_sura_number.dart';
import 'package:paqyat/QuranApi/settings.dart';
import 'package:paqyat/QuranApi/to_arabic_no_converter.dart';
import 'package:paqyat/quran.dart';

import 'constant.dart';
import 'surah_builder.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              Brightness.light // Change this to your desired color
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
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FadeInUp(
          duration: const Duration(
            milliseconds: 500,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 4,
            ),
            child: FloatingActionButton(
              tooltip: 'الذهاب الى الإشارة المرجعية',
              backgroundColor: Colors.transparent,
              elevation: 0,
              highlightElevation: 0,
              onPressed: () async {
                fabIsClicked = true;
                if (await readBookmark() == true) {
                  setState(
                    () {
                      view = true;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SurahBuilder(
                            arabic: quran[0],
                            sura: bookmarkedSura - 1,
                            suraName: arabicName[bookmarkedSura - 1]['name'],
                            ayah: bookmarkedAyah,
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: CircleAvatar(
                  backgroundColor: itemColor?.withOpacity(0.4),
                  radius: 20,
                  child: const Icon(
                    Icons.bookmark,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          actions: [
            FadeInRight(
              duration: const Duration(milliseconds: 500),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Settings()));
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 12,
                      ),
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          leading: const SizedBox(),
          leadingWidth: 0,
          toolbarHeight: 75,
          title: FadeInRight(
            duration: const Duration(milliseconds: 500),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      final paly1 = AudioPlayer();
                      if (volume == 0) {
                        paly1.play(AssetSource("sounds/turnpage-99756.mp3"));
                      }
                      sKey.currentState?.openDrawer();
                    });
                  },
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "القرآن الكريم",
                  style: TextStyle(
                    fontFamily: 'BigVesta-Arabic-Regular',
                    fontSize: MediaQuery.of(context).size.width / 14,
                    wordSpacing: 2,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: itemColor,
        ),
        body: FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: Container(
            margin: const EdgeInsets.only(
              bottom: 28,
            ),
            color: const Color.fromARGB(255, 252, 252, 252),
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  75 -
                  MediaQuery.of(context).padding.top -
                  80,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  for (int i = 0; i < 114; i++)
                    Container(
                      color: i % 2 == 0
                          ? const Color.fromARGB(255, 252, 252, 252)
                          : const Color.fromARGB(255, 245, 244, 244),
                      child: TextButton(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  arabicName[i]['name'],
                                  style: const TextStyle(
                                    fontSize: 28,
                                    height: 1.33,
                                    wordSpacing: 4,
                                    color: Colors.black,
                                    fontFamily: 'KFGQPC',
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${arabicName[i]['type']} -',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        height: 1,
                                        letterSpacing: 0,
                                        wordSpacing: 2,
                                        color:
                                            Color.fromARGB(255, 125, 123, 123),
                                        fontFamily: 'KFGQPC',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      noOfVerses[i].toArabicNumbers,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        height: 0.5,
                                        color:
                                            Color.fromARGB(255, 125, 123, 123),
                                        fontFamily: 'quran',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      noOfVerses[i] <= 10 ? 'آيات' : 'آية',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        height: 1,
                                        letterSpacing: 0,
                                        wordSpacing: 2,
                                        color:
                                            Color.fromARGB(255, 125, 123, 123),
                                        fontFamily: 'KFGQPC',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [],
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            const SizedBox(
                              width: 5,
                            ),
                            ArabicSuraNumber(i: i),
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            fabIsClicked = false;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SurahBuilder(
                                        arabic: quran[0],
                                        sura: i,
                                        suraName: arabicName[i]['name'],
                                        ayah: 0,
                                      )),
                            );
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
