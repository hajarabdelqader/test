import 'package:alzheimer/cubits/AllPatient_cubite/all_patient_cubit.dart';
import 'package:alzheimer/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Patient_home.dart';

class CaregiverHome extends StatelessWidget {
 // const CaregiverHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          BlocBuilder<AllPatientCubit, AllPatientState>(
            builder: (context, state) {
              if (state is LoadingAllPatient) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is GetAllPatientSuccess) {
                final listofallpatient= state.allpatientList;
                return Container(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: listofallpatient.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return RegisterPage();
                            }),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    listofallpatient[index].image),
                              ),
                              Text(listofallpatient[index].name),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              if (state is ErrorInAllPatient) {
                return Text('No Internet Connection!');
              }

              return Text('Try Again Later!');
            },
          ),

        ],


        ),
      ),



    );
  }
}
