import 'package:flutter/material.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:orchid/models/my_appointment.dart';
import 'package:orchid/views/doctor_appointment.dart';
import 'package:orchid/views/my_appointments.dart';

import '../models/doctor.dart';
import '../services/repository.dart';

class MyAppointmentCard extends StatelessWidget {
  int? index;
  Appointment appointment;
  MyAppointmentCard({Key? key, required this.index, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.white),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Date'),
                  const SizedBox(height: 5),
                  Text(appointment.date!)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Time'),
                  const SizedBox(height: 5),
                  Text(appointment.time!),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Doctor"),
                  const SizedBox(height: 5),
                  Text(appointment.doctor!),
                ],
              )
            ],
          ),
          sizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Appointment Type: '),
              Text(appointment.speciality!),
            ],
          ),
          if (index == 0)
            const Divider(
              color: Colors.black,
              thickness: 0.1,
            ),
          if (index == 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: const Text("Cancel"),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(120, 30),
                    onPrimary: Colors.white,
                    primary: Colors.red,
                    elevation: 0,
                    minimumSize: const Size(80, 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    _cancelorRescheduleApi('cancel', context);
                  },
                ),
                ElevatedButton(
                  child: const Text("Reschedule"),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(120, 30),
                    onPrimary: Colors.white,
                    primary: const Color(0xff8cc645),
                    elevation: 0,
                    minimumSize: const Size(80, 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    _cancelorRescheduleApi('reschedule', context);
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  _cancelorRescheduleApi(status, context) async {
    if (status == 'cancel') {
      dynamic res = await Repository().cancelAppointment(id: appointment.id);
      if (res['status']) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyAppointments()));
      }
    } else {
      var data = {
        'id': appointment.dr_id,
        'image': appointment.image,
        "name": appointment.doctor,
        "speciality": appointment.speciality,
        "description" : appointment.description
      };
      Doctor doctor = Doctor.fromJson(data);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => DoctorAppointment(doctor: doctor,appointmentStatus: "update",appointment: appointment)));
    }
  }
}
