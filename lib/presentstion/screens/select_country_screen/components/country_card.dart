import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import '../../../../size_cofig.dart';
import '../../../../data/models/country.dart';

class CountryCard extends StatelessWidget {
  const CountryCard(
      {Key? key, required this.country, required this.onSelectted})
      : super(key: key);

  final Country country;
  final VoidCallback onSelectted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectted,
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Flag.fromString(
              country.countryCode,
              height: getProportionateScreenHeight(35),
              width: getProportionateScreenWidth(40),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              country.countryName,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      )),
    );
  }
}
