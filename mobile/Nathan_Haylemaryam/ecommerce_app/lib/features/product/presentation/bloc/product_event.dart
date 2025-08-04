import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class InsertProductEvent extends ProductEvent {
  final Product product;

  const InsertProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class UpdateProductEvent extends ProductEvent {
  final Product product;

  const UpdateProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String id;

  const DeleteProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetProductEvent extends ProductEvent {
  final String id;

  const GetProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}
class LoadAllProductEvent extends ProductEvent {
  const LoadAllProductEvent();

  @override
  List<Object?> get props => [];
}
