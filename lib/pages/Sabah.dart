// ignore_for_file: file_names
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paqyat/QuranApi/to_arabic_no_converter.dart';
import 'package:paqyat/quran.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sabah extends StatefulWidget {
  const Sabah({super.key});

  @override
  State<Sabah> createState() => _SabahState();
}

class _SabahState extends State<Sabah> {
  var size = 'a';
  dynamic iColor = Colors.white;
  dynamic tSize = 20.0;
  PageController pcsab = PageController(initialPage: initpagesab);
  Map asab = {
    'asab': [
      {
        "count": ' مرة واحدة ',
        "int": 1,
        "sabvar": 0,
        "description":
            "من قالها حين يصبح أجير من الجن حتى يمسى ومن قالها حين يمسى أجير من الجن حتى يصبح.",
        "reference": "[آية الكرسى - البقرة 255].",
        "zekr":
            "اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ لاَ تَأْخُذُهُ سِنَةٌ وَلاَ نَوْمٌ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الأَرْضِ مَن ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلاَّ بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلاَ يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلاَّ بِمَا شَاء وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالأَرْضَ وَلاَ يَؤُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ.",
        "path": "assets/azkaraudio/zekr (1).mp3",
      },
      {
        "count": ' ثلاث مرات ',
        "int": 3,
        "sabvar": 0,
        "description":
            "من قالها حين يصبح وحين يمسى كفته من كل شىء (الإخلاص والمعوذتين).",
        "reference": "سورة الإخلاص",
        "zekr":
            "قُلْ هُوَ ٱللَّهُ أَحَدٌ، ٱللَّهُ ٱلصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُۥ كُفُوًا أَحَدٌۢ.",
        "path": "assets/azkaraudio/zekr (2).mp3",
      },
      {
        "count": ' ثلاث مرات ',
        "int": 3,
        "sabvar": 0,
        "description":
            "من قالها حين يصبح وحين يمسى كفته من كل شىء (الإخلاص والمعوذتين).",
        "reference": "سورة الفلق",
        "zekr":
            "قُلْ أَعُوذُ بِرَبِّ ٱلْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ ٱلنَّفَّٰثَٰتِ فِى ٱلْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ.",
        "path": "assets/azkaraudio/zekr (3).mp3",
      },
      {
        "count": ' ثلاث مرات ',
        "int": 3,
        "sabvar": 0,
        "description":
            "من قالها حين يصبح وحين يمسى كفته من كل شىء (الإخلاص والمعوذتين).",
        "reference": "سورة الناس",
        "zekr":
            "قُلْ أَعُوذُ بِرَبِّ ٱلنَّاسِ، مَلِكِ ٱلنَّاسِ، إِلَٰهِ ٱلنَّاسِ، مِن شَرِّ ٱلْوَسْوَاسِ ٱلْخَنَّاسِ، ٱلَّذِى يُوَسْوِسُ فِى صُدُورِ ٱلنَّاسِ، مِنَ ٱلْجِنَّةِ وَٱلنَّاسِ.",
        "path": "assets/azkaraudio/zekr (4).mp3",
      },
      {
        "count": ' مرة واحدة ',
        "int": 1,
        "sabvar": 0,
        "description": "",
        "reference": "صحيح مسلم",
        "zekr":
            "أَصْـبَحْنا وَأَصْـبَحَ المُـلْكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذا اليوم وَخَـيرَ ما بَعْـدَه ، وَأَعـوذُ بِكَ مِنْ شَـرِّ ما في هـذا اليوم وَشَرِّ ما بَعْـدَه، رَبِّ أَعـوذُبِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُ بِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر.",
        "path": "assets/azkaraudio/zekr (12).mp3",
      },
      {
        "count": ' مرة واحدة ',
        "int": 1,
        "sabvar": 0,
        "description":
            "من قالها موقنا بها حين يمسى ومات من ليلته دخل الجنة وكذلك حين يصبح.",
        "reference": "صحيح البخاري",
        "zekr":
            "اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ .",
        "path": "assets/azkaraudio/zekr (5).mp3",
      },
      {
        "count": ' ثلاث مرات ',
        "int": 3,
        "sabvar": 0,
        "description":
            "من قالها حين يصبح وحين يمسى كان حقا على الله أن يرضيه يوم القيامة.",
        "reference": "الإمام أحمد",
        "zekr":
            "رَضيـتُ بِاللهِ رَبَّـاً وَبِالإسْلامِ ديـناً وَبِمُحَـمَّدٍ صلى الله عليه وسلم نَبِيّـاً.",
        "path": "assets/azkaraudio/zekr (16).mp3",
      },
      {
        "count": ' اربع مرات ',
        "int": 4,
        "sabvar": 0,
        "description": "من قالها أعتقه الله من النار.",
        "reference": "سنن أبي داود",
        "zekr":
            "اللّهُـمَّ إِنِّـي أَصْبَـحْتُ أُشْـهِدُك ، وَأُشْـهِدُ حَمَلَـةَ عَـرْشِـك ، وَمَلَائِكَتَكَ ، وَجَمـيعَ خَلْـقِك ، أَنَّـكَ أَنْـتَ اللهُ لا إلهَ إلاّ أَنْـتَ وَحْـدَكَ لا شَريكَ لَـك ، وَأَنَّ ُ مُحَمّـداً عَبْـدُكَ وَرَسـولُـك.",
        "path": "assets/azkaraudio/zekr (7).mp3",
      },
      {
        "count": ' مرة واحدة ',
        "int": 1,
        "sabvar": 0,
        "description": "من قالها حين يصبح أدى شكر يومه.",
        "reference": "سنن أبي داود",
        "zekr":
            "اللّهُـمَّ ما أَصْبَـَحَ بي مِـنْ نِعْـمَةٍ أَو بِأَحَـدٍ مِـنْ خَلْـقِك ، فَمِـنْكَ وَحْـدَكَ لا شريكَ لَـك ، فَلَـكَ الْحَمْـدُ وَلَـكَ الشُّكْـر.",
        "path": "assets/azkaraudio/zekr (9).mp3",
      },
      {
        "count": ' سبع مرات ',
        "int": 7,
        "sabvar": 0,
        "description": "من قالها كفاه الله ما أهمه من أمر الدنيا والأخرة.",
        "reference": "ابن السني",
        "zekr":
            "حَسْبِـيَ اللّهُ لا إلهَ إلاّ هُوَ عَلَـيهِ تَوَكَّـلتُ وَهُوَ رَبُّ العَرْشِ العَظـيم.",
        "path": "assets/azkaraudio/zekr (11).mp3",
      },
      {
        "count": ' ثلاث مرات ',
        "int": 3,
        "sabvar": 0,
        "description": "لم يضره من الله شيء.",
        "reference": "سنن ابن ماجه",
        "zekr":
            "بِسـمِ اللهِ الذي لا يَضُـرُّ مَعَ اسمِـهِ شَيءٌ في الأرْضِ وَلا في السّمـاءِ وَهـوَ السّمـيعُ العَلـيم.",
        "path": "assets/azkaraudio/zekr (14).mp3",
      },
      {
        "count": ' مرة واحدة ',
        "int": 1,
        "sabvar": 0,
        "description": "",
        "reference": "سنن الترمذي",
        "zekr":
            "اللّهُـمَّ بِكَ أَصْـبَحْنا وَبِكَ أَمْسَـينا ، وَبِكَ نَحْـيا وَبِكَ نَمُـوتُ وَإِلَـيْكَ النُّـشُور.",
        "path": "assets/azkaraudio/zekr (6).mp3",
      },
      {
        "count": ' مرة واحدة ',
        "int": 1,
        "sabvar": 0,
        "description": "",
        "reference": "الإمام أحمد",
        "zekr":
            "أَصْبَـحْـنا عَلَى فِطْرَةِ الإسْلاَمِ، وَعَلَى كَلِمَةِ الإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِينَا إبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ.",
        "path": "assets/azkaraudio/zekr (18).mp3",
      },
      {
        "count": ' ثلاث مرات ',
        "int": 3,
        "sabvar": 0,
        "description": "",
        "reference": "صحيح مسلم",
        "zekr":
            "سُبْحـانَ اللهِ وَبِحَمْـدِهِ عَدَدَ خَلْـقِه ، وَرِضـا نَفْسِـه ، وَزِنَـةَ عَـرْشِـه ، وَمِـدادَ كَلِمـاتِـه.",
        "path": "assets/azkaraudio/zekr (19).mp3",
      },
      {
        "count": ' ثلاث مرات ',
        "int": 3,
        "sabvar": 0,
        "description": "",
        "reference": "الإمام أحمد",
        "zekr":
            "اللّهُـمَّ عافِـني في بَدَنـي ، اللّهُـمَّ عافِـني في سَمْـعي ، اللّهُـمَّ عافِـني في بَصَـري ، لا إلهَ إلاّ أَنْـتَ ، اللّهُـمَّ إِنّـي أَعـوذُ بِكَ مِنَ الْكُـفر ، وَالفَـقْر ، وَأَعـوذُ بِكَ مِنْ عَذابِ القَـبْر ، لا إلهَ إلاّ أَنْـتَ.",
        "path": "assets/azkaraudio/zekr (10).mp3",
      },
      {
        "count": ' مرة واحدة ',
        "int": 1,
        "sabvar": 0,
        "description": "",
        "reference": "سنن ابن ماجه",
        "zekr":
            "اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في الدُّنْـيا وَالآخِـرَة ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في ديني وَدُنْـيايَ وَأهْـلي وَمالـي ، اللّهُـمَّ اسْتُـرْ عـوْراتي وَآمِـنْ رَوْعاتـي ، اللّهُـمَّ احْفَظْـني مِن بَـينِ يَدَيَّ وَمِن خَلْفـي وَعَن يَمـيني وَعَن شِمـالي ، وَمِن فَوْقـي ، وَأَعـوذُ بِعَظَمَـتِكَ أَن أُغْـتالَ مِن تَحْتـي.",
        "path": "assets/azkaraudio/zekr (13).mp3",
      },
      {
        "count": ' ثلاث مرات ',
        "int": 3,
        "sabvar": 0,
        "description": "",
        "reference": "(المستدرك على الصحيحين)الحاكم",
        "zekr":
            "يَا حَيُّ يَا قيُّومُ بِرَحْمَتِكَ أسْتَغِيثُ أصْلِحْ لِي شَأنِي كُلَّهُ وَلاَ تَكِلْنِي إلَى نَفْسِي طَـرْفَةَ عَيْنٍ.",
        "path": "assets/azkaraudio/zekr (8).mp3",
      },
      {
        "count": ' مرة واحدة ',
        "int": 1,
        "sabvar": 0,
        "description": "",
        "reference": "سنن أبي داود",
        "zekr":
            "أَصْبَـحْـنا وَأَصْبَـحْ المُـلكُ للهِ رَبِّ العـالَمـين ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ خَـيْرَ هـذا الـيَوْم ، فَـتْحَهُ ، وَنَصْـرَهُ ، وَنـورَهُ وَبَـرَكَتَـهُ ، وَهُـداهُ ، وَأَعـوذُ بِـكَ مِـنْ شَـرِّ ما فـيهِ وَشَـرِّ ما بَعْـدَه.",
        "path": "assets/azkaraudio/zekr (21).mp3",
      },
      {
        "count": ' مرة واحدة ',
        "int": 1,
        "sabvar": 0,
        "description": "",
        "reference": "سنن الترمذي",
        "zekr":
            "اللّهُـمَّ عالِـمَ الغَـيْبِ وَالشّـهادَةِ فاطِـرَ السّماواتِ وَالأرْضِ رَبَّ كـلِّ شَـيءٍ وَمَليـكَه ، أَشْهَـدُ أَنْ لا إِلـهَ إِلاّ أَنْت ، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي وَمِن شَـرِّ الشَّيْـطانِ وَشِرْكِهِ ، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم.",
        "path": "",
      },
      {
        "count": ' ثلاث مرات ',
        "int": 3,
        "sabvar": 0,
        "description": "",
        "reference": "",
        "zekr":
            "أَعـوذُ بِكَلِمـاتِ اللّهِ التّـامّـاتِ مِنْ شَـرِّ ما خَلَـق.",
        "path": "",
      },
      {
        "count": ' عشر مرات ',
        "int": 10,
        "sabvar": 0,
        "description":
            "من صلى على حين يصبح وحين يمسى ادركته شفاعتى يوم القيامة.",
        "reference": "الطبراني",
        "zekr": "اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ على نَبِيِّنَا مُحمَّد.",
        "path": "assets/azkaraudio/zekr (15).mp3",
      },
      {
        "count": ' ثلاث مرات ',
        "int": 3,
        "sabvar": 0,
        "description": "",
        "reference": "",
        "zekr":
            "اللَّهُمَّ إِنَّا نَعُوذُ بِكَ مِنْ أَنْ نُشْرِكَ بِكَ شَيْئًا نَعْلَمُهُ ، وَنَسْتَغْفِرُكَ لِمَا لَا نَعْلَمُهُ.",
        "path": "",
      },
      {
        "count": ' ثلاث مرات ',
        "int": 3,
        "sabvar": 0,
        "description": "",
        "reference": "سنن أبي داود",
        "zekr":
            "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ الْهَمِّ وَالْحَزَنِ، وَأَعُوذُ بِكَ مِنْ الْعَجْزِ وَالْكَسَلِ، وَأَعُوذُ بِكَ مِنْ الْجُبْنِ وَالْبُخْلِ، وَأَعُوذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ، وَقَهْرِ الرِّجَالِ.",
        "path": "",
      },
      {
        "count": ' ثلاث مرات ',
        "int": 3,
        "sabvar": 0,
        "description": "",
        "reference": "",
        "zekr":
            "أسْتَغْفِرُ اللهَ العَظِيمَ الَّذِي لاَ إلَهَ إلاَّ هُوَ، الحَيُّ القَيُّومُ، وَأتُوبُ إلَيهِ.",
        "path": "",
      },
      {
        "count": ' ثلاث مرات ',
        "int": 3,
        "sabvar": 0,
        "description": "",
        "reference": "",
        "zekr":
            "يَا رَبِّ , لَكَ الْحَمْدُ كَمَا يَنْبَغِي لِجَلَالِ وَجْهِكَ , وَلِعَظِيمِ سُلْطَانِكَ.",
        "path": "",
      },
      {
        "count": ' مرة واحدة ',
        "int": 1,
        "sabvar": 0,
        "description": "",
        "reference": "سنن ابن ماجه",
        "zekr":
            "اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا طَيِّبًا، وَعَمَلًا مُتَقَبَّلًا.",
        "path": "assets/azkaraudio/zekr (20).mp3",
      },
      {
        "count": ' مرة واحدة ',
        "int": 1,
        "sabvar": 0,
        "description": "ذكر طيب.",
        "reference": "",
        "zekr":
            "اللَّهُمَّ أَنْتَ رَبِّي لا إِلَهَ إِلا أَنْتَ ، عَلَيْكَ تَوَكَّلْتُ ، وَأَنْتَ رَبُّ الْعَرْشِ الْعَظِيمِ , مَا شَاءَ اللَّهُ كَانَ ، وَمَا لَمْ يَشَأْ لَمْ يَكُنْ ، وَلا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ الْعَلِيِّ الْعَظِيمِ , أَعْلَمُ أَنَّ اللَّهَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ ، وَأَنَّ اللَّهَ قَدْ أَحَاطَ بِكُلِّ شَيْءٍ عِلْمًا , اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي ، وَمِنْ شَرِّ كُلِّ دَابَّةٍ أَنْتَ آخِذٌ بِنَاصِيَتِهَا ، إِنَّ رَبِّي عَلَى صِرَاطٍ مُسْتَقِيمٍ.",
        "path": "",
      },
      {
        "count": 'مائة مرة',
        "int": 100,
        "sabvar": 0,
        "description":
            "من قالها 100 مرة في يوم كانت له عدل عشر رقاب، وكتبت له مئة حسنة، ومحيت عنه مئة سيئة، وكانت له حرزا من الشيطان في يومه ذلك حتى يمسي ولم يأتي أحد بأفضل مما جاء به إلا احد عمل أكثر من ذلك",
        "reference": "البخاري و مسلم",
        "zekr":
            "لَا إلَه إلّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءِ قَدِيرِ.",
        "path": "assets/azkaraudio/zekr (22).mp3",
      },
      {
        "count": 'مائة مرة',
        "int": 100,
        "sabvar": 0,
        "description":
            "حُطَّتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ. لَمْ يَأْتِ أَحَدٌ يَوْمَ الْقِيَامَةِ بِأَفْضَلَ مِمَّا جَاءَ بِهِ إِلَّا أَحَدٌ قَالَ مِثْلَ مَا قَالَ أَوْ زَادَ عَلَيْهِ.",
        "reference": "صحيح مسلم",
        "zekr": "سُبْحـانَ اللهِ وَبِحَمْـدِهِ.",
        "path": "assets/azkaraudio/zekr (17).mp3",
      },
      {
        "count": 'مائة مرة',
        "int": 100,
        "sabvar": 0,
        "description":
            "مائة حسنة، ومُحيت عنه مائة سيئة، وكانت له حرزاً من الشيطان حتى يمسى.",
        "reference": "صحيح البخاري",
        "zekr": "أسْتَغْفِرُ اللهَ وَأتُوبُ إلَيْهِ",
        "path": "assets/azkaraudio/zekr (23).mp3",
      },
    ]
  };
  // AudioPlayer audioPlayersab = AudioPlayer();
  // bool isPlayingsab = false;
  int sabint = 0;
  // String audioUrlsab = "assets/azkaraudio/zekr (1).mp3";

