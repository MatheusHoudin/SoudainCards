import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType()
class CollectionData extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final bool shared;
  @HiveField(4)
  final int creator;
  @HiveField(5)
  final int decksCount;
  @HiveField(6)
  final String imageUrl;

  CollectionData({
    this.id,
    this.title,
    this.description,
    this.shared,
    this.creator,
    this.decksCount,
    this.imageUrl
  });

  factory CollectionData.fromJson(Map<String,dynamic> json) {
    return CollectionData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      shared: json['shared'],
      creator: json['creator'],
      decksCount: int.parse(json['decksCount'] == null ? '0' : json['decksCount']),
      imageUrl: json['file'] != null ? json['file']['url'] : null
    );
  }

  @override
  List<Object> get props => [
    this.id,
    this.title,
    this.description,
    this.shared,
    this.creator,
    this.decksCount,
    this.imageUrl
  ];
}