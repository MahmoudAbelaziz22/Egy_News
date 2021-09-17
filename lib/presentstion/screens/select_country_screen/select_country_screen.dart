import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../../../data/models/country.dart';
import '../home_screen/Home_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import 'components/country_card.dart';

class SelectCountryScreen extends StatefulWidget {
  static const String routeName = '/select_country';
  const SelectCountryScreen({Key? key}) : super(key: key);

  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  List<Country> countries = [
    Country(countryName: 'Egypt', countryCode: 'eg'),
    Country(countryName: 'United States', countryCode: 'us'),
    Country(countryName: 'Argentina', countryCode: 'ar'),
    Country(countryName: 'France', countryCode: 'fr'),
    Country(countryName: 'Switzerland', countryCode: 'ch'),
    Country(countryName: 'Brazil', countryCode: 'br'),
    Country(countryName: 'Ukraine', countryCode: 'ua'),
    Country(countryName: 'United Arab Emirates', countryCode: 'ae'),
    Country(countryName: 'Canada', countryCode: 'ca'),
  ];
  void saveCountryCodeToPrefs(Country country) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('countryCode', country.countryCode);
    Fluttertoast.showToast(
        msg: "${country.countryName} selected",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: MyColors.myGreen,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, HomeScreen.routName),
          ),
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Select Country',
            style: TextStyle(
              color: MyColors.myGreen,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: countries.length,
            itemBuilder: (BuildContext context, index) => CountryCard(
              country: countries[index],
              onSelectted: () {
                saveCountryCodeToPrefs(countries[index]);
                Navigator.pushReplacementNamed(context, HomeScreen.routName);
              },
            ),
          ),
        ));
  }
}
