import 'package:dio/dio.dart';
import 'package:soudain/features/collection_decks/create/data/models/deck.dart';
import 'package:soudain/features/collection_decks/create/data/models/deck_creation_result.dart';
import 'package:http_parser/http_parser.dart' as httpParser;

abstract class DeckCreationRemoteDataSource {
  Future<DeckCreationResult> createDeck(Deck deck, String token, int collectionId);
}

class DeckCreationRemoteDataSourceImpl extends DeckCreationRemoteDataSource {
  Dio client;

  DeckCreationRemoteDataSourceImpl({this.client});

  @override
  Future<DeckCreationResult> createDeck(Deck deck, String token, int collectionId) async {
    var fileId;
    if (deck.image != null) {

      FormData formData = new FormData.fromMap({
        "file": await MultipartFile.fromFile(deck.image,
            contentType: httpParser.MediaType('image', 'png'))
      });

      final fileResponse = await client.post("/files", data: formData, options: Options(
          headers: {
            'Authorization': token
          }
      ));

      fileId = fileResponse.data['data']['id'];
    }

    var data = fileId == null ? {
      "subject": deck.subject.id,
      "name": deck.name,
      "collection": collectionId
    }
    :
    {
      "subject": deck.subject.id,
      "name": deck.name,
      "collection": collectionId,
      "image_id": fileId
    };

    final deckResult = await client.post('/deck', data: data,
      options: Options(
        headers: {
          "Authorization": token
        }
      )
    );
  }

}