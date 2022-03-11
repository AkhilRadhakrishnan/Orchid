import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';

class DoctorCard extends StatelessWidget {
  final dynamic person;
  bool? noPatients;
  bool? selected;
  DoctorCard({Key? key, this.person, this.noPatients, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: selected != null
              ? (selected! ? primaryColor : Colors.white)
              : Colors.white),
      width: MediaQuery.of(context).size.width * .45,
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(person!.name!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style:
                    theme.textTheme.subtitle2?.copyWith(color: selectTextColor())),
            Text(person!.speciality!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style:
                    theme.textTheme.bodyText2?.copyWith(color: selectTextColor())),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Experience',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: theme.textTheme.bodyText2
                              ?.copyWith(fontSize: 14, color: selectTextColor())),
                      Text(person!.experience!,
                          style: theme.textTheme.bodyText2
                              ?.copyWith(fontSize: 12, color: selectTextColor())),
                      const SizedBox(
                        height:40,
                      ),
                      if (noPatients == null)
                        Text('Patients',
                            style: theme.textTheme.bodyText2
                                ?.copyWith(fontSize: 14, color: selectTextColor())),
                      if (noPatients == null)
                        Text(person!.patients!,
                            style: theme.textTheme.bodyText2
                                ?.copyWith(fontSize: 12, color: selectTextColor())),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Image.network(
                      person!.image!,
                      fit: BoxFit.cover,
                      height: 115,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color selectTextColor() {
    return selected != null
        ? (selected! ? Colors.white : bodyTextColor)
        : bodyTextColor;
  }
}
