import 'package:flutter/material.dart';

class CardTitlesWidget extends StatelessWidget {
  final String title;
  bool isTitle;

  CardTitlesWidget({required this.title, required this.isTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
              fontWeight: isTitle ? FontWeight.w600 : FontWeight.w400,
              fontSize: isTitle ? 16 : 14,
            ),
      ),
    );
  }
}
