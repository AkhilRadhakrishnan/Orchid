import 'package:flutter/cupertino.dart';
import 'package:orchid/models/date_timeslot.dart';
import 'package:orchid/services/repository.dart';

class AppoinmentProvider with ChangeNotifier {
  final _repository = Repository();

  DateModel? _dateList;
  DateModel? get dateList => _dateList;

 TimeSlotModel? _timeslot;
 TimeSlotModel? get timeSlot => _timeslot;

  set dateList(DateModel? dateList) {
    _dateList = dateList;
    notifyListeners();
  }
  set timeSlot(TimeSlotModel? timeSlot) {
    _timeslot = timeSlot;
    notifyListeners();
  }

  Future<void> fetchInactiveAppoinmentDate() async {
    dateList = await _repository.fetchInactiveAppoinmentDate();
    notifyListeners();
  }

  Future<void> fetchTimeSlots() async {
    timeSlot = await _repository.fetchTimeSlots();
    notifyListeners();
  }
}
