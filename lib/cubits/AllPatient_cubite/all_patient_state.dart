part of 'all_patient_cubit.dart';

@immutable
abstract class AllPatientState {}

class AllPatientInitial extends AllPatientState {}
class GetAllPatientSuccess extends AllPatientState {

  final List<AllPatientRepoModel> allpatientList;

  GetAllPatientSuccess(this.allpatientList);
}
class LoadingAllPatient extends AllPatientState {}
class ErrorInAllPatient extends AllPatientState {}

