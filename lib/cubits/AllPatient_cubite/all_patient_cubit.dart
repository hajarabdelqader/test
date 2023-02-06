import 'package:alzheimer/models/allpatient_repo_model.dart';
import 'package:alzheimer/repository/all_patient_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'all_patient_state.dart';

class AllPatientCubit extends Cubit<AllPatientState> {
  AllPatientCubit() : super(AllPatientInitial());

  void getAllPatient() async {
    emit(LoadingAllPatient());
    final allpatient = await AllPatientRepo().getAllPatient();
    emit(GetAllPatientSuccess(allpatient));
  }


}
