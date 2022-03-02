import 'package:flutter/material.dart';
import 'package:orchid/models/services.dart';
import 'package:orchid/models/specialities.dart';
import 'package:orchid/services/repository.dart';


class SpecialitiesProvider with ChangeNotifier {
  final _repository = Repository();

  SpecialitiesModel? _specialities;
  SpecialitiesModel? get specialities => _specialities;

  set specialities(SpecialitiesModel? SpecialitiesModel) {
    _specialities = SpecialitiesModel;
    notifyListeners();
  }

  Future<void> fetchSpecialities() async {
    specialities = await _repository.fetchSpecialities();
    notifyListeners();
  }
}


class ServicesProvider with ChangeNotifier {
  final _repository = Repository();

  ServicesModel? _services;
  ServicesModel? get services => _services;

  set services(ServicesModel? ServicesModel) {
    _services = ServicesModel;
    notifyListeners();
  }

  Future<void> fetchServices() async {
    services = await _repository.fetchServices();
    notifyListeners();
  }
}