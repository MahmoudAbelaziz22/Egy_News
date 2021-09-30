import 'package:flutter/material.dart';
import '../../size_cofig.dart';
import '../../constants.dart';

class CustomTile extends StatelessWidget {
  final IconData leadingIcon;
  final double contentWidth;
  final String title;
  final VoidCallback onTap;
  final Color leadingIconColor;
  final Color titleColor;
  final Color tileColor;

  const CustomTile({
    Key? key,
    required this.leadingIcon,
    this.contentWidth = 10.0,
    this.title = "",
    required this.onTap,
    this.leadingIconColor = Colors.black,
    this.titleColor = Colors.black,
    this.tileColor = Colors.transparent,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(
              leadingIcon,
              size: getProportionateScreenWidth(30),
              color: leadingIconColor,
            ),
            SizedBox(
              width: contentWidth,
            ),
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontSize: getProportionateScreenWidth(18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
