import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_test/bloc/auth/auth_bloc.dart';
import 'package:messenger_test/data/auth_repository.dart';
import 'package:messenger_test/data/users_repository.dart';
import 'package:messenger_test/services/remote/auth/auth_service_impl.dart';
import 'package:messenger_test/services/remote/users/users_service_impl.dart';

class DI {
  final authService = AuthServiceImpl();
  final usersService = UsersServiceImpl();

  buildRepositoryProviders(child) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(create: (_) => AuthRepository(authService)),
      RepositoryProvider(
        create: (_) => UsersRepository(usersService),
        lazy: true,
      )
    ], child: child);
  }

  buildBlockProvider(app) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) {
          final authRepository = RepositoryProvider.of<AuthRepository>(context);
          final usersRepository =
              RepositoryProvider.of<UsersRepository>(context);
          return AuthBloc(authRepository, [usersRepository]);
        },
        lazy: false,
      ),
    ], child: app);
  }

  initDependencies(app) { // TODO rename
    return buildRepositoryProviders(buildBlockProvider(app));
  }
}
