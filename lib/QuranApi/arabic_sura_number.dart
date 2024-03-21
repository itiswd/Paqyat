import 'package:flutter/material.dart';
import 'package:paqyat/QuranApi/to_arabic_no_converter.dart';

class ArabicSuraNumber extends StatelessWidget {
  const ArabicSuraNumber({Key? key, required this.i}) : super(key: key);
  final int i;
  @override
  Widget build(BuildContext context) {
    return Text(
      "\uFD3F${(i + 1).toString().toArabicNumbers}\uFD3E",
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'me_quran',
        fontSize: 20,
      ),
    );
  }
}
