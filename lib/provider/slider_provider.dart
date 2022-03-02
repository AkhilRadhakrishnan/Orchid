import 'package:flutter/material.dart';
import 'package:orchid/models/service_slider.dart';
import 'package:orchid/models/slider.dart';
import 'package:orchid/services/repository.dart';


class SliderProvider with ChangeNotifier {
  final _repository = Repository();

  SliderModel? _sliders;
  SliderModel? get sliders => _sliders;

  set sliders(SliderModel? SliderModel) {
    _sliders = SliderModel;
    notifyListeners();
  }

  Future<void> fetchSliders() async {
    _sliders = await _repository.fetchSliders();
    notifyListeners();
  }
}


class ServiceSliderProvider with ChangeNotifier {
  final _repository = Repository();

  ServiceSliderModel? _serviceSliders;
  ServiceSliderModel? get serviceSliders => _serviceSliders;

  set serviceSliders(ServiceSliderModel? ServiceSliderModel) {
    _serviceSliders = ServiceSliderModel;
    notifyListeners();
  }

  Future<void> fetchServiceSliders() async {
    _serviceSliders = await _repository.fetchServiceSliders();
    notifyListeners();
  }
}