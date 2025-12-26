import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../core/utils/helpers.dart';

/// بطاقة الذكر
class ZikrCard extends StatelessWidget {
  final String text;
  final int totalCount;
  final int currentCount;
  final String? reference;
  final String? description;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onTap;
  final VoidCallback? onShare;
  final VoidCallback? onCopy;
  final double fontSize;

  const ZikrCard({
    super.key,
    required this.text,
    required this.totalCount,
    required this.currentCount,
    this.reference,
    this.description,
    required this.backgroundColor,
    required this.textColor,
    this.onTap,
    this.onShare,
    this.onCopy,
    this.fontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = currentCount >= totalCount;
    final remaining = totalCount - currentCount;

    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // نص الذكر
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontSize: fontSize,
                          fontFamily: 'KFGQPC',
                          height: 1.8,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // المرجع والعداد
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // أزرار المشاركة والنسخ
                    Row(
                      children: [
                        if (onShare != null)
                          IconButton(
                            icon:
                                const Icon(Icons.share, color: Colors.white70),
                            onPressed: onShare,
                            iconSize: 20,
                          ),
                        if (onCopy != null)
                          IconButton(
                            icon: const Icon(Icons.copy, color: Colors.white70),
                            onPressed: onCopy,
                            iconSize: 20,
                          ),
                      ],
                    ),

                    // العداد
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isCompleted ? Colors.green : Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isCompleted ? '✓' : remaining.toArabicNumbers,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// عنصر قائمة الأذكار
class ZikrListItem extends StatelessWidget {
  final String title;
  final int index;
  final Color backgroundColor;
  final VoidCallback onTap;

  const ZikrListItem({
    super.key,
    required this.title,
    required this.index,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 300 + (index * 50)),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // رقم الذكر
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    (index + 1).toArabicNumbers,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // عنوان الذكر
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'BigVesta-Arabic-Regular',
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white54,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
