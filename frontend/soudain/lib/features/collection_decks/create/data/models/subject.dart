import 'package:equatable/equatable.dart';

class Subject extends Equatable{
  final int id;
  final String name;

  Subject({
    this.id,
    this.name
  });

  @override
  List<Object> get props => [
    this.id,
    this.name
  ];
}