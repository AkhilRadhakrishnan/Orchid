import 'package:orchid/models/date_timeslot.dart';
import 'package:orchid/models/doctor.dart';
import 'package:orchid/models/my_appoinment.dart';
import 'package:orchid/models/nurse.dart';
import 'package:orchid/models/service_slider.dart';
import 'package:orchid/models/services.dart';
import 'package:orchid/models/slider.dart';
import 'package:orchid/models/specialities.dart';
import 'package:orchid/services/api_provider.dart';

class Repository {
  final _apiProvider = ApiProvider();

  Future<DoctorModel?> fetchDoctors() async {
    return await _apiProvider.getDoctors();
  }

  Future<NurseModel?> fetchNurses() async {
    return await _apiProvider.getNurses();
  }

  Future<SpecialitiesModel?> fetchSpecialities() async {
    return await _apiProvider.getSpecialities();
  }

  Future<SliderModel?> fetchSliders() async {
    return await _apiProvider.getSliders();
  }

  Future<ServicesModel?> fetchServices() async {
    return await _apiProvider.getServices();
  }

  Future<ServiceSliderModel?> fetchServiceSliders() async {
    return await _apiProvider.getServiceSliders();
  }

  Future<DateModel?> fetchInactiveAppoinmentDate() async {
    return await _apiProvider.fetchInactiveAppoinmentDate();
  }

  Future<TimeSlotModel?> fetchTimeSlots() async {
    return await _apiProvider.fetchTimeSlots();
  }

  Future<MyAppoinmentModel?> fetchUpcoming() async {
    return await _apiProvider.fetchUpcoming();
  }

  Future<MyAppoinmentModel?> fetchPast() async {
    return await _apiProvider.fetchPast();
  }

  validateLogin({mobile}) async {
    return await _apiProvider.validateLogin(mobile: mobile);
  }

  validateRegister({data}) async {
    return await _apiProvider.validateRegister(data: data);
  }

  validateOtp({mobile, otp}) async {
    return await _apiProvider.validateOtp(mobile: mobile, otp: otp);
  }

  rescheduleAppointment({data}) async {
    return await _apiProvider.rescheduleAppointment(data: data);
  }

  cancelAppointment({id}) async {
    return await _apiProvider.cancelAppointment(id: id);
  }

  confirmAppointment({data}) async {
    return await _apiProvider.confirmAppointment(data: data);
  }
}
