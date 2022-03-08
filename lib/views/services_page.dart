import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/provider/slider_provider.dart';
import 'package:orchid/provider/specialities_provider.dart';
import 'package:orchid/views/service_booking_page.dart';
import 'package:orchid/widgets/service_card.dart';
import 'package:orchid/widgets/specialities_card.dart';
import 'package:provider/provider.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  int current = 0;

  @override
  void initState() {
    super.initState();
    context.read<ServicesProvider>().fetchServices();
    context.read<ServiceSliderProvider>(). fetchServiceSliders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 45,
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
          padding: EdgeInsets.all(75.0),
          child: Text(
            'Services',
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.28,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.all(15),
              child:
                  Consumer<ServiceSliderProvider>(builder: (context, value, child) {
                if (value.serviceSliders?.serviceSliders == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 20);
                  },
                  itemCount: value.serviceSliders!.serviceSliders!.length,
                  scrollDirection: Axis.horizontal,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var services = value.serviceSliders?.serviceSliders?.elementAt(index);
                    return ServiceCard(
                        image: services!.image.toString(),
                        name: services.titileText!);
                  },
                );
              }),
            ),
            Expanded(
              child: Container(
                color: backgroundColor,
                padding: const EdgeInsets.all(20),
                child: Consumer<ServicesProvider>(
                    builder: (context, value, child) {
                  if (value.services?.services == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15),
                      itemCount: value.services!.services!.length,
                      itemBuilder: (context, index) {
                        var serviceDetail =
                            value.services?.services?.elementAt(index);
                        return InkWell(
                            focusColor: primaryColor,
                            hoverColor: primaryColor,
                            splashColor: primaryColor,
                            highlightColor: primaryColor,
                            child:
                                SpecialitiesCard(specialities: serviceDetail, noColor:true),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProcedurePage(service: serviceDetail!)),
                              );
                            });
                      });
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
