import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

import 'package:weather_app/core/util/network/network_info.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnection internetConnection;

  setUp(() {
    internetConnection = MockInternetConnection();
    networkInfoImpl = NetworkInfoImpl(internetConnection);
  });

  group('isConnected', () {
    test('should forward the call to InternetConnection.hasInternetAccess',
        () async {
      //arrange
      final testHasInternetAccess = Future.value(true);
      when(internetConnection.hasInternetAccess)
          .thenAnswer((realInvocation) => testHasInternetAccess);
      //act
      final result = networkInfoImpl.isConnected;
      //assert
      verify(internetConnection.hasInternetAccess);
      expect(result, testHasInternetAccess);
    });
  });
}
