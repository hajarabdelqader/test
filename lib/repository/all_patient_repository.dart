import 'package:alzheimer/models/allpatient_repo_model.dart';
import 'package:dio/dio.dart';

//import 'package:ecommerce_app_sw25/models/category_repo_model.dart';

class AllPatientRepo {

  Future<List<AllPatientRepoModel>> getAllPatient() async {
    final response = await Dio().get('https://mocki.io/v1/e5775744-06ba-4306-b6f6-93055de3c2d5');

    final listofallpatient = List<AllPatientRepoModel>.from(
      response.data.map(
            (element) {
          // element is Map
          return AllPatientRepoModel(
            id: element['id'],
            name: element['name'],
            image: element['image'],
          );
        },
      ),
    );
    return listofallpatient;
  }
}