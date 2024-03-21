// ignore_for_file: file_names

import 'package:adhan/adhan.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:paqyat/QuranApi/to_arabic_no_converter.dart';
import 'package:paqyat/quran.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalahT extends StatefulWidget {
  const SalahT({
    super.key,
  });

  @override
  State<SalahT> createState() => _SalahTState();
}

dynamic cl;
int paryint = 0;
String? gov = 'القاهرة';
final HijriCalendar _today = HijriCalendar.now();
Location location = Location();
LocationData? _currentPosition;
double? latitude, longitude;
final prayController = PageController();
final praysearch = TextEditingController();
hegryMonth(String month) {
  if (month == '1') {
    return 'مُحَرَّم';
  } else if (month == '2') {
    return 'صَفَر';
  } else if (month == '3') {
    return 'ربيع الأول';
  } else if (month == '4') {
    return 'ربيع الآخر';
  } else if (month == '5') {
    return 'جمادى الأولى';
  } else if (month == '6') {
    return 'جمادى الآخرة';
  } else if (month == '7') {
    return 'رجب';
  } else if (month == '8') {
    return 'شَعْبَان';
  } else if (month == '9') {
    return 'رمضان';
  } else if (month == '10') {
    return 'شَوَّال';
  } else if (month == '11') {
    return 'ذو القعدة';
  } else if (month == '12') {
    return 'ذو الحجة';
  }
}

List govves = [
  'القاهرة',
  'الجيزة',
  'الإسكندرية',
  'البحيرة',
  'القليوبية',
  'مرسى مطروح',
  'دمياط',
  'الدقهلية',
  'كفر الشيخ',
  'الغربية',
  'المنوفية',
  'الشرقية',
  'بورسعيد',
  'الإسماعيلية',
  'السويس',
  'شمال سيناء',
  'جنوب سيناء',
  'بني سويف',
  'الفيوم',
  'المنيا',
  'أسيوط',
  'سوهاج',
  'قنا',
  'الأقصر',
  'أسوان',
  'الوادي الجديد',
  'البحر الأحمر',
];
Map egoves = {
  'القاهرة': [
    'القاهرة',
    30.0444,
    31.2357,
    0,
  ],
  'الجيزة': [
    'الجيزة',
    30.0081,
    31.2109,
    0,
  ],
  'الإسكندرية': [
    'الإسكندرية',
    31.205753,
    29.924526,
    0,
  ],
  'البحيرة': [
    'البحيرة',
    30.4659,
    30.932,
    0,
  ],
  'القليوبية': [
    'القليوبية',
    30.1864,
    31.2144,
    0,
  ],
  'مرسى مطروح': [
    'مرسى مطروح',
    29.5899,
    26.1976,
    0,
  ],
  'دمياط': [
    'دمياط',
    31.4165,
    31.8133,
    0,
  ],
  'الدقهلية': [
    'الدقهلية',
    31.131,
    31.6561,
    0,
  ],
  'كفر الشيخ': [
    'كفر الشيخ',
    31.1108,
    30.9399,
    0,
  ],
  'الغربية': [
    'الغربية',
    30.7974,
    31.3663,
    0,
  ],
  'المنوفية': [
    'المنوفية',
    30.4706,
    31.1787,
    0,
  ],
  'الشرقية': [
    'الشرقية',
    30.7762,
    31.499,
    0,
  ],
  'بورسعيد': [
    'بورسعيد',
    31.2653,
    32.3019,
    0,
  ],
  'الإسماعيلية': [
    'الإسماعيلية',
    30.5977,
    32.2761,
    0,
  ],
  'السويس': [
    'السويس',
    30.0131,
    32.5319,
    0,
  ],
  'شمال سيناء': [
    'شمال سيناء',
    31.1297,
    33.797,
    0,
  ],
  'جنوب سيناء': [
    'جنوب سيناء',
    28.0435,
    34.4265,
    0,
  ],
  'بني سويف': [
    'بني سويف',
    29.0724,
    31.0923,
    0,
  ],
  'الفيوم': [
    'الفيوم',
    29.3094,
    30.8418,
    0,
  ],
  'المنيا': [
    'المنيا',
    28.1097,
    30.7503,
    0,
  ],
  'أسيوط': [
    'أسيوط',
    27.1818,
    31.1837,
    0,
  ],
  'سوهاج': [
    'سوهاج',
    26.5502,
    31.6948,
    0,
  ],
  'قنا': [
    'قنا',
    26.1555,
    32.7167,
    0,
  ],
  'الأقصر': [
    'الأقصر',
    25.6872,
    32.6396,
    0,
  ],
  'أسوان': [
    'أسوان',
    24.0875,
    32.8989,
    0,
  ],
  'الوادي الجديد': [
    'الوادي الجديد',
    25.1222,
    28.8784,
    0,
  ],
  'البحر الأحمر': [
    'البحر الأحمر',
    27.2578,
    33.8119,
    0,
  ],
};

