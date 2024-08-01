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
        onCodeSent: any(named: 'onCodeSent'),
        onError: any(named: 'onError'))).thenAnswer((invocation) async {
      final args = invocation.namedArguments;

      final verificationCompleted =
          args[const Symbol('verificationCompleted')] as Function(dynamic);
      final onCodeSent =
          args[const Symbol('onCodeSent')] as Function(String, int?);

      onCodeSent('verificationId', 1);
      await Future.delayed(const Duration(seconds: 1));
      verificationCompleted('1');

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

    test('Verification verified status test', () async {
      final commits = [];
      final stream = await authRepository.verifyPhone(phone);
      stream.listen((data) => commits.add(data));
      expectLater(
        stream,
        emitsInOrder([
          VerificationStatusEnum.verified,
        ]),
      );
    });
  });
}

class MockAuthService extends Mock implements AuthService {}
