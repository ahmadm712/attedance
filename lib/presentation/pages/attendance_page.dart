import 'dart:math';

import 'package:attendance/data/models/attendance.dart';
import 'package:attendance/data/models/offices_model.dart';
import 'package:attendance/injection.dart';
import 'package:attendance/presentation/cubit/attendance_cubit/attendance_cubit.dart';
import 'package:attendance/presentation/cubit/list_attendance_cubit/list_attendance_cubit.dart';
import 'package:attendance/presentation/cubit/location_cubit/location_cubit.dart';
import 'package:attendance/services/location_services.dart';
import 'package:attendance/utils/global_functions.dart';
import 'package:attendance/utils/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final locationServices = locator<LocationServices>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ListAttendanceCubit>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttendanceCubit, AttendanceState>(
      listener: (context, state) {
        if (state is AttendanceFailed) {
          GlobalFunctions.scafoldMessage(
              context: context, message: state.errorMessage, color: Colors.red);
        } else if (state is AttendanceSucces) {
          GlobalFunctions.scafoldMessage(
              context: context,
              message: 'Clock in Succes',
              color: Colors.green);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Attendance / Clock in"),
            elevation: 0,
          ),
          floatingActionButton: const FloatingAcctionButton(),
          body: BlocBuilder<ListAttendanceCubit, ListAttendanceState>(
            builder: (context, stateListAttendance) {
              if (stateListAttendance is ListAttendanceHasData) {
                return ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: stateListAttendance.data.length,
                  itemBuilder: (context, index) {
                    final attendance = stateListAttendance.data[index];
                    return ListTile(
                      title: Text(
                        attendance.idUser,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          const Text(
                            'on Location  : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          attendance.isWFO
                              ? Icon(
                                  Icons.check_outlined,
                                  color: kColorPrimary,
                                )
                              : Text(
                                  attendance.isWFO.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ],
                      ),
                      trailing: Text(
                        "${attendance.createdTime.day}/${attendance.createdTime.month}/${attendance.createdTime.year} - ${attendance.createdTime.hour}:${attendance.createdTime.second}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                );
              } else if (stateListAttendance is ListAttendanceLoading) {
                return Center(
                  child: CircularProgressIndicator.adaptive(
                      backgroundColor: kColorPrimary),
                );
              } else if (stateListAttendance is ListAttendanceFailed) {
                return Center(
                  child: Text(stateListAttendance.error.toString()),
                );
              }
              return const Center(
                child: Text('No Data'),
              );
            },
          ),
        );
      },
    );
  }
}

class FloatingAcctionButton extends StatelessWidget {
  const FloatingAcctionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          if (state is LocationSucces) {
            return ElevatedButton(
              onPressed: () async {
                final data = Attendance(
                  idUser: Random().nextInt(1213).toString(),
                  createdTime: DateTime.now(),
                );
                context.read<AttendanceCubit>().attendance(state.office!, data);
                context.read<ListAttendanceCubit>().getData();
              },
              child: const Text('Clock in'),
            );
          }

          return ElevatedButton(
            onPressed: () async {
              OfficesModel officesModel = OfficesModel(
                  id: '',
                  location: const GeoPoint(-6.1558321, 106.8075075),
                  name: 'Ahmad Muji',
                  addres: 'addres');

              final data = Attendance(
                idUser: Random().nextInt(1213).toString(),
                createdTime: DateTime.now(),
                geoPoint: const GeoPoint(-6.1558321, 103.124),
              );
              context.read<AttendanceCubit>().attendance(officesModel, data);
              context.read<ListAttendanceCubit>().getData();
            },
            child: const Text('Clock In'),
          );
        },
      ),
    );
  }
}
