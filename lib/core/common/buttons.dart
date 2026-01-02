import 'package:flutter/material.dart';
import '../theme/color.dart';
import 'gap.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final bool isLoading;
  final ButtonStyle? style;
  final bool outlined;
  final bool disabled;
  final double? textSize;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;

  ButtonWidget({
    super.key,
    this.onPressed,
    this.text,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.isLoading = false,
    this.style,
    this.outlined = false,
    this.disabled = false,
    this.textSize,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;
    final isDisabled = disabled || onPressed == null || isLoading;
    return Container(
      width: width,
      height: height ?? 43,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: !isDisabled && !outlined
            ? [
                BoxShadow(
                  color: (backgroundColor ?? AppColors.primary).withOpacity(
                    0.1,
                  ),
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
      child: outlined
          ? OutlinedButton(
              onPressed: isDisabled ? null : onPressed,
              style:
                  style ??
                  OutlinedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: textColor ?? AppColors.white,
                    side: BorderSide(
                      color: isDisabled
                          ? AppColors.primary.withOpacity(0.3)
                          : (backgroundColor ?? AppColors.primary),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        padding ??
                        EdgeInsets.symmetric(horizontal: 24, vertical: 12),

                    elevation: 0,
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: Colors.transparent,
                  ),
              child: _buildButtonContent(isDisabled, isTablet),
            )
          : ElevatedButton(
              onPressed: isDisabled ? null : onPressed,
              style:
                  style ??
                  ElevatedButton.styleFrom(
                    backgroundColor: isDisabled
                        ? AppColors.textColor.withOpacity(0.12)
                        : (backgroundColor ?? AppColors.primary),
                    foregroundColor: isDisabled
                        ? AppColors.textColor.withOpacity(0.38)
                        : (textColor ?? AppColors.white),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: isTablet
                        ? EdgeInsets.zero
                        : padding ??
                              EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: Colors.transparent,
                  ),
              child: _buildButtonContent(isDisabled, isTablet),
            ),
    );
  }

  Widget _buildButtonContent(bool isDisabled, bool isTablet) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: outlined
              ? (textColor ?? AppColors.primary)
              : (textColor ?? AppColors.white),
        ),
      );
    }

    if (icon != null && text != null) {
      return Row(
        mainAxisSize: .min,
        children: [
          Icon(icon, size: 18),
          Gap(width: 8),
          Text(
            text!,
            style: TextStyle(
              color: isDisabled
                  ? AppColors.textColor.withOpacity(0.5)
                  : (textColor ?? AppColors.white),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    if (icon != null) {
      return Icon(icon, size: 20);
    }

    return Text(
      text ?? 'Button',
      style: TextStyle(
        color: isDisabled
            ? AppColors.textColor.withOpacity(0.5)
            : (textColor ?? AppColors.white),
        fontSize: textSize ?? (isTablet ? 14 : 14),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
