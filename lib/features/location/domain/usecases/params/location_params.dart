import 'package:equatable/equatable.dart';

class LocationParams extends Equatable {
  final String query;

  const LocationParams({required this.query});

  @override
  List<Object?> get props => [query];
}
