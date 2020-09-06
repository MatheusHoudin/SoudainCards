import 'package:dio/dio.dart';
import 'package:soudain/core/error/exceptions.dart';
import 'package:soudain/features/play/data/models/collection_data.dart';

abstract class CollectionDataRemoteDataSource {
  Future<List<CollectionData>> getCollections(String token);
}

class CollectionDataRemoteDataSourceImpl extends CollectionDataRemoteDataSource {
  final Dio client;

  CollectionDataRemoteDataSourceImpl({this.client});

  @override
  Future<List<CollectionData>> getCollections(String token) async {
    try {
      final collectionsResult = await client.get('/user/collection',
        options: Options(
          headers: {
            'Authorization': token
          }
        )
      );
      return (collectionsResult.data['data'] as List).map((e) => CollectionData.fromJson(e)).toList();
    } on DioError {
      throw ServerException();
    }
  }

}
