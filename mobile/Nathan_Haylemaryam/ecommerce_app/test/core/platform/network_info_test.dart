// test/core/platform/network_info_test.dart
import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';

class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker {
  @override
  Future<bool> get hasConnection => super.noSuchMethod(
    Invocation.getter(#hasConnection),
    returnValue: Future.value(true), // default value
    returnValueForMissingStub: Future.value(true),
  );
}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockConnectionChecker;

  setUp(() {
    mockConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockConnectionChecker);
  });

  test('isConnected should forward the call to InternetConnectionChecker.hasConnection',
        () async {
      // arrange
      when(mockConnectionChecker.hasConnection).thenAnswer((_) async => true);

      // act
      final result = await networkInfo.isConnected;

      // assert
      verify(mockConnectionChecker.hasConnection);
      expect(result, true);
    },
  );
}