  // Future<void> playAudio(String asset) async {
  //   // Fetch the asset file as a byte array
  //   ByteData assetByteData = await rootBundle.load(asset);
  //   Uint8List assetData = assetByteData.buffer.asUint8List();
  //   // Play the audio file from the byte array
  //   await audioPlayersab.play(BytesSource(assetData));
  //   audioPlayersab.onPlayerComplete.listen((event) {
  //     setState(() {
  //       isPlayingsab = false;
  //     });
  //   });
  // }

  // Future<void> stopAudio() async {
  //   await audioPlayersab.stop();
  //   setState(() {
  //     isPlayingsab = false;
  //   });
  //   await audioPlayersab.seek(Duration.zero);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   audioPlayersab.onPlayerStateChanged.listen((event) {
  //     if (event == PlayerState.playing) {
  //       setState(() {
  //         isPlayingsab = true;
  //       });
  //     } else if (event == PlayerState.paused || event == PlayerState.stopped) {
  //       setState(() {
  //         isPlayingsab = false;
  //       });
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   audioPlayersab.dispose();
  //   super.dispose();
  // }

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
                      opacity: 0.5,
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
                          'أذكار الصباح',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'BigVesta-Arabic-Regular',
                            fontSize: MediaQuery.of(context).size.width / 12,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4,
                      right: 4,
                      left: 4,
                    ),
                    child: Card(
                      color: itemColor,
                      child: Padding(
                        padding: const EdgeInsets.all(
                          8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      sKey.currentState?.openDrawer();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                //Play Zekr Audio
                                // Visibility(
                                //   visible:
                                //       asab['asab'][initpagesab]["path"] == ""
                                //           ? false
                                //           : true,
                                //   child: IconButton(
                                //     splashRadius: 0.1,
                                //     padding: const EdgeInsets.all(0),
                                //     splashColor: Colors.transparent,
                                //     highlightColor: Colors.transparent,
                                //     icon: Icon(
                                //       isPlayingsab
                                //           ? Icons.pause
                                //           : Icons.play_arrow,
                                //       color: Colors.white,
                                //       size: 24,
                                //     ),
                                //     onPressed: () {
                                //       isPlayingsab
                                //           ? stopAudio()
                                //           : playAudio(
                                //               asab['asab'][initpagesab]["path"],
                                //             );
                                //     },
                                //   ),
                                // ),
                                //Refresh
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      pcsab.animateToPage(
                                        0,
                                        duration: (const Duration(
                                            milliseconds: 1500)),
                                        curve: Curves.fastOutSlowIn,
                                      );
                                      for (int p = 0;
                                          p < asab['asab'].length;
                                          p++) {
                                        asab['asab'][p]["sabvar"] = 0;
                                      }
                                    });
                                  },
                                  child: Container(
                                    color: itemColor,
                                    padding: const EdgeInsets.all(
                                      8,
                                    ),
                                    child: const Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                //Font Size
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (tSize >= 16) {
                                        tSize = tSize - 2.0;
                                      }
                                    });
                                  },
                                  child: Container(
                                    color: itemColor,
                                    padding: const EdgeInsets.all(
                                      8,
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                //Font Size
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (tSize <= 36) {
                                        tSize = tSize + 2.0;
                                      }
                                    });
                                  },
                                  child: Container(
                                    color: itemColor,
                                    padding: const EdgeInsets.all(
                                      8,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                //Copy
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      Clipboard.setData(ClipboardData(
                                        text:
                                            'أذكار الصباح\n${asab['asab'][initpagesab]["zekr"]}\n*تطبيق باقيات*',
                                      ));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          content: Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 160,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: backColor,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Text(
                                                    "تم النسخ الى الحافظة",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      fontFamily: 'me_quran',
                                                      wordSpacing: 4,
                                                      height: 1.33,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              32,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  child: Container(
                                    color: itemColor,
                                    padding: const EdgeInsets.all(8),
                                    child: const Icon(
                                      Icons.copy,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                //Share
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      Share.share(
                                        'أذكار الصباح\n${asab['asab'][initpagesab]["zekr"]}\n*تطبيق باقيات*',
                                      );
                                    });
                                  },
                                  child: Container(
                                    color: itemColor,
                                    padding: const EdgeInsets.all(8),
                                    child: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: pcsab,
                      onPageChanged: (value) async {
                        SharedPreferences prefinitpagesab =
                            await SharedPreferences.getInstance();
                        setState(() {
                          initpagesab = value;
                        });
                        prefinitpagesab.setInt('initpagesab', initpagesab);
                      },
                      physics: const BouncingScrollPhysics(),
                      children: [
                        for (int ncounterr = 0;
                            ncounterr < asab['asab'].length;
                            ncounterr++)
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 4,
                              left: 4,
                            ),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4),
                                  bottomRight: Radius.circular(24),
                                  bottomLeft: Radius.circular(24),
                                ),
                              ),
                              color: itemColor,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            SharedPreferences pref3 =
                                                await SharedPreferences
                                                    .getInstance();
                                            setState(() {
                                              allcounter = allcounter + 1;
                                              if (asab['asab'][ncounterr]
                                                      ["sabvar"] <
                                                  asab['asab'][ncounterr]
                                                      ["int"]) {
                                                asab['asab'][ncounterr]
                                                    ["sabvar"]++;
                                              }
                                              if (asab['asab'][ncounterr]
                                                      ["sabvar"] ==
                                                  asab['asab'][ncounterr]
                                                      ["int"]) {
                                                pcsab.animateToPage(
                                                  ncounterr + 1,
                                                  duration: (const Duration(
                                                      milliseconds: 600)),
                                                  curve: Curves.easeInOut,
                                                );
                                              }
                                              pref3.setInt(
                                                  "allcounter", allcounter);
                                            });
                                          },
                                          child: Container(
                                            color: itemColor,
                                            child: Center(
                                              child: SingleChildScrollView(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      '${asab['asab'][ncounterr]["zekr"]}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'me_quran',
                                                        wordSpacing: 4,
                                                        fontSize: tSize,
                                                      ),
                                                    ),
                                                    Visibility(
                                                        visible: asab['asab'][
                                                                            ncounterr]
                                                                        [
                                                                        "reference"] ==
                                                                    "" &&
                                                                asab['asab'][
                                                                            ncounterr]
                                                                        [
                                                                        "description"] ==
                                                                    ""
                                                            ? false
                                                            : true,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Divider(
                                                              height: 12,
                                                              endIndent: 24,
                                                              indent: 24,
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.3),
                                                            ),
                                                            Visibility(
                                                              visible: asab['asab']
                                                                              [
                                                                              ncounterr]
                                                                          [
                                                                          "description"] ==
                                                                      ""
                                                                  ? false
                                                                  : true,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                ),
                                                                child: Text(
                                                                  '${asab['asab'][ncounterr]["description"]}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.8),
                                                                    height: 2,
                                                                    fontFamily:
                                                                        'Amiri-Regular',
                                                                    wordSpacing:
                                                                        0,
                                                                    fontSize:
                                                                        tSize /
                                                                            1.2,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: asab['asab']
                                                                              [
                                                                              ncounterr]
                                                                          [
                                                                          "reference"] ==
                                                                      ""
                                                                  ? false
                                                                  : true,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                child: Text(
                                                                  '${asab['asab'][ncounterr]["reference"]}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .yellow
                                                                        .withOpacity(
                                                                            0.8),
                                                                    fontFamily:
                                                                        'Amiri-Regular',
                                                                    wordSpacing:
                                                                        0,
                                                                    fontSize:
                                                                        tSize /
                                                                            1.5,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: 1,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                '${asab['asab'][ncounterr]['count']}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Amiri-Regular',
                                                  fontSize: 14,
                                                  height: 1.33,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 64,
                                            width: 64,
                                            child: Stack(
                                              children: [
                                                SizedBox(
                                                  height: 64,
                                                  width: 64,
                                                  child: CircularProgressIndicator(
                                                      value: asab['asab']
                                                                  [ncounterr]
                                                              ["sabvar"] /
                                                          asab['asab']
                                                                  [ncounterr]
                                                              ["int"],
                                                      strokeWidth: 2,
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      backgroundColor: Colors
                                                          .white
                                                          .withOpacity(0.2)),
                                                ),
                                                Center(
                                                  child: Text(
                                                    '${asab['asab'][ncounterr]["sabvar"]}'
                                                        .toArabicNumbers,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 32,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 1,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                '${asab['asab'].length} / ${ncounterr + 1}'
                                                    .toArabicNumbers,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Amiri-Regular',
                                                  fontSize: 14,
                                                  height: 1.33,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
