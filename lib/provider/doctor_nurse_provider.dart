import 'package:flutter/cupertino.dart';
import 'package:orchid/models/doctor.dart';
import 'package:orchid/models/nurse.dart';
import 'package:orchid/services/repository.dart';


class DoctorProvider with ChangeNotifier {
  final _repository = Repository();

  DoctorModel? _doctors;
  DoctorModel? get doctors => _doctors;

  set doctors(DoctorModel? doctorModel) {
    _doctors = doctorModel;
    notifyListeners();
  }

  Future<void> fetchDoctors() async {
    doctors = await _repository.fetchDoctors();
    notifyListeners();
  }
}

class NurseProvider with ChangeNotifier {
  final _repository = Repository();

  NurseModel? _nurses;
  NurseModel? get nurses => _nurses;

  set nurses(NurseModel? nurseModel) {
    _nurses = nurseModel;
    notifyListeners();
  }

  Future<void> fetchNurses() async {
    nurses = await _repository.fetchNurses();
    notifyListeners();
  }
}
