import 'package:equatable/equatable.dart';

class Collection extends Equatable {
  final int id;
  final String name;
  final String description;
  final String image;

  Collection({
    this.id,
    this.name,
    this.description,
    this.image
  });

  factory Collection.fromJson(Map<String,dynamic> json) {
    return Collection(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  @override
  List<Object> get props => [
    this.id,
    this.name,
    this.description,
    this.image
  ];

}