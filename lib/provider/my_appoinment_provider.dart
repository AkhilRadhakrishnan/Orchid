import 'package:flutter/cupertino.dart';
import 'package:orchid/models/my_appointment.dart';
import 'package:orchid/services/repository.dart';

class MyAppointmentProvider with ChangeNotifier {
  final _repository = Repository();

  MyAppoinmentUpcomingModel? _upcoming;
  MyAppoinmentUpcomingModel? get upcoming => _upcoming;

  MyAppoinmentPastModel? _past;
  MyAppoinmentPastModel? get past => _past;

  set upcoming(MyAppoinmentUpcomingModel? MyAppoinmentModel) {
    _upcoming = MyAppoinmentModel;
    notifyListeners();
  }

  set past(MyAppoinmentPastModel? MyAppoinmentModel) {
    _past = MyAppoinmentModel;
    notifyListeners();
  }

  Future<void> fetchUpcoming() async {
    upcoming = await _repository.fetchUpcoming();
    notifyListeners();
  }

  Future<void> fetchPast() async {
    past = await _repository.fetchPast();
    notifyListeners();
  }

  Future<void> rescheduleAppointment() async {
    upcoming = await _repository.rescheduleAppointment();
    notifyListeners();
  }

  Future<void> cancelAppointment() async {
    upcoming = await _repository.rescheduleAppointment();
    notifyListeners();
  }

  Future<void> confirmAppointment() async {
    upcoming = await _repository.confirmAppointment();
    notifyListeners();
  }
}
