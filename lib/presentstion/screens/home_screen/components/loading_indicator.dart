import 'package:flutter/material.dart';

import '../../../../constants.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myGreen,
      ),
    );
  }
}
