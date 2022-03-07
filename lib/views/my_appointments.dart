import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:orchid/models/my_appointment.dart';
import 'package:orchid/provider/my_appoinment_provider.dart';
import 'package:orchid/widgets/my_appoinment_card.dart';
import 'package:provider/provider.dart';

class MyAppointments extends StatefulWidget {
  MyAppointments({Key? key}) : super(key: key);

  @override
  State<MyAppointments> createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    context.read<MyAppoinmentProvider>().fetchUpcoming();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _activeTabIndex = _tabController.index;
          if (_activeTabIndex == 0) {
            context.read<MyAppoinmentProvider>().fetchUpcoming();
          } else {
            context.read<MyAppoinmentProvider>().fetchPast();
          }
        });
      }
    });
    return Scaffold(
        backgroundColor: backgroundColor,
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
              'My Appointments',
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TabBar(
                unselectedLabelColor: bodyTextColor,
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .01),
                indicator:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                tabs: [
                  SizedBox(
                    height: 30,
                    child: Tab(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: _activeTabIndex == 0
                                  ? primaryColor
                                  : Colors.white),
                          alignment: Alignment.center,
                          child: const Text("Upcoming")),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: _activeTabIndex == 1
                                ? primaryColor
                                : Colors.white),
                        alignment: Alignment.center,
                        child: const Text("Past"),
                      ),
                    ),
                  )
                ],
              ),
              sizedBox,
              SizedBox(
                height: MediaQuery.of(context).size.height * .77,
                child: SizedBox(
                  child: Consumer<MyAppoinmentProvider>(
                      builder: (context, value, child) {
                    if (_activeTabIndex == 0
                        ? value.upcoming?.appointmentUpcoming == null
                        : value.past?.appointmentPast == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 15);
                      },
                      itemCount: _activeTabIndex == 0
                          ? value.upcoming!.appointmentUpcoming!.length
                          : value.past!.appointmentPast!.length,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Appointment? appointment = _activeTabIndex == 0
                            ? value.upcoming?.appointmentUpcoming
                                ?.elementAt(index)
                            : value.past?.appointmentPast?.elementAt(index);
                        return MyAppoinmentCard(
                            index: _activeTabIndex, appointment: appointment!);
                      },
                    );
                  }),
                ),
              )
            ],
          ),
        ));
  }
}
