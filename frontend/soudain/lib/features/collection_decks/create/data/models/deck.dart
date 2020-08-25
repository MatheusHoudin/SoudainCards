import 'package:equatable/equatable.dart';
import 'package:soudain/features/collection_decks/create/data/models/subject.dart';

class Deck extends Equatable {
  final int id;
  final String name;
  final bool shared;
  final Subject subject;
  final String image;

  Deck({
    this.id,
    this.name,
    this.shared,
    this.subject,
    this.image
  });

  @override
  List<Object> get props => [
    this.id,
    this.name,
    this.shared,
    this.subject,
    this.image
  ];

}