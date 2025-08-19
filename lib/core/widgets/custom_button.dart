import 'package:fig/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool showToggleIcon;
  final VoidCallback? onToggle;
  final bool isPasswordVisible;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;

  const BuildTextField({
    super.key,
    required this.hint,
    this.obscureText = false,
    required this.controller,
    this.validator,
    this.showToggleIcon = false,
    this.onToggle,
    this.isPasswordVisible = true,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      cursorColor: Colors.white,
      validator: validator,
      controller: controller,
      obscureText: showToggleIcon ? !isPasswordVisible : false,
      keyboardType: keyboardType,
      style: TextStyle(
        color: Colors.black,
        fontSize: responsiveText(context, 16),
      ),
      decoration: InputDecoration(
        prefixIcon:
            prefixIcon != null
                ? Icon(
                  prefixIcon,
                  color: Colors.black,
                  size: responsiveWidth(context, 24),
                )
                : null,
        labelText: hint,
        hintText: hint,
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: responsiveText(context, 16),
        ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(
          horizontal: responsiveWidth(context, 20),
          vertical: responsiveHeight(context, 15),
        ),
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        suffixIcon:
            showToggleIcon
                ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                    size: responsiveWidth(context, 24),
                  ),
                  onPressed: onToggle,
                )
                : null,
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final IconData? icon;
  final bool iconAtEnd;
  final FontWeight fontWeight;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.icon,
    this.iconAtEnd = false,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.white,
          foregroundColor: foregroundColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side:
                borderColor != null
                    ? BorderSide(color: borderColor!)
                    : BorderSide.none,
          ),
          minimumSize: Size(double.infinity, 45.rh(context)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children:
              icon == null
                  ? [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16.rt(context),
                        fontWeight: fontWeight, // ✅ تم التبديل هنا
                      ),
                    ),
                  ]
                  : iconAtEnd
                  ? [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16.rt(context),
                        fontWeight: fontWeight, // ✅
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      icon,
                      size: 20,
                      color: foregroundColor ?? Colors.white,
                    ),
                  ]
                  : [
                    Icon(
                      icon,
                      size: 20,
                      color: foregroundColor ?? Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16.rt(context),
                        fontWeight: fontWeight, // ✅
                      ),
                    ),
                  ],
        ),
      ),
    );
  }
}

class TransparentTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const TransparentTextButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // تقليل الحشو الافتراضي
        minimumSize: Size(0, 0), // يمنع استهلاك مساحة زائدة
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // ضغط منطقة التفاعل
      ),
      child: Text(
        label,
        overflow: TextOverflow.ellipsis, // لمنع overflow
        softWrap: false, // منع النزول للسطر إذا أردت
        style: TextStyle(
          color: colorScheme.onSurface.withOpacity(0.6),
          fontSize: 14,
        ),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final IconData? iconData;
  final Color? iconColor;
  final Widget? iconWidget;
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const SocialLoginButton({
    super.key,
    this.iconData,
    this.iconColor,
    this.iconWidget,
    required this.label,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 135.rw(context),
        padding: EdgeInsets.symmetric(vertical: 12.rh(context)),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // يوسّط المحتوى أفقيًا
          crossAxisAlignment:
              CrossAxisAlignment.center, // يوسّط المحتوى عموديًا
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconWidget != null)
              iconWidget!
            else if (iconData != null)
              Icon(iconData, color: iconColor ?? Colors.white),
            SizedBox(width: 6.rw(context)),
            Text(
              label,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
