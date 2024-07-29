import 'package:flutter_test/flutter_test.dart';
import 'package:messenger_test/data/auth_repository.dart';
import 'package:messenger_test/services/remote/auth/auth_service.dart';
import 'package:mocktail/src/mocktail.dart';

void main() {
  late AuthService authService;
  late AuthRepository authRepository;

  setUp(() {
    authService = MockAuthService();
    authRepository = AuthRepository(authService);

    when(() => authService.profileExists(any(that: isA<String>())))
        .thenAnswer((_) async => true);

    when(() => authService.verifyPhone(any(that: isA<String>()),
        verificationCompleted: any(named: 'verificationCompleted'),
        onCodeSent: any(named: 'onCodeSent'))).thenAnswer((invocation) async {
      final verificationCompletedCallback =
          invocation.namedArguments[const Symbol('verificationCompleted')]
              as Function(dynamic);
      final onCodeSentCallback = invocation
          .namedArguments[const Symbol('onCodeSent')] as Function(String, int?);
      final onErrorCallback = invocation.namedArguments[const Symbol('onError')]
          as Function(Exception)?;
// Optionally simulate onCodeSent or onError callbacks if needed
      onCodeSentCallback('verificationId', 1);
      // Simulate verification completed callback
      verificationCompletedCallback('1');

      return Future.value();
    });
// TODO rewrite when would be decided credentials type
    when(() => authService.confirmCredentials(any()))
        .thenAnswer((inv) async => inv.positionalArguments[0]);
  });

  group('AuthRepository tests', () {
    const phone = '999';

    test('Test credential authorization', () async {
      const credentials = '1';
      final returnedCredentials =
          await authService.confirmCredentials(credentials);
      expect(returnedCredentials, credentials);
    });

    test('Test authService verification', () async {
      await authService.verifyPhone(phone,
          verificationCompleted: (credentials) {
        expect(credentials, '1');
      }, onCodeSent: (id, token) {});
    });

    test('Verification verified status test', () async {
      final stream = await authRepository.verifyPhone(phone);
      await expectLater(
        stream,
        emitsInOrder([
          VerificationStatusEnum.codeSent,
          VerificationStatusEnum.verified,
        ]),
      );
    });
  });
}

class MockAuthService extends Mock implements AuthService {}
