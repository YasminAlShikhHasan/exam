import 'package:dio/dio.dart';
import 'package:exam/model/model.dart';

abstract class GetData {
  Dio dio = Dio();
  String url = "https://664dcb37ede9a2b55654e96c.mockapi.io/api/v1/people";
  late Response response;
  Future<List<People>> getData();
}

class GetDataImp extends GetData {
  @override
  Future<List<People>> getData() async {
    await dio.get(url);
    try {
      
      if (response.statusCode == 200) {
        List<People> result = List.generate(response.data.length,
            (index) => People.fromMap(response.data[index]));
        return result;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
