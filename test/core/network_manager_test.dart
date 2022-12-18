import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test_rnd/core/network_manager.dart';

import 'network_manager_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late NetworkManager networkManager;

  setUp(() {
    mockClient = MockClient();
    networkManager = NetworkManager(client: mockClient);
  });

  tearDown(() {
    mockClient.close();
  });
  group('Fetch APIs from network manager class', () {
    test('Should return jsondecoded valus for http success call', () async {
      // ARRANGE
      String url = 'https://api.sampleapis.com/avatar/info';
      when(mockClient.get(Uri.parse(url))).thenAnswer((realInvocation) async =>
          http.Response(
              '[{"id": 3,"name": "Clementine Bauch", "email": "Nathan@yesenia.net"}]',
              200));

      // ACT & ASSERT
      expect(await networkManager.sendRequest(path: url), isA<dynamic>());
    });

    test('Should throw an exception if something went wrong', () async {
      // ARRANGE
      String url = 'https://api.sampleapis.com/avatar/';
      when(mockClient.get(Uri.parse(url))).thenAnswer(
          (realInvocation) async => http.Response('not found', 400));

      // ACT & ASSERT
      expect(networkManager.sendRequest(path: url), throwsException);
    });
  });
}
