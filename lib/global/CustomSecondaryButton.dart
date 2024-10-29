import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSecondaryButton extends StatelessWidget {
  final String leadingIcon;
  final VoidCallback onPressed;
  final String buttonText;
  final bool showIcon;
  Color?  bgcolor ;
  final buttonColor;

    CustomSecondaryButton(
      {Key? key,
      this.bgcolor ,
      required this.leadingIcon,
      required this.onPressed,
      required this.buttonText,
      required this.buttonColor,
      this.showIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: bgcolor != null ?  bgcolor : Color.fromARGB(255, 231, 231, 231),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            )),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon) SvgPicture.asset(leadingIcon, height: 28, width: 28),
            SizedBox(width: showIcon ? 10 : 0),
            Text(buttonText,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: Colors.black87,
                    fontFamily: 'Mukta')),
          ],
        ),
      ),
    );
  }
}
