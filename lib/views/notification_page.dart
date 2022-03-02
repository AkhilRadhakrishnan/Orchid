import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  // This widget is
  //the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: bodyTextColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        // Icon(Icons.menu,color: primaryColor,),
        title: const Padding(
          padding: EdgeInsets.all(80.0),
          child: Text(
            'Notifications',
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox();
        },
        itemCount: 10,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            height: MediaQuery.of(context).size.height*.14,
            margin: const EdgeInsets.only(left: 20,right: 20,top: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width:25,
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.white,size: 18,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5)),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        Row
                          (mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Remind for serial'),
                            Text('02.45 PM'),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Column(
                          children: const [
                            Text('fxchghhcvhsgghaVChgxctfgxghvghsvcdgftdshghjafdstfdgakjgtcf')
                          ],
                        )],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),

    );
  }
}
