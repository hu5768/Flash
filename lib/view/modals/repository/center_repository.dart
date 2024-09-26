import 'package:dio/dio.dart' hide Headers;
import 'package:flash/model/center_model.dart';
import 'package:retrofit/retrofit.dart';

part 'center_repository.g.dart';

@RestApi()
abstract class CenterRepository {
  factory CenterRepository(Dio dio, {String baseUrl}) = _CenterRepository;

  @GET('/gyms')
  @Headers({
    'acesseToken': 'true',
  })
  Future<List<Centers>> getCenterList();
}
