

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repository/product_repository.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_bloc_test.mocks.dart';




@GenerateMocks([ProductRepository])
void main() {
  // your tests here
  late ProductBloc bloc;
  late MockProductRepository mockRepo;

  setUp(() {
    mockRepo = MockProductRepository();
    bloc = ProductBloc(mockRepo);
  });

  const tProduct = Product(
    id: '1',
    name: 'Phone',
    decscription: 'Smart device',
    price: 999,
    imagepath: 'img.jpg',
  );

  group('InsertProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [Loading, Success] when insert succeeds',
      build: () {
        when(mockRepo.insertProduct(any))
            .thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(InsertProductEvent(tProduct)),
      expect: () => [
        ProductLoading(),
        ProductSuccess(),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [Loading, Error] when insert fails',
      build: () {
        when(mockRepo.insertProduct(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(InsertProductEvent(tProduct)),
      expect: () => [
        ProductLoading(),
        isA<ProductError>(),
      ],
    );
  });

  group('GetProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [Loading, Loaded] when getProduct succeeds',
      build: () {
        when(mockRepo.getProduct(any))
            .thenAnswer((_) async => Right(tProduct));
        return bloc;
      },
      act: (bloc) => bloc.add(GetProductEvent(tProduct.id.toString())),
      expect: () => [
        ProductLoading(),
        ProductLoaded(tProduct),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [Loading, Error] when getProduct fails',
      build: () {
        when(mockRepo.getProduct(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetProductEvent(tProduct.id.toString())),
      expect: () => [
        ProductLoading(),
        isA<ProductError>(),
      ],
    );
  });
}


