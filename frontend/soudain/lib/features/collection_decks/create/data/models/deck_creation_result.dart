import 'package:equatable/equatable.dart';

class DeckCreationResult extends Equatable {
  final int id;
  final int deck;
  final int user;
  final int collection;
  final bool imported;

  DeckCreationResult({
    this.id,
    this.deck,
    this.user,
    this.collection,
    this.imported
  });

  factory DeckCreationResult.fromJson(Map<String,dynamic> json) {
    return DeckCreationResult(
      id: json['id'],
      collection: json['collection'],
      deck: json['deck'],
      imported: json['imported'],
      user: json['user']
    );
  }
  @override
  List<Object> get props => [id,collection,deck,imported,user];

}
