
import 'package:flutter/cupertino.dart';
import 'package:orchid/models/my_appoinment.dart';
import 'package:orchid/services/repository.dart';

class MyAppoinmentProvider with ChangeNotifier {
  final _repository = Repository();

  MyAppoinmentModel? _upcoming;
  MyAppoinmentModel? get upcoming => _upcoming;

  set upcoming(MyAppoinmentModel?  MyAppoinmentModel) {
    _upcoming = MyAppoinmentModel;
    notifyListeners();
  }

  Future<void> fetchUpcoming() async {
    upcoming = await _repository.fetchUpcoming();
    notifyListeners();
  }

  Future<void> fetchPast() async {
    upcoming = await _repository.fetchPast();
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