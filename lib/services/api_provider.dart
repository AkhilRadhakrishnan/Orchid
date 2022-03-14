import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:orchid/models/date_timeslot.dart';
import 'package:orchid/models/doctor.dart';
import 'package:orchid/models/my_appointment.dart';
import 'package:orchid/models/nurse.dart';
import 'package:orchid/models/service_slider.dart';
import 'package:orchid/models/services.dart';
import 'package:orchid/models/slider.dart';
import 'package:orchid/models/specialities.dart';
import 'error_handling.dart';
import 'network.dart';

class ApiProvider {
  static const baseUrl = "https://servconmain.com/orchid/api/";

  Network auth = Network();

  Future<DoctorModel?> getDoctors() async {
    try {
      http.Response response = await auth.getRequest(url: baseUrl + "Docters");
      if (response.statusCode == 200) {
        return DoctorModel.fromJson(json.decode(response.body));
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
    return null;
  }

  Future<NurseModel?> getNurses() async {
    try {
      http.Response response = await auth.getRequest(url: baseUrl + "nurse");
      if (response.statusCode == 200) {
        return NurseModel.fromJson(json.decode(response.body));
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
    return null;
  }

  Future<SpecialitiesModel?> getSpecialities() async {
    try {
      http.Response response =
          await auth.getRequest(url: baseUrl + "specialities");
      if (response.statusCode == 200) {
        return SpecialitiesModel.fromJson(json.decode(response.body));
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
    return null;
  }

  Future<SliderModel?> getSliders() async {
    try {
      http.Response response =
          await auth.getRequest(url: baseUrl + "SliderMain");
      if (response.statusCode == 200) {
        return SliderModel.fromJson(json.decode(response.body));
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
    return null;
  }

  Future<ServicesModel?> getServices() async {
    try {
      http.Response response =
          await auth.getRequest(url: baseUrl + "MainService");
      if (response.statusCode == 200) {
        return ServicesModel.fromJson(json.decode(response.body));
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
    return null;
  }

  Future<ServiceSliderModel?> getServiceSliders() async {
    try {
      http.Response response = await auth.getRequest(url: baseUrl + "slider");
      if (response.statusCode == 200) {
        return ServiceSliderModel.fromJson(json.decode(response.body));
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
    return null;
  }

  Future<DateModel?> fetchInactiveAppointmentDate() async {
    try {
      http.Response response = await auth.getRequest(url: baseUrl + "Holidays");
      if (response.statusCode == 200) {
        return DateModel.fromJson(json.decode(response.body));
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
    return null;
  }

  // Future<TimeSlotModel?> fetchTimeSlots() async {
  //   try {
  //     http.Response response =
  //         await auth.getRequest(url: baseUrl + "Appointment/timeslotForDoctor");
  //     if (response.statusCode == 200) {
  //       return TimeSlotModel.fromJson(json.decode(response.body));
  //     }
  //   } catch (error) {
  //     jsonDecode(error.toString())["message"];
  //     return null;
  //   }
  //   return null;
  // }

  Future<MyAppoinmentUpcomingModel?> fetchUpcoming() async {
    try {
      http.Response response =
          await auth.getAuthRequest(url: baseUrl + "Notification/upcoming");
      if (response.statusCode == 200) {
        return MyAppoinmentUpcomingModel.fromJson(json.decode(response.body));
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
    return null;
  }

  Future<MyAppoinmentPastModel?> fetchPast() async {
    try {
      http.Response response =
          await auth.getAuthRequest(url: baseUrl + "Notification/past");
      if (response.statusCode == 200) {
        return MyAppoinmentPastModel.fromJson(json.decode(response.body));
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
    return null;
  }

  validateLogin({mobile}) async {
    try {
      var data = {"mobile": mobile};
      http.Response response =
          await auth.postRequest(url: baseUrl + "Getotp", data: data);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return errorHandling(response.statusCode);
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
  }

  validateRegister({data}) async {
    try {
      http.Response response = await auth.postRequest(
          url: baseUrl + "authentication/registration", data: data);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return errorHandling(response.statusCode);
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
  }

  validateOtp({mobile, otp}) async {
    try {
      var data = {"mobile": mobile, "otp": otp};
      http.Response response =
          await auth.postAuthRequest(url: baseUrl + "Login", data: data);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return errorHandling(response.statusCode);
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
  }

  logout() async {
    try {
      http.Response response = await auth.getRequest(url: baseUrl + "logout");
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
  }

  rescheduleAppointment({data}) async {
    try {
      http.Response response = await auth.postAuthRequest(
          url: baseUrl + "Appointment/update", data: data);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return errorHandling(response.statusCode);
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
  }

  cancelAppointment({id}) async {
    try {
      http.Response response =
          await auth.getAuthRequest(url: baseUrl + "Appointment/cancel/" + id);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
  }

  confirmAppointment({data}) async {
    try {
      http.Response response = await auth.postAuthRequest(
          url: baseUrl + "ConfirmAppointment", data: data);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return errorHandling(response.statusCode);
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
  }

  editUser({data}) async {
    try {
      http.Response response = await auth.postAuthRequest(
          url: baseUrl + "Profile/profile_post", data: data);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return errorHandling(response.statusCode);
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
  }

  enquiryAppointment({data}) async {
    try {
      http.Response response = await auth.postAuthRequest(
          url: baseUrl + "ConfirmAppointment/service", data: data);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return errorHandling(response.statusCode);
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
  }

  fetchTimeSlots({data}) async {
    try {
      http.Response response = await auth.postAuthRequest(
          url: baseUrl + "Appointment/timeslotForDoctor", data: data);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return errorHandling(response.statusCode);
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
  }

  picUser({data}) async {
    try {
      http.Response response = await auth.postAuthRequest(
          url: baseUrl + "profile/upload_profile_photo", data: data);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return errorHandling(response.statusCode);
      }
    } catch (error) {
      jsonDecode(error.toString())["message"];
      return null;
    }
  }
}
