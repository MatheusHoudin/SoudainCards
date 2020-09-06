import 'package:dio/dio.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/core/error/field_error.dart';
import 'package:soudain/features/collection/create/data/models/collection.dart';
import 'package:http_parser/http_parser.dart' as httpParser;

abstract class CollectionRemoteDataSource {
  Future<Collection> save(Collection collection, String token);
}

class CollectionRemoteDataSourceImpl extends CollectionRemoteDataSource {
  final Dio client;

  CollectionRemoteDataSourceImpl({this.client});

  @override
  Future<Collection> save(Collection collection, String token) async {
    try {
      var fileId;
      print(collection.image);
      if (collection.image != null) {
        FormData formData = new FormData.fromMap({
          "file": await MultipartFile.fromFile(collection.image,
              contentType: httpParser.MediaType('image', 'png'))
        });

        final fileResponse = await client.post("/files", data: formData, options: Options(
          headers: {
            'Authorization': token
          }
        ));
        fileId = fileResponse.data['data']['id'];
      }

      var data = fileId != null ? {
        "title": collection.name,
        "description": collection.description,
        "collection_image": fileId
      }
      :
      {
        "title": collection.name,
        "description": collection.description,
      };

      final collectionResult = await client.post('/collection', data: data,
        options: Options(
          headers: {
          'Authorization': token
          }
        )
      );

      return Collection.fromJson(collectionResult.data['data']);
    } on DioError catch (e) {
      print(e);
      if (e.response != null) {
        if (e.response.statusCode == 400) {
          throw SessionRequestMalformedException(
              parameterErrorList: (e.response.data['error'] as List)
                  .map((e) => FieldError.fromJson(e))
                  .toList());
        }else if(e.response.statusCode == 404){
          throw ImageDoesNotExistException();
        }else if(e.response.statusCode == 409){
          throw CollectionAlreadyExistsException();
        }else{
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    }
  }
}
