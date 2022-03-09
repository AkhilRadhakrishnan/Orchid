import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:orchid/models/date_timeslot.dart';
import 'package:orchid/models/doctor.dart';
import 'package:orchid/models/my_appointment.dart';
import 'package:orchid/provider/date_time_provider.dart';
import 'package:orchid/util/formats.dart';
import 'package:orchid/util/shared_preferences_helper.dart';
import 'package:orchid/views/landing_page.dart';
import 'package:orchid/views/my_appointments.dart';
import 'package:provider/provider.dart';

import '../services/repository.dart';
import '../widgets/appointment_time_tab.dart';
import '../widgets/expandable_text.dart';
import 'package:intl/intl.dart';

class DoctorAppointment extends StatefulWidget {
  Doctor doctor;
  String? appointmentStatus;
  Appointment? appointment;
  DoctorAppointment(
      {required this.doctor,
      this.appointmentStatus,
      this.appointment,
      Key? key})
      : super(key: key);

  @override
  State<DoctorAppointment> createState() => _DoctorAppointmentState();
  static _DoctorAppointmentState? of(BuildContext context) =>
      context.findAncestorStateOfType<_DoctorAppointmentState>();
}

class _DoctorAppointmentState extends State<DoctorAppointment> {
  String _selectedTime = "";

  set selectedTime(String value) => setState(() => _selectedTime = value);

  final DatePickerController _dateController = DatePickerController();
  String _selectedDateView = formatDate(DateTime.now()).text;
  DateTime _selectedDateApi = DateTime.now();
  bool isExpanded = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.appointmentStatus == 'update') {
      _selectedDateView =
          formatDate(DateTime.parse(widget.appointment!.date!)).text;
      _selectedDateApi = DateTime.parse(widget.appointment!.date!);
      _selectedTime = widget.appointment!.time!;
    }
    context.read<AppointmentProvider>().fetchInactiveAppointmentDate();
    context.read<AppointmentProvider>().fetchTimeSlots();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 35,
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
            'Appointment',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 130,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 100,
                        width: 120,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Image.network(
                          widget.doctor.image!,
                          height: 130,
                          width: 140,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctor.name!,
                        style: theme.textTheme.headline6,
                      ),
                      Text(
                        widget.doctor.speciality!,
                        style: theme.textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ExpandableText(
                  widget.doctor.description!,
                  trimLines: 2,
                ),
              ],
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
                initialSelectedDate: _selectedDateApi,
                selectionColor: primaryColor,
                selectedTextColor: Colors.white,
                inactiveDates: getHolidays(value.dateList?.holidays),
                deactivatedColor: Colors.grey,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _selectedDateView = formatDate(date).text;
                    _selectedDateApi = date;
                  });
                },
              );
            }),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 200,
                child: Consumer<AppointmentProvider>(
                    builder: (context, value, child) {
                  if (value.timeSlot == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return TimeSlotTab(
                      timeSlots: value.timeSlot!,
                      selectedTime: widget.appointmentStatus == 'update'
                          ? widget.appointment!.time
                          : '');
                })),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: (_selectedTime == "" || isLoading)
                  ? null
                  : () async {
                      await takeAppointment();
                    },
              child: Text(
                (widget.appointmentStatus == 'update'
                        ? "Reschedule"
                        : "Confirm") +
                    " Appointment",
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal),
              ),
              style: elevatedButton(MediaQuery.of(context).size.width),
            ),
          ],
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

  takeAppointment() async {
    setState(() {
      isLoading = true;
    });
    var cDate = DateFormat('yyyy-MM-dd').format(_selectedDateApi);
    var newAppnmt = {
      "appointment_date": cDate,
      "app_time": _selectedTime,
      "docter_id": widget.doctor.id,
    };
    var updateAppnmt = {
      "app_id": widget.appointment?.id,
      "app_date": cDate,
      "time_slot": _selectedTime
    };

    if (await SharedPreferencesHelper.getAccessToken() == null) {
      await SharedPreferencesHelper.saveDoctorDetails(widget.doctor);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LandingPage()));
    } else {
      dynamic res;
      if (widget.appointmentStatus == 'update') {
        res = await Repository().rescheduleAppointment(data: updateAppnmt);
      } else {
        res = await Repository().confirmAppointment(data: newAppnmt);
      }
      if (res["status"]) {
        isLoading = false;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyAppointments()));
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
