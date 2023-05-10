import 'package:doctor_appointment_app/components/appointment_card.dart';
import 'package:doctor_appointment_app/models/auth_model.dart';
import 'package:doctor_appointment_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/button_group.dart';
import '../components/doctor_card.dart';
import '../components/search_and_filter.dart';
import '../main_layout.dart';
import '../providers/Filters.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> user = {};
  Map<String, dynamic> appoinment = {};
  List<dynamic> favList = [];

  // Future<void> getAppointments() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token') ?? '';
  //   final appointments = await DioProvider().getAppointments(token);
  //   if (appointments != 'Error') {
  //     setState(() {
  //       // schedules = json.decode(appointment);
  //       appoinment = appointments;
  //       // print(schedules);
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   getAppointments();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    user = Provider.of<AuthModel>(context, listen: false).getUser;
    appoinment = Provider.of<AuthModel>(context, listen: false).getAppointment;
    favList = Provider.of<AuthModel>(context, listen: false).getFav;

    return Scaffold(
      //if user is empty, then return progress indicator
      body: user.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            user['name'],
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 20, bottom: 15),
                            child: InkWell(
                              child: const Icon(
                                Icons.menu,
                                color: Colors.blue,
                                size: 32,
                              ),
                              onTap: () {
                                MainLayout.keyGlobal.currentState!
                                    .openEndDrawer();
                              },
                            ),
                          )
                        ],
                      ),
                      Config.spaceSmall,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SearchAndFilter(
                            isbtnActive:
                                context.watch<FilterProvider>().MainfilterState,
                            press: () {
                              Provider.of<FilterProvider>(context,
                                      listen: false)
                                  .changeStateMainFilter();
                            },
                          ),
                          Consumer<FilterProvider>(
                            builder: (context, Filter, _) {
                              return Visibility(
                                visible: Filter.MainfilterState,
                                child: const ButtonGroup__widget(
                                  ListString: [
                                    "General",
                                    "Cardiology",
                                    "Gynecology",
                                    "Dental",
                                  ],
                                  isSelected: [
                                    true,
                                    false,
                                    false,
                                    false,
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                     
                      const Text(
                        'Appointment Today',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Config.spaceSmall,
                      appoinment.isNotEmpty
                          ? AppointmentCard(
                              doctor: appoinment,
                              color: Theme.of(context).primaryColor,
                            )
                          : Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    'No Appointment Today',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      Config.spaceSmall,
                      const Text(
                        'Top Doctors',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Config.spaceSmall,
                      Column(
                        children: List.generate(user['doctor'].length, (index) {
                          return DoctorCard(
                            doctor: user['doctor'][index],
                            //if lates fav list contains particular doctor id, then show fav icon
                            isFav: favList
                                    .contains(user['doctor'][index]['doc_id'])
                                ? true
                                : false,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
