import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/models/date_timeslot.dart';
import 'package:orchid/views/my_appointments.dart';
import 'package:orchid/views/service_booking_page.dart';

import '../views/doctor_appointment.dart';

typedef void StringCallback(String val);

class TimeSlotTab extends StatefulWidget {
  final TimeSlotModel timeSlots;
  String? selectedTime;
  TimeSlotTab({Key? key, required this.timeSlots, this.selectedTime})
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
                  GridView.builder(
                      itemCount: widget.timeSlots.am?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 1.8),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedTime =
                                  widget.timeSlots.am!.elementAt(index);
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
                              color: selectedTime ==
                                      widget.timeSlots.am!.elementAt(index)
                                  ? primaryColor
                                  : Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                widget.timeSlots.am!.elementAt(index),
                                style: TextStyle(
                                  color: selectedTime ==
                                          widget.timeSlots.am!.elementAt(index)
                                      ? Colors.white
                                      : bodyTextColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  GridView.builder(
                      itemCount: widget.timeSlots.pm?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 1.8),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedTime =
                                  widget.timeSlots.pm!.elementAt(index);
                              DoctorAppointment.of(context)?.selectedTime =
                                  selectedTime;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 10, right: 10, bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: selectedTime ==
                                      widget.timeSlots.pm!.elementAt(index)
                                  ? primaryColor
                                  : Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                widget.timeSlots.pm!.elementAt(index),
                                style: TextStyle(
                                  color: selectedTime ==
                                          widget.timeSlots.pm!.elementAt(index)
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
