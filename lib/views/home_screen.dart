import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:orchid/helpers/colors.dart';
import 'package:orchid/helpers/theme.dart';
import 'package:orchid/models/authentication.dart';
import 'package:orchid/provider/doctor_nurse_provider.dart';
import 'package:orchid/provider/slider_provider.dart';
import 'package:orchid/provider/specialities_provider.dart';
import 'package:orchid/util/shared_preferences_helper.dart';
import 'package:orchid/views/doctor_appointment.dart';
import 'package:orchid/widgets/doctor_card.dart';
import 'package:orchid/widgets/doctor_list.dart';
import 'package:orchid/views/services_page.dart';
import 'package:orchid/widgets/specialities_card.dart';
import 'package:provider/provider.dart';

import 'edit_profile.dart';
import 'landing_page.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/auth';
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController _controller = CarouselController();

  int current = 0;

  int selectedPage = 0;

  List imageList = [
    'assets/images/Aesthetic-Skin-Care-Clinic.png',
    'assets/images/facetreatment.jpg',
    'assets/images/hair-loss-treatment-clinic-1.png'
  ];
  User userDetails = User();
  String? accessToken = "";

  @override
  void initState() {
    super.initState();
    getUserDetails();
    context.read<DoctorProvider>().fetchDoctors();
    context.read<SpecialitiesProvider>().fetchSpecialities();
    context.read<SliderProvider>().fetchSliders();
  }

  getUserDetails() async {
    User user = await SharedPreferencesHelper.getUserDetails();
    String? at = await SharedPreferencesHelper.getAccessToken();
    setState(() {
      userDetails = user;
      accessToken = at;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: InkWell(
            child: ListTile(
              leading: ClipRRect(
                  child: userDetails.decodedImage != null
                      ? Image.memory(
                          userDetails.decodedImage!,
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 0.12,
                          height: MediaQuery.of(context).size.width * 0.12,
                        )
                      : (userDetails.image == null
                          ? Image.asset(
                              'assets/images/user.png',
                              width: MediaQuery.of(context).size.width * 0.12,
                              height: MediaQuery.of(context).size.width * 0.12,
                            )
                          : Image.network(
                              userDetails.image!,
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width * 0.12,
                              height: MediaQuery.of(context).size.width * 0.12,
                            ))),
              title: Text(
                (accessToken == "" || accessToken == null)
                    ? 'Please Login'
                    : ((userDetails.name == "" || userDetails.name == null)
                        ? 'Enter your name'
                        : userDetails.name!),
                style: theme.textTheme.headline6,
              ),
              subtitle: const Text(
                "Find your suitable Doctor Here",
              ),
              // trailing: Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10.0),
              //     color: backgroundColor,
              //   ),
              //   child: IconButton(
              //     icon: const Icon(
              //       Icons.notification_add_rounded,
              //       size: 25.0,
              //     ),
              //     onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => EditProfile()));
              //       // const NotificationPage()));
              //     },
              //   ),
              // ),
            ),
            onTap: () {
              if (accessToken == "" || accessToken == null) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LandingPage()));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              }
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Consumer<SliderProvider>(builder: (context, value, child) {
              if (value.sliders?.sliders == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(children: [
                Container(
                  height: 170,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 170,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: value.sliders?.sliders?.map((images) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: NetworkImage(images.image.toString()),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 5.0,
                        height: 5.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.pink)
                                .withOpacity(current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                )
              ]);
            }),
            const Text("Specialities"),
            sizedBox,
            SizedBox(
              width: double.infinity,
              height: 150.0,
              child: Consumer<SpecialitiesProvider>(
                  builder: (context, value, child) {
                if (value.specialities?.specialities == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 10);
                  },
                  itemCount: value.specialities!.specialities!.length,
                  scrollDirection: Axis.horizontal,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var specialities =
                        value.specialities?.specialities?.elementAt(index);
                    return InkWell(
                        child: SpecialitiesCard(
                          specialities: specialities,
                          noColor: false,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ServicesPage(),
                                // navigatetoSpeciality(specialities.name)),
                              ));
                        });
                  },
                );
              }),
            ),
            sizedBox,
            sizedBox,
            Row(
              children: <Widget>[
                const Text("Available Doctors"),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DoctorList()),
                    );
                  },
                  child: const Text("See all",
                      style: TextStyle(color: primaryColor, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 200.0,
              child: Consumer<DoctorProvider>(builder: (context, value, child) {
                if (value.doctors?.doctors == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 15);
                  },
                  itemCount: value.doctors!.doctors!.length,
                  scrollDirection: Axis.horizontal,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var doctor = value.doctors?.doctors?.elementAt(index);
                    return InkWell(
                        child: DoctorCard(person: doctor),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DoctorAppointment(doctor: doctor!)),
                          );
                        });
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  navigatetoSpeciality(String specialityName) {
    if (specialityName == 'Our Services') {
      return const ServicesPage();
    } else if (specialityName == 'Our packages') {
      // return PackagePage();
    }
  }
}
