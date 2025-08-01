import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';


import '../../domain/repository/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<InsertProductEvent>(_onInsertProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<GetProductEvent>(_onGetProduct);
  }

  Future<void> _onInsertProduct(
      InsertProductEvent event,
      Emitter<ProductState> emit,
      ) async {
    emit(ProductLoading());

    final result = await repository.insertProduct(event.product);

    result.fold(
          (failure) => emit(ProductError(_mapFailureToMessage(failure))),
          (_) => emit(ProductSuccess()),
    );
  }

  Future<void> _onUpdateProduct(
      UpdateProductEvent event,
      Emitter<ProductState> emit,
      ) async {
    emit(ProductLoading());

    final result = await repository.updateProduct(event.product);

    result.fold(
          (failure) => emit(ProductError(_mapFailureToMessage(failure))),
          (_) => emit(ProductSuccess()),
    );
  }

  Future<void> _onDeleteProduct(
      DeleteProductEvent event,
      Emitter<ProductState> emit,
      ) async {
    emit(ProductLoading());

    final result = await repository.deleteProduct(event.id);

    result.fold(
          (failure) => emit(ProductError(_mapFailureToMessage(failure))),
          (_) => emit(ProductSuccess()),
    );
  }

  Future<void> _onGetProduct(
      GetProductEvent event,
      Emitter<ProductState> emit,
      ) async {
    emit(ProductLoading());

    final result = await repository.getProduct(event.id);

    result.fold(
          (failure) => emit(ProductError(_mapFailureToMessage(failure))),
          (product) => emit(ProductLoaded(product)),
    );
  }

  String _mapFailureToMessage(Failure failure) {

    if (failure is ServerFailure) return 'Server Failure';
    if (failure is CacheFailure) return 'Cache Failure';
    return 'Unexpected Error';
  }
}
