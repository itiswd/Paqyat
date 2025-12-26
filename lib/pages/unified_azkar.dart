import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// صفحة أذكار موحدة يمكن استخدامها لأذكار الصباح والمساء
class UnifiedAzkarPage extends StatefulWidget {
  final String title;
  final String backgroundImage;
  final Color primaryColor;
  final List<Map<String, dynamic>> azkarData;
  final String audioAssetPath;

  const UnifiedAzkarPage({
    Key? key,
    required this.title,
    required this.backgroundImage,
    required this.primaryColor,
    required this.azkarData,
    required this.audioAssetPath,
  }) : super(key: key);

  @override
  State<UnifiedAzkarPage> createState() => _UnifiedAzkarPageState();
}

class _UnifiedAzkarPageState extends State<UnifiedAzkarPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final PageController _pageController = PageController();
  final List<int> _counters = [];
  int _currentPage = 0;
  bool _isPlaying = false;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _initializeCounters();
    _loadMuteState();
    _setupAudioListeners();
  }

  void _initializeCounters() {
    for (var zikr in widget.azkarData) {
      _counters.add(zikr['count'] ?? 1);
    }
  }

  Future<void> _loadMuteState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isMuted = (prefs.getInt('Mute') ?? 0) == 1;
    });
  }

  void _setupAudioListeners() {
    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() => _isPlaying = false);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _decrementCounter() {
    if (_counters[_currentPage] > 0) {
      setState(() {
        _counters[_currentPage]--;
      });

      if (!_isMuted) {
        HapticFeedback.lightImpact();
      }

      // الانتقال للذكر التالي عند انتهاء العدد
      if (_counters[_currentPage] == 0 &&
          _currentPage < widget.azkarData.length - 1) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      }
    }
  }

  Future<void> _toggleAudio() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() => _isPlaying = false);
    } else {
      await _audioPlayer.play(AssetSource(widget.audioAssetPath));
      setState(() => _isPlaying = true);
    }
  }

  void _resetCounters() {
    setState(() {
      for (int i = 0; i < _counters.length; i++) {
        _counters[i] = widget.azkarData[i]['count'] ?? 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // طبقة التعتيم
          Container(
            color: Colors.black.withOpacity(0.3),
          ),

          SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                _buildProgressIndicator(),
                Expanded(child: _buildAzkarPageView()),
                _buildBottomControls(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause_circle : Icons.play_circle,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: _toggleAudio,
              ),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: _resetCounters,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    int completed = _counters.where((c) => c == 0).length;
    double progress = completed / widget.azkarData.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_currentPage + 1}/${widget.azkarData.length}',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                '$completed/${widget.azkarData.length} مكتمل',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white24,
            valueColor: AlwaysStoppedAnimation<Color>(widget.primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildAzkarPageView() {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.azkarData.length,
      onPageChanged: (index) {
        setState(() => _currentPage = index);
      },
      itemBuilder: (context, index) {
        return _buildZikrCard(index);
      },
    );
  }

  Widget _buildZikrCard(int index) {
    final zikr = widget.azkarData[index];
    final isCompleted = _counters[index] == 0;

    return GestureDetector(
      onTap: _decrementCounter,
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: isCompleted
              ? Colors.green.withOpacity(0.9)
              : Colors.white.withOpacity(0.95),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // العداد
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: isCompleted ? Colors.white24 : widget.primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    '${_counters[index]}',
                    style: TextStyle(
                      color: isCompleted ? Colors.white : Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // نص الذكر
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          zikr['zekr'] ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isCompleted ? Colors.white : Colors.black87,
                            fontSize: 22,
                            fontFamily: 'Amiri',
                            height: 1.8,
                          ),
                        ),
                        if (zikr['reference'] != null &&
                            zikr['reference'].isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? Colors.white12
                                  : widget.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              zikr['reference'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isCompleted
                                    ? Colors.white70
                                    : widget.primaryColor,
                                fontSize: 14,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                        ],
                        if (zikr['fadl'] != null &&
                            zikr['fadl'].isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(
                            zikr['fadl'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isCompleted
                                  ? Colors.white60
                                  : Colors.grey[600],
                              fontSize: 14,
                              fontFamily: 'Cairo',
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // تعليمات
                if (!isCompleted)
                  Text(
                    'اضغط للتسبيح',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),

                if (isCompleted)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'مكتمل',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavButton(
            icon: Icons.arrow_back_ios,
            onPressed: _currentPage > 0
                ? () => _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    )
                : null,
          ),

          // زر العد
          GestureDetector(
            onTap: _decrementCounter,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: widget.primaryColor.withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${_counters[_currentPage]}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          _buildNavButton(
            icon: Icons.arrow_forward_ios,
            onPressed: _currentPage < widget.azkarData.length - 1
                ? () => _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    )
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return IconButton(
      icon: Icon(
        icon,
        color: onPressed != null ? Colors.white : Colors.white38,
        size: 28,
      ),
      onPressed: onPressed,
    );
  }
}

/// صفحة أذكار الصباح
class MorningAzkarPage extends StatelessWidget {
  const MorningAzkarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnifiedAzkarPage(
      title: 'أذكار الصباح',
      backgroundImage: 'assets/images/morning.jpg',
      primaryColor: const Color(0xFFFF9800),
      audioAssetPath: 'azkar/morning.mp3',
      azkarData: _morningAzkar,
    );
  }
}

/// صفحة أذكار المساء
class EveningAzkarPage extends StatelessWidget {
  const EveningAzkarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnifiedAzkarPage(
      title: 'أذكار المساء',
      backgroundImage: 'assets/images/evening.jpg',
      primaryColor: const Color(0xFF5C6BC0),
      audioAssetPath: 'azkar/evening.mp3',
      azkarData: _eveningAzkar,
    );
  }
}

// بيانات أذكار الصباح
final List<Map<String, dynamic>> _morningAzkar = [
  {
    'zekr':
        'أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ\n{اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَنْ ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ}',
    'count': 1,
    'reference': 'آية الكرسي - سورة البقرة: 255',
    'fadl':
        'من قالها حين يصبح أجير من الجن حتى يمسي ومن قالها حين يمسي أجير منهم حتى يصبح',
  },
  {
    'zekr':
        'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n{قُلْ هُوَ اللَّهُ أَحَدٌ * اللَّهُ الصَّمَدُ * لَمْ يَلِدْ وَلَمْ يُولَدْ * وَلَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ}',
    'count': 3,
    'reference': 'سورة الإخلاص',
    'fadl': '',
  },
  {
    'zekr':
        'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n{قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ * مِنْ شَرِّ مَا خَلَقَ * وَمِنْ شَرِّ غَاسِقٍ إِذَا وَقَبَ * وَمِنْ شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ * وَمِنْ شَرِّ حَاسِدٍ إِذَا حَسَدَ}',
    'count': 3,
    'reference': 'سورة الفلق',
    'fadl': '',
  },
  {
    'zekr':
        'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n{قُلْ أَعُوذُ بِرَبِّ النَّاسِ * مَلِكِ النَّاسِ * إِلَٰهِ النَّاسِ * مِنْ شَرِّ الْوَسْوَاسِ الْخَنَّاسِ * الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ * مِنَ الْجِنَّةِ وَالنَّاسِ}',
    'count': 3,
    'reference': 'سورة الناس',
    'fadl': 'تكفيه من كل شيء',
  },
  {
    'zekr':
        'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ. رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَٰذَا الْيَوْمِ وَخَيْرَ مَا بَعْدَهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَٰذَا الْيَوْمِ وَشَرِّ مَا بَعْدَهُ، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ، رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ',
    'count': 1,
    'reference': 'صحيح مسلم',
    'fadl': '',
  },
  {
    'zekr':
        'اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ النُّشُورُ',
    'count': 1,
    'reference': 'سنن الترمذي',
    'fadl': '',
  },
  {
    'zekr':
        'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَٰهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَىٰ عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
    'count': 1,
    'reference': 'سيد الاستغفار - صحيح البخاري',
    'fadl':
        'من قالها موقناً بها حين يمسي فمات من ليلته دخل الجنة وكذلك حين يصبح',
  },
  {
    'zekr':
        'اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ، وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلَائِكَتَكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَٰهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّدًا عَبْدُكَ وَرَسُولُكَ',
    'count': 4,
    'reference': 'سنن أبي داود',
    'fadl': 'من قالها أعتقه الله من النار',
  },
  {
    'zekr':
        'اللَّهُمَّ مَا أَصْبَحَ بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لَا شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ',
    'count': 1,
    'reference': 'سنن أبي داود',
    'fadl': 'من قالها حين يصبح فقد أدى شكر يومه',
  },
  {
    'zekr':
        'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَٰهَ إِلَّا أَنْتَ. اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ، وَالْفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلَٰهَ إِلَّا أَنْتَ',
    'count': 3,
    'reference': 'سنن أبي داود',
    'fadl': '',
  },
  {
    'zekr':
        'حَسْبِيَ اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ',
    'count': 7,
    'reference': 'سورة التوبة: 129',
    'fadl': 'من قالها كفاه الله ما أهمه من أمر الدنيا والآخرة',
  },
  {
    'zekr':
        'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
    'count': 3,
    'reference': 'سنن أبي داود والترمذي',
    'fadl': 'لم يضره شيء',
  },
  {
    'zekr':
        'رَضِيتُ بِاللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِينًا، وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا',
    'count': 3,
    'reference': 'سنن أبي داود والترمذي',
    'fadl': 'كان حقاً على الله أن يرضيه يوم القيامة',
  },
  {
    'zekr':
        'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ، وَلَا تَكِلْنِي إِلَىٰ نَفْسِي طَرْفَةَ عَيْنٍ',
    'count': 1,
    'reference': 'المستدرك للحاكم',
    'fadl': '',
  },
  {
    'zekr': 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
    'count': 100,
    'reference': 'صحيح مسلم',
    'fadl':
        'لم يأت أحد يوم القيامة بأفضل مما جاء به إلا أحد قال مثل ما قال أو زاد عليه',
  },
  {
    'zekr':
        'لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
    'count': 10,
    'reference': 'صحيح البخاري ومسلم',
    'fadl':
        'كانت له عدل عشر رقاب، وكتبت له مئة حسنة، ومحيت عنه مئة سيئة، وكانت له حرزاً من الشيطان',
  },
  {
    'zekr':
        'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ، عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ، وَمِدَادَ كَلِمَاتِهِ',
    'count': 3,
    'reference': 'صحيح مسلم',
    'fadl': '',
  },
  {
    'zekr':
        'اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا طَيِّبًا، وَعَمَلًا مُتَقَبَّلًا',
    'count': 1,
    'reference': 'سنن ابن ماجه',
    'fadl': 'بعد السلام من صلاة الفجر',
  },
  {
    'zekr': 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ',
    'count': 100,
    'reference': 'صحيح البخاري ومسلم',
    'fadl': '',
  },
];

// بيانات أذكار المساء
final List<Map<String, dynamic>> _eveningAzkar = [
  {
    'zekr':
        'أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ\n{اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَنْ ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ}',
    'count': 1,
    'reference': 'آية الكرسي - سورة البقرة: 255',
    'fadl': 'من قالها حين يمسي أجير من الجن حتى يصبح',
  },
  {
    'zekr':
        'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n{قُلْ هُوَ اللَّهُ أَحَدٌ * اللَّهُ الصَّمَدُ * لَمْ يَلِدْ وَلَمْ يُولَدْ * وَلَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ}',
    'count': 3,
    'reference': 'سورة الإخلاص',
    'fadl': '',
  },
  {
    'zekr':
        'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n{قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ * مِنْ شَرِّ مَا خَلَقَ * وَمِنْ شَرِّ غَاسِقٍ إِذَا وَقَبَ * وَمِنْ شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ * وَمِنْ شَرِّ حَاسِدٍ إِذَا حَسَدَ}',
    'count': 3,
    'reference': 'سورة الفلق',
    'fadl': '',
  },
  {
    'zekr':
        'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n{قُلْ أَعُوذُ بِرَبِّ النَّاسِ * مَلِكِ النَّاسِ * إِلَٰهِ النَّاسِ * مِنْ شَرِّ الْوَسْوَاسِ الْخَنَّاسِ * الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ * مِنَ الْجِنَّةِ وَالنَّاسِ}',
    'count': 3,
    'reference': 'سورة الناس',
    'fadl': 'تكفيه من كل شيء',
  },
  {
    'zekr':
        'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ. رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَٰذِهِ اللَّيْلَةِ وَخَيْرَ مَا بَعْدَهَا، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَٰذِهِ اللَّيْلَةِ وَشَرِّ مَا بَعْدَهَا، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ، رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ',
    'count': 1,
    'reference': 'صحيح مسلم',
    'fadl': '',
  },
  {
    'zekr':
        'اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ الْمَصِيرُ',
    'count': 1,
    'reference': 'سنن الترمذي',
    'fadl': '',
  },
  {
    'zekr':
        'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَٰهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَىٰ عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
    'count': 1,
    'reference': 'سيد الاستغفار - صحيح البخاري',
    'fadl': 'من قالها موقناً بها حين يمسي فمات من ليلته دخل الجنة',
  },
  {
    'zekr':
        'اللَّهُمَّ إِنِّي أَمْسَيْتُ أُشْهِدُكَ، وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلَائِكَتَكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَٰهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّدًا عَبْدُكَ وَرَسُولُكَ',
    'count': 4,
    'reference': 'سنن أبي داود',
    'fadl': 'من قالها أعتقه الله من النار',
  },
  {
    'zekr':
        'اللَّهُمَّ مَا أَمْسَى بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لَا شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ',
    'count': 1,
    'reference': 'سنن أبي داود',
    'fadl': 'من قالها حين يمسي فقد أدى شكر ليلته',
  },
  {
    'zekr':
        'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَٰهَ إِلَّا أَنْتَ. اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ، وَالْفَقْرِ، وَأَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلَٰهَ إِلَّا أَنْتَ',
    'count': 3,
    'reference': 'سنن أبي داود',
    'fadl': '',
  },
  {
    'zekr':
        'حَسْبِيَ اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ',
    'count': 7,
    'reference': 'سورة التوبة: 129',
    'fadl': 'من قالها كفاه الله ما أهمه من أمر الدنيا والآخرة',
  },
  {
    'zekr':
        'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
    'count': 3,
    'reference': 'سنن أبي داود والترمذي',
    'fadl': 'لم يضره شيء',
  },
  {
    'zekr':
        'رَضِيتُ بِاللَّهِ رَبًّا، وَبِالْإِسْلَامِ دِينًا، وَبِمُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ نَبِيًّا',
    'count': 3,
    'reference': 'سنن أبي داود والترمذي',
    'fadl': 'كان حقاً على الله أن يرضيه يوم القيامة',
  },
  {
    'zekr':
        'يَا حَيُّ يَا قَيُّومُ بِرَحْمَتِكَ أَسْتَغِيثُ، أَصْلِحْ لِي شَأْنِي كُلَّهُ، وَلَا تَكِلْنِي إِلَىٰ نَفْسِي طَرْفَةَ عَيْنٍ',
    'count': 1,
    'reference': 'المستدرك للحاكم',
    'fadl': '',
  },
  {
    'zekr': 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
    'count': 3,
    'reference': 'صحيح مسلم',
    'fadl': 'من قالها حين يمسي ثلاث مرات لم تضره حمة تلك الليلة',
  },
  {
    'zekr': 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
    'count': 100,
    'reference': 'صحيح مسلم',
    'fadl':
        'لم يأت أحد يوم القيامة بأفضل مما جاء به إلا أحد قال مثل ما قال أو زاد عليه',
  },
  {
    'zekr':
        'لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ',
    'count': 10,
    'reference': 'صحيح البخاري ومسلم',
    'fadl':
        'كانت له عدل عشر رقاب، وكتبت له مئة حسنة، ومحيت عنه مئة سيئة، وكانت له حرزاً من الشيطان',
  },
  {
    'zekr': 'أَسْتَغْفِرُ اللَّهَ وَأَتُوبُ إِلَيْهِ',
    'count': 100,
    'reference': 'صحيح البخاري ومسلم',
    'fadl': '',
  },
];
