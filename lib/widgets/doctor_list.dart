import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/provider/doctor_nurse_provider.dart';
import 'package:provider/provider.dart';
import '../views/doctor_appointment.dart';
import 'doctor_card.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Specialists',
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(15),
        child: Consumer<DoctorProvider>(builder: (context, value, child) {
          if (value.doctors?.doctors == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              itemCount: value.doctors?.doctors?.length,
              itemBuilder: (context, index) {
                var doctor = value.doctors?.doctors?.elementAt(index);
                return InkWell(
                    child: DoctorCard(person: doctor),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Appointment(doctor: doctor)),
                      );
                    });
              });
        }),
      )),
    );
  }
}
