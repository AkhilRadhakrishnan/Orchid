import 'package:flutter/material.dart';
import 'package:orchid/views/doctor_appointment.dart';

import '../services/repository.dart';

class MyAppoinmentCard extends StatelessWidget {
  int index;
  final dynamic upcoming;
  MyAppoinmentCard({Key? key, required this.index, required this.upcoming})
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
                  Text(upcoming.date)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Time'),
                  const SizedBox(height: 5),
                  Text(upcoming.time),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Doctor"),
                  const SizedBox(height: 5),
                  Text(upcoming.doctor),
                ],
              )
            ],
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Appointment Type'),
                  const SizedBox(height: 5),
                  Text(upcoming.type),
                ],
              ),
              ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(index == 0 ? "Cancel" : "Reschedule"),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: index == 0 ? Colors.red : const Color(0xff8cc645),
                  elevation: 0,
                  minimumSize: const Size(80, 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () async {
                  if (index == 0) {
                    var id = 5;
                    dynamic res = await Repository().cancelAppointment(id:id); // API Call
                    // Do whatever if cancel
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Appointment(doctor: upcoming)));
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
