import 'package:flutter/material.dart';
import 'package:fig/core/utils/responsive.dart';


class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool isClickable;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.borderColor,
    this.onTap,
    this.trailing,
    this.isClickable = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.rw(context)),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.rr(context)),
        border: Border.all(color: borderColor ?? Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor ?? Colors.red.shade700,
            size: 24.rw(context),
          ),
          SizedBox(width: 16.rw(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.rt(context),
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.rh(context)),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.rt(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
          if (isClickable && trailing == null)
            Icon(
              Icons.arrow_forward_ios,
              size: 16.rw(context),
              color: Colors.grey.shade400,
            ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.rr(context)),
        child: cardContent,
      );
    }

    return cardContent;
  }
}


class UserInfoCard extends InfoCard {
  const UserInfoCard({
    super.key,
    required super.title,
    required super.value,
    required super.icon,
    super.onTap,
    super.trailing,
  }) : super(
         iconColor: null, 
         backgroundColor: null, 
         isClickable: false,
       );
}

class ClickableInfoCard extends InfoCard {
  const ClickableInfoCard({
    super.key,
    required super.title,
    required super.value,
    required super.icon,
    required super.onTap,
    super.trailing,
  }) : super(isClickable: true, backgroundColor: Colors.white);
}

class SuccessInfoCard extends InfoCard {
  const SuccessInfoCard({
    super.key,
    required super.title,
    required super.value,
    required super.icon,
    super.onTap,
    super.trailing,
  }) : super(
         iconColor: Colors.green,
         backgroundColor: const Color(0xFFF0F9F0),
         borderColor: Colors.green,
       );
}

class WarningInfoCard extends InfoCard {
  const WarningInfoCard({
    super.key,
    required super.title,
    required super.value,
    required super.icon,
    super.onTap,
    super.trailing,
  }) : super(
         iconColor: Colors.orange,
         backgroundColor: const Color(0xFFFFF8E1),
         borderColor: Colors.orange,
       );
}
