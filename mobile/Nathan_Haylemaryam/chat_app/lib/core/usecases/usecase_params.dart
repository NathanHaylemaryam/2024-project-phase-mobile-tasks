import 'package:equatable/equatable.dart';



class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class IdParams extends Equatable {
  final String id;

  const IdParams(this.id);

  @override
  List<Object?> get props => [id];
}


