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
import 'package:orchid/views/services_page.dart';
import 'package:orchid/widgets/service_card.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/repository.dart';
import '../util/shared_preferences_helper.dart';
import '../widgets/appointment_time_tab.dart';
import '../widgets/doctor_card.dart';
import 'landing_page.dart';

class ProcedurePage extends StatefulWidget {
  final Services service;
  const ProcedurePage({Key? key, required this.service}) : super(key: key);

  @override
  State<ProcedurePage> createState() => _ProcedurePageState();

  static _ProcedurePageState? of(BuildContext context) =>
      context.findAncestorStateOfType<_ProcedurePageState>();
}

class _ProcedurePageState extends State<ProcedurePage> {
  String _selectedTime = "";
  set selectedTime(String value) => setState(() => _selectedTime = value);

  final DatePickerController _dateController = DatePickerController();
  String _selectedDateView = formatDate(DateTime.now()).text;
  final DateTime _selectedDateApi = DateTime.now();
  int current = 0;
  String? selectedNurse = "";
  final timeSlots = {
    'timeslots': {
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
    }
  };
  TimeSlotModel timeSlotModel = TimeSlotModel();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    timeSlotModel = TimeSlotModel.fromJson(timeSlots);
    context.read<NurseProvider>().fetchNurses();
    context.read<AppointmentProvider>().fetchInactiveAppointmentDate();
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
        centerTitle: true,
        title: const Text(
          'Service Enquiry',
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
              Text(_selectedDateView.toString()),
              sizedBox,
              Consumer<AppointmentProvider>(builder: (context, value, child) {
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
                      _selectedDateView = formatDate(date).text;
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
                    timeSlotsValue: timeSlotModel,
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
                              selected: selectedNurse == nurse?.id),
                          onTap: () {
                            setState(() {
                              selectedNurse = nurse?.id;
                            });
                          });
                    },
                  );
                }),
              ),
              sizedBox,
              ElevatedButton(
                onPressed:
                    (_selectedTime == "" || selectedNurse == "" || isLoading)
                        ? null
                        : () async {
                            await takeEnquiry();
                          },
                child: const Text(
                  'Send Enquiry',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                style: elevatedButton(MediaQuery.of(context).size.width),
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

  takeEnquiry() async {
    setState(() {
      isLoading = true;
    });
    var cDate = DateFormat('yyyy-MM-dd').format(_selectedDateApi);
    var data = {
      "appointment_date": cDate,
      "app_time": _selectedTime,
      "nurse_id": selectedNurse,
      "service_pid": widget.service.id,
    };

    if (await SharedPreferencesHelper.getAccessToken() == null) {
      await SharedPreferencesHelper.saveServiceDetails(widget.service);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LandingPage()));
    } else {
      dynamic res = await Repository().enquiryAppointment(data: data);
      if (res["status"]) {
        var snackBar = resSnackBar(
            'Service Enquiry sent! Will contact back you soon', false);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ServicesPage()));
      } else {
        var snackBar = resSnackBar(res['message'], true);
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar)
            .closed
            .then((value) => {setState(() => isLoading = false)});
      }
    }
  }
}