getLoc() async {
  SharedPreferences latit = await SharedPreferences.getInstance();
  SharedPreferences longit = await SharedPreferences.getInstance();
  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = !await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  _currentPosition = await location.getLocation();
  latitude = _currentPosition!.latitude;
  longitude = _currentPosition!.longitude;
  latit.setDouble('latit', latitude!);
  longit.setDouble('longit', longitude!);
}

class _SalahTState extends State<SalahT> {
  @override
  void initState() {
    super.initState();
    getLoc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: SizedBox(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: backColor,
                    image: const DecorationImage(
                      image: AssetImage("assets/images/azkarback.png"),
                      fit: BoxFit.fitHeight,
                      opacity: 0.6,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: FadeInDown(
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          'مواقيت الصلاة',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'BigVesta-Arabic-Regular',
                            fontSize: MediaQuery.of(context).size.width / 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: quranback?.withOpacity(0.3),
                  ),
                )
              ],
            ),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    paryint == 0
                        ? FadeInUp(
                            duration: const Duration(
                              milliseconds: 500,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 4,
                                right: 4,
                                left: 4,
                              ),
                              child: Card(
                                color: itemColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                Future.delayed(
                                                  const Duration(
                                                      milliseconds: 150),
                                                  () {
                                                    sKey.currentState
                                                        ?.openDrawer();
                                                  },
                                                );
                                              });
                                            },
                                            child: Container(
                                              color: itemColor,
                                              padding: const EdgeInsets.all(8),
                                              child: const Icon(
                                                Icons.more_vert,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                prayController.jumpToPage(0);
                                              });
                                            },
                                            child: Container(
                                              color: itemColor,
                                              padding: const EdgeInsets.all(8),
                                              child: const Icon(
                                                Icons.location_on,
                                                size: 24,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                paryint = 1;
                                                maxSug2 = 5;
                                              });
                                            },
                                            child: Container(
                                              color: itemColor,
                                              padding: const EdgeInsets.all(8),
                                              child: const Icon(
                                                Icons.search,
                                                size: 28,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        : FadeInRight(
                            duration: const Duration(
                              milliseconds: 400,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 4,
                                right: 4,
                                left: 4,
                              ),
                              child: Card(
                                color: itemColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (maxSug2 == 5) {
                                              maxSug2 = 0;
                                              Future.delayed(
                                                const Duration(
                                                    milliseconds: 400),
                                                () {
                                                  setState(() {
                                                    paryint = 0;
                                                  });
                                                },
                                              );
                                            } else {
                                              setState(() {
                                                paryint = 0;
                                              });
                                            }
                                          });
                                        },
                                        child: Container(
                                          color: itemColor,
                                          padding: const EdgeInsets.all(8),
                                          child: const Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Card(
                                          color: backColor,
                                          child: SearchField(
                                              searchStyle: const TextStyle(
                                                fontFamily: 'KFGQPC',
                                                wordSpacing: 2,
                                                fontSize: 14,
                                                height: 1.33,
                                                color: Colors.white,
                                              ),
                                              hint: 'اسم المحافظة',
                                              searchInputDecoration:
                                                  InputDecoration(
                                                border: InputBorder.none,
                                                prefixIcon: const Icon(
                                                  Icons.search,
                                                  color: Colors.white,
                                                  size: 22,
                                                ),
                                                suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      praysearch.clear();
                                                    });
                                                  },
                                                  child: Container(
                                                    color: backColor,
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Icon(
                                                      Icons.clear,
                                                      color: Colors.white
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                ),
                                                hintStyle: TextStyle(
                                                  fontFamily: 'KFGQPC',
                                                  wordSpacing: 2,
                                                  fontSize: 18,
                                                  height: 1.2,
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                              itemHeight: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  22,
                                              maxSuggestionsInViewPort: maxSug2,
                                              controller: praysearch,
                                              inputType: TextInputType.name,
                                              suggestionState:
                                                  Suggestion.expand,
                                              suggestions: govves
                                                  .map((e) =>
                                                      SearchFieldListItem(
                                                        e.toString(),
                                                        item: e,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                right: 16,
                                                              ),
                                                              child: Text(
                                                                e,
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  height: 1.33,
                                                                  fontFamily:
                                                                      'KFGQPC',
                                                                  wordSpacing:
                                                                      2,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ))
                                                  .toList(),
                                              onSubmit: (value) {
                                                for (int pray = 0;
                                                    pray < govves.length;
                                                    pray++) {
                                                  if (value == govves[pray]) {
                                                    prayController
                                                        .jumpToPage(pray + 1);
                                                  }
                                                }
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                    FadeInUp(
                      duration: const Duration(
                        milliseconds: 500,
                      ),
                      child: Card(
                        color: itemColor,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Card(
                                shape: const BeveledRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.zero)),
                                color: Colors.white.withOpacity(0.2),
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text.rich(
                                    TextSpan(
                                        text: _today
                                            .toFormat('dd ')
                                            .toString()
                                            .toArabicNumbers,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'BigVesta-Arabic-Regular',
                                          wordSpacing: 2,
                                          height: 0.4,
                                          color: Colors.yellow,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${hegryMonth(_today.toFormat('mm').toString()).toString()} ',
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontFamily:
                                                  'BigVesta-Arabic-Regular',
                                              wordSpacing: 2,
                                              height: 0.3,
                                              color: Colors.yellow,
                                            ),
                                          ),
                                          TextSpan(
                                            text: _today
                                                .toFormat('yyyy')
                                                .toString()
                                                .toArabicNumbers,
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontFamily:
                                                  'BigVesta-Arabic-Regular',
                                              wordSpacing: 2,
                                              height: 0.4,
                                              color: Colors.yellow,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Card(
                                shape: const BeveledRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.zero)),
                                color: Colors.white.withOpacity(0.2),
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text.rich(
                                    TextSpan(
                                        text: DateFormat('dd ')
                                            .format(DateTime.now())
                                            .toArabicNumbers,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'BigVesta-Arabic-Regular',
                                          wordSpacing: 2,
                                          height: 0.4,
                                          color: Colors.yellow,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: ' /  ',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily:
                                                  'BigVesta-Arabic-Regular',
                                              wordSpacing: 2,
                                              height: 0.3,
                                              color: Colors.yellow,
                                            ),
                                          ),
                                          TextSpan(
                                            text: DateFormat('M ')
                                                .format(DateTime.now())
                                                .toArabicNumbers,
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontFamily:
                                                  'BigVesta-Arabic-Regular',
                                              wordSpacing: 2,
                                              height: 0.4,
                                              color: Colors.yellow,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: ' /  ',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily:
                                                  'BigVesta-Arabic-Regular',
                                              wordSpacing: 2,
                                              height: 0.3,
                                              color: Colors.yellow,
                                            ),
                                          ),
                                          TextSpan(
                                            text: DateFormat('yyyy')
                                                .format(DateTime.now())
                                                .toArabicNumbers,
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontFamily:
                                                  'BigVesta-Arabic-Regular',
                                              wordSpacing: 2,
                                              height: 0.4,
                                              color: Colors.yellow,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      height: 428,
                      child: Center(
                        child: PageView(
                          physics: const BouncingScrollPhysics(),
                          controller: prayController,
                          children: [
                            //prayTimes in your location
                            FutureBuilder(
                              future: getLoc(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const CupertinoActivityIndicator(
                                            color: Colors.white,
                                            radius: 16,
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            'جاري تحديد موقعك الحالي',
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  36,
                                              fontFamily: 'KFGQPC',
                                              wordSpacing: 2,
                                              height: 1,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                final myCoordinates =
                                    Coordinates(latitude!, longitude!);
                                final params =
                                    CalculationMethod.egyptian.getParameters();
                                params.madhab = Madhab.shafi;
                                final prayerTimes =
                                    PrayerTimes.today(myCoordinates, params);
                                return FadeInUp(
                                  duration: const Duration(
                                    milliseconds: 500,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //prayTimes in your location
                                      newMethodCairoTimes(
                                          context, prayerTimes, 'موقعك الحالي'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            //prayTimes in other governorates
                            for (int oodd = 0; oodd < govves.length; oodd++)
                              newMethodMainPrayerWidget(
                                egoves[govves[oodd]][1],
                                egoves[govves[oodd]][2],
                                govves[oodd],
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //MainPrayerWidget
  FutureBuilder<Object?> newMethodMainPrayerWidget(
    double latitude,
    double longitude,
    String name,
  ) {
    return FutureBuilder(
      builder: (context, snapshot) {
        final cairoCoordinates = Coordinates(
          latitude,
          longitude,
        );
        final cParams = CalculationMethod.egyptian.getParameters();
        cParams.madhab = Madhab.shafi;
        final cairoPrayerTimes = PrayerTimes.today(cairoCoordinates, cParams);
        return FadeInUp(
          duration: const Duration(
            milliseconds: 500,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //prayTimes in your location
              newMethodCairoTimes(
                context,
                cairoPrayerTimes,
                name,
              ),
            ],
          ),
        );
      },
      future: null,
    );
  }

  //Prayer at selected
  Container newMethodCairoTimes(
    BuildContext context,
    PrayerTimes cairoPrayerTimes,
    String gover,
  ) {
    return Container(
      height: 428,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: itemColor,
        image: const DecorationImage(
          image: AssetImage('assets/images/decor05.png'),
          opacity: 0.02,
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              bottom: 16,
            ),
            child: Text.rich(
              TextSpan(
                  text: 'مواقيت الصلاة في ',
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'BigVesta-Arabic-Regular',
                    height: 1,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: gover,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'BigVesta-Arabic-Regular',
                        height: 1,
                        color: Colors.yellow,
                      ),
                    )
                  ]),
            ),
          ),
          newMethod003('الفجر', cairoPrayerTimes.fajr),
          newMethod003('الشروق', cairoPrayerTimes.sunrise),
          newMethod003('الظهر', cairoPrayerTimes.dhuhr),
          newMethod003('العصر', cairoPrayerTimes.asr),
          newMethod003('المغرب', cairoPrayerTimes.maghrib),
          newMethod003('العشاء', cairoPrayerTimes.isha),
        ],
      ),
    );
  }

  //Get times
  Card newMethod003(String prayName, DateTime fm) {
    return Card(
      color: backColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
                top: 8,
                bottom: 8,
              ),
              child: Text(
                prayName,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'BigVesta-Arabic-Regular',
                  wordSpacing: 2,
                  height: 1,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 8,
                bottom: 8,
              ),
              child: Text(
                '( ${DateFormat.jm().format(fm)} )',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'BigVesta-Arabic-Regular',
                  wordSpacing: 2,
                  height: 1,
                  color: Colors.yellow,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
