
import 'package:flutter/material.dart';

class SectionTile extends StatelessWidget {
  const SectionTile({
    super.key,
    this.icon,
    this.title,
    this.subTitle,
    this.onTap,
  });
  final IconData? icon;
  final String? title;
  final String? subTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(icon, color: Colors.white) : null,
      title: title != null ? Text(title!) : null,
      subtitle: subTitle != null ? Text(subTitle!) : null,
      onTap: onTap,
    );
  }
}
