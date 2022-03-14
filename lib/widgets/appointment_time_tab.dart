import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/models/date_timeslot.dart';
import 'package:orchid/views/my_appointments.dart';
import 'package:orchid/views/service_booking_page.dart';

import '../views/doctor_appointment.dart';

typedef void StringCallback(String val);

class TimeSlotTab extends StatefulWidget {
  final TimeSlotModel timeSlotsValue;
  String? selectedTime;
  TimeSlotTab({Key? key, required this.timeSlotsValue, this.selectedTime})
      : super(key: key);
  @override
  _TimeSlotTabState createState() => _TimeSlotTabState();

  static _TimeSlotTabState? of(BuildContext context) =>
      context.findAncestorStateOfType<_TimeSlotTabState>();
}

class _TimeSlotTabState extends State<TimeSlotTab>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: "Morning Slots"),
    const Tab(text: "Evening Slots")
  ];

  late TabController _tabController;
  String selectedTime = "";

  @override
  void initState() {
    super.initState();
    if (widget.selectedTime != null) {
      selectedTime = widget.selectedTime!;
    }
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      // margin: const EdgeInsets.all(8.0),
      child: DefaultTabController(
        child: LayoutBuilder(
          builder:
              (BuildContext tabContext, BoxConstraints viewportConstraints) {
            return Scaffold(
              backgroundColor: backgroundColor,
              appBar: TabBar(
                controller: _tabController,
                tabs: myTabs,
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                labelColor: Colors.grey,
                indicatorColor: primaryColor,
                unselectedLabelColor: Colors.grey,
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  if (widget.timeSlotsValue.timeslots?.am!.length == 0)
                    const Center(child: Text('No Appointment slots available')),
                  if (widget.timeSlotsValue.timeslots?.am!.length != 0)
                    GridView.builder(
                        itemCount: widget.timeSlotsValue.timeslots?.am!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, childAspectRatio: 1.8),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var am = widget.timeSlotsValue.timeslots!.am!
                              .elementAt(index);
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedTime = am;
                                DoctorAppointment.of(context)?.selectedTime =
                                    selectedTime;
                                ProcedurePage.of(context)?.selectedTime =
                                    selectedTime;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 10, right: 10, bottom: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: selectedTime == am
                                    ? primaryColor
                                    : Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  am,
                                  style: TextStyle(
                                    color: selectedTime == am
                                        ? Colors.white
                                        : bodyTextColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  if (widget.timeSlotsValue.timeslots?.pm!.length == 0)
                    const Center(child: Text('No Appointment slots available')),
                  if (widget.timeSlotsValue.timeslots?.pm!.length != 0)
                    GridView.builder(
                        itemCount: widget.timeSlotsValue.timeslots!.pm?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, childAspectRatio: 1.8),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var pm = widget.timeSlotsValue.timeslots!.pm!
                              .elementAt(index);
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedTime = pm;
                                DoctorAppointment.of(context)?.selectedTime =
                                    selectedTime;
                                ProcedurePage.of(context)?.selectedTime =
                                    selectedTime;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 10, right: 10, bottom: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: selectedTime == pm
                                    ? primaryColor
                                    : Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  pm,
                                  style: TextStyle(
                                    color: selectedTime == pm
                                        ? Colors.white
                                        : bodyTextColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                ],
              ),
            );
          },
        ),
        length: 2,
      ),
    );
  }
}
