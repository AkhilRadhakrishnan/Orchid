import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';

class SpecialitiesCard extends StatelessWidget {
  final dynamic specialities;
  final bool noColor;
  const SpecialitiesCard({this.specialities, required this.noColor});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width * .21,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        // color: primaryColor
        color: noColor ? Colors.white: Color(int.parse(specialities.color)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Image.network(
              specialities.icon,
              width: 45.0,
              height: 45.0,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              specialities.title,
              style: theme.textTheme.subtitle2?.copyWith(
                  color: noColor ? bodyTextColor: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
