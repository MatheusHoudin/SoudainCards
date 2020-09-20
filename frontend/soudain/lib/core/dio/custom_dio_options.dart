import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class CustomDioOptions extends Options implements Equatable {
  CustomDioOptions({
    String method,
    int sendTimeout,
    int receiveTimeout,
    Map<String, dynamic> extra,
    Map<String, dynamic> headers,
    ResponseType responseType,
    String contentType,
    ValidateStatus validateStatus,
    bool receiveDataWhenStatusError,
    bool followRedirects,
    int maxRedirects,
    RequestEncoder requestEncoder,
    ResponseDecoder responseDecoder,
  }) : super(
          method: method,
          sendTimeout: sendTimeout,
          receiveTimeout: receiveTimeout,
          extra: extra,
          headers: headers,
          responseType: responseType,
          contentType: contentType,
          validateStatus: validateStatus,
          receiveDataWhenStatusError: receiveDataWhenStatusError,
          followRedirects: followRedirects,
          maxRedirects: maxRedirects,
          requestEncoder: requestEncoder,
          responseDecoder: responseDecoder,
        );

  List<Object> get props => [
    method,
    sendTimeout,
    receiveTimeout,
    extra,
    headers,
    responseType,
    contentType,
    validateStatus,
    receiveDataWhenStatusError,
    followRedirects,
    maxRedirects,
    requestEncoder,
    responseDecoder
  ];

  bool get stringify => true;
}
