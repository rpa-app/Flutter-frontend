import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryButton extends StatefulWidget {
  final String label;
  final String? iconPath;
  final Color color;
  final bool? isLoading;
  final bool isEnabled;
  final double? height;
  final BoxShadow? shadow;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final BorderRadius? borderRadius;
  final Function() onTap;
  const PrimaryButton(
      {super.key,
      required this.label,
      required this.color,
      required this.isEnabled,
      this.height,
      this.isLoading = false,
      this.width,
      this.iconPath,
      this.fontSize,
      this.shadow,
      this.fontWeight,
      this.fontColor,
      this.borderRadius,
      required this.onTap});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  double scaleParameter = 1;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 0.95,
        upperBound: 1.0,
        value: 1,
        duration: const Duration(milliseconds: 100));

    _animationController.addListener(() {
      setState(() {
        scaleParameter = _animationController.value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () async {
        await _animationController.reverse();
        await _animationController.forward();
        widget.onTap();
      },
      child: Transform.scale(
        scale: scaleParameter,
        child: Container(
          alignment: Alignment.center,
          height: widget.height ?? 40,
          width: widget.width ?? MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: widget.isEnabled ? widget.color : Colors.grey,
              borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
              boxShadow: [
                widget.shadow ?? const BoxShadow(color: Colors.transparent)
              ]),
          child: widget.isLoading == false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.iconPath != null
                        ? SvgPicture.asset(
                            widget.iconPath ?? '',
                            width: 24,
                            height: 24,
                          )
                        : const SizedBox(),
                    widget.iconPath != null && widget.label != ''
                        ? const SizedBox(
                            width: 12,
                          )
                        : const SizedBox(),
                    widget.label != ''
                        ? Text(
                            widget.label,
                            style: TextStyle(
                              fontSize: widget.fontSize ?? 18,
                              fontWeight: widget.fontWeight ?? FontWeight.w800,
                              color: widget.fontColor ??
                                  theme.colorScheme.onPrimary,
                              fontFamily: 'SpaceG',
                            ),
                          )
                        : const SizedBox()
                  ],
                )
              : CircularProgressIndicator(
                  color: theme.colorScheme.onPrimary,
                ),
        ),
      ),
    );
  }
}
