import 'dart:convert';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:orchid/models/date_timeslot.dart';
import 'package:orchid/models/services.dart';
import 'package:orchid/provider/date_time_provider.dart';
import 'package:orchid/provider/doctor_nurse_provider.dart';
import 'package:orchid/util/formats.dart';
import 'package:orchid/views/my_appointments.dart';
import 'package:orchid/widgets/service_card.dart';
import 'package:provider/provider.dart';

import '../widgets/appointment_time_tab.dart';
import '../widgets/doctor_card.dart';

class ProcedurePage extends StatefulWidget {
  final Services service;
  const ProcedurePage({Key? key, required this.service}) : super(key: key);

  @override
  State<ProcedurePage> createState() => _ProcedurePageState();
}

class _ProcedurePageState extends State<ProcedurePage> {
  int current = 0;
  int? selectedIndex;
  final DatePickerController _dateController = DatePickerController();
  String _selectedDate = formatDate(DateTime.now()).text;
  // TimeSlotModel timeSlots = TimeSlotModel();
  final timeSlots = {
    "am": [
      "09:00 am",
      "09:15 am",
      "09:30 am",
      "09:45 am",
      "10:00 am",
      "10:15 am",
      "10:30 am",
      "10:45 am",
      "11:00 am",
      "11:15 am",
      "11:30 am",
      "11:45 am"
    ],
    "pm": [
      "05:00 pm",
      "05:15 pm",
      "05:30 pm",
      "05:45 pm",
      "06:00 pm",
      "06:15 pm",
      "06:30 pm",
      "06:45 pm",
      "07:00 pm",
      "07:15 pm",
      "07:30 pm",
      "07:45 pm",
      "08:00 pm",
      "08:15 pm",
      "08:30 pm",
      "08:45 pm",
      "09:00 pm",
      "09:15 pm",
      "09:30 pm",
      "09:45 pm",
      "10:00 pm",
      "10:15 pm",
      "10:30 pm",
      "10:45 pm",
      "11:00 pm",
      "11:15 pm",
      "11:30 pm",
      "11:45 pm",


    ]
  };
  var timeSlotModel;

  @override
  void initState() {
    super.initState();
    timeSlotModel = timeSlotModelFromJson(jsonEncode(timeSlots));
    context.read<NurseProvider>().fetchNurses();
    context.read<AppoinmentProvider>().fetchInactiveAppoinmentDate();
  }

  @override
  Widget build(BuildContext context) {
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
            'Service Enquiry',
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ServiceCard(
                image: widget.service.image.toString(),
                name: widget.service.title.toString(),
                fullWidth: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(_selectedDate.toString()),
              sizedBox,
              Consumer<AppoinmentProvider>(builder: (context, value, child) {
                if (value.dateList == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return DatePicker(
                  DateTime.now(),
                  width: 60,
                  height: 80,
                  controller: _dateController,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: primaryColor,
                  selectedTextColor: Colors.white,
                  deactivatedColor: Colors.grey,
                  inactiveDates: getHolidays(value.dateList?.holidays),
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedDate = formatDate(date).text;
                    });
                  },
                );
              }),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 185,
                  child: TimeSlotTab(
                    time: timeSlotModel,
                  )),
              sizedBox,
              const Text('Choose Nurse'),
              sizedBox,
              SizedBox(
                height: 200.0,
                child:
                    Consumer<NurseProvider>(builder: (context, value, child) {
                  if (value.nurses?.nurses == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 15);
                    },
                    itemCount: value.nurses!.nurses!.length,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var nurse = value.nurses?.nurses?.elementAt(index);
                      return InkWell(
                          child: DoctorCard(
                              person: nurse,
                              noPatients: true,
                              selected: selectedIndex == index),
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          });
                    },
                  );
                }),
              ),
              sizedBox,
              ElevatedButton(
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: const [
                //     Text("Confirm Appointment"),
                //   ],
                // ),
                child: const Text("Confirm Appointment"),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: primaryColor,
                  elevation: 0,
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyAppointments(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getHolidays(List<Holidays>? holidays) {
    List<DateTime> holidayList = [];
    holidays?.forEach((day) {
      holidayList.add(DateTime.parse(day.date!));
    });
    return holidayList;
  }
}
