import 'package:dio/dio.dart';

const accessToken =
    'pk.eyJ1IjoiamVzdXMxODByeWVzIiwiYSI6ImNrdGV2aTc5ODAyODEybnBuN2p1aTJsZGEifQ.h9f0jvZEveu540ce7DBWdg';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': "simplified",
      'steps': false,
      'access_token': accessToken,
    });

    super.onRequest(options, handler);
  }
}
