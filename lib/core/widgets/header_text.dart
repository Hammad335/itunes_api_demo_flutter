import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../styles/text_styles.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 70,
      child: Text(
        HEADER_TEXT,
        textAlign: TextAlign.center,
        style: TextStyles.tracksScreenHeading,
      ),
    );
  }
}
