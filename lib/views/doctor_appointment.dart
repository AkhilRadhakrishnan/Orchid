import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:orchid/models/date_timeslot.dart';
import 'package:orchid/models/doctor.dart';
import 'package:orchid/provider/date_time_provider.dart';
import 'package:orchid/util/formats.dart';
import 'package:orchid/util/shared_preferences_helper.dart';
import 'package:orchid/views/landing_page.dart';
import 'package:orchid/views/my_appointments.dart';
import 'package:provider/provider.dart';

import '../services/repository.dart';
import '../widgets/appointment_time_tab.dart';
import '../widgets/expandable_text.dart';
import 'login.dart';
import 'package:intl/intl.dart';

class DoctorAppointment extends StatefulWidget {
  Doctor doctor;
  DoctorAppointment({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DoctorAppointment> createState() => _DoctorAppointmentState();
  static _DoctorAppointmentState? of(BuildContext context) =>
      context.findAncestorStateOfType<_DoctorAppointmentState>();
}

class _DoctorAppointmentState extends State<DoctorAppointment> {
  String _selectedTime = "";

  set selectedTime(String value) => setState(() => _selectedTime = value);

  final DatePickerController _dateController = DatePickerController();
  String _selectedDate = formatDate(DateTime.now()).text;
  DateTime _apiDate = DateTime.now();
  String descText =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'
      'standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'
      ' It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.'
      ' It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with '
      'desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();// need to be removed
    context.read<AppoinmentProvider>().fetchInactiveAppoinmentDate();
    context.read<AppoinmentProvider>().fetchTimeSlots();
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
              children: const <Widget>[
                ExpandableText(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque scelerisque efficitur posuere. Curabitur tincidunt placerat diam ac efficitur. Cras rutrum egestas nisl vitae pulvinar. Donec id mollis diam, id hendrerit neque. Donec accumsan efficitur libero, vitae feugiat odio fringilla ac. Aliquam a turpis bibendum, varius erat dictum, feugiat libero. Nam et dignissim nibh. Morbi elementum varius elit, at dignissim ex accumsan a',
                  trimLines: 3,
                ),
              ],
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
                inactiveDates: getHolidays(value.dateList?.holidays),
                deactivatedColor: Colors.grey,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _selectedDate = formatDate(date).text;
                    _apiDate = date;
                  });
                },
              );
            }),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 200,
                child: Consumer<AppoinmentProvider>(
                    builder: (context, value, child) {
                  if (value.timeSlot == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return TimeSlotTab(time: value.timeSlot!);
                })),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Confirm Appointment"),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: primaryColor,
                  elevation: 0,
                  minimumSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: (_selectedTime == "")
                    ? null
                    : () async {
                        await takeAppoinment();
                      })
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

  takeAppoinment() async {
    if (await SharedPreferencesHelper.getAccessToken() == '') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LandingPage()));
    } else {
      var cDate = DateFormat('yyyy-MM-dd').format(_apiDate);
      var data = {
        "appointment_date": cDate,
        "app_time": _selectedTime,
        "docter_id": widget.doctor.id,
      };

      dynamic res = await Repository().confirmAppointment(data: data);
      if (res["status"]) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyAppointments()));
      } else {
        return "User not exist";
      }
    }
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => LandingPage()));
  }
}
