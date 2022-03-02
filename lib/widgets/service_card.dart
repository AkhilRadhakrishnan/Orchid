import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  String name;
  String image;
  bool? fullWidth;
  ServiceCard({Key? key, required this.image, required this.name, this.fullWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
        width: fullWidth != null ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.28,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(image),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      name,
                      style: theme.textTheme.subtitle2,
                      textAlign: TextAlign.center,
                    )))
          ],
        ));
  }
}
