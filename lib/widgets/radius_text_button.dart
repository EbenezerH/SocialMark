import 'package:flutter/material.dart';

import '../theme/theme.dart';

class RadiusTextButton extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final double? textSize;
  final bool? changeRadius;
  final double? radius;
  final Color? color;
  final Color? textColor;
  final bool? border;
  final GestureTapCallback? onTap;

  const RadiusTextButton({
    super.key,
    required this.text,
    this.width,
    this.height,
    this.paddingHorizontal = 20,
    this.paddingVertical = 20,
    this.textSize = 18,
    this.changeRadius = false,
    this.radius,
    this.color = firstColor,
    this.textColor,
    this.border = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal!, vertical: paddingVertical!),
          decoration: BoxDecoration(
            color: border == true ? grey : color,
            borderRadius: BorderRadius.circular(
                changeRadius == true ? radius! : screenWidth * 0.08),
            border: border == true ? Border.all(color: white, width: 2) : null,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: textSize, color: textColor ?? Colors.white),
          )),
    );
  }
}
