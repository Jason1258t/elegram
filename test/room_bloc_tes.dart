import 'package:flutter_test/flutter_test.dart';
import 'package:messenger_test/bloc/room/room_bloc.dart';
import 'package:messenger_test/data/chat_repository.dart';
import 'package:messenger_test/services/local/chat/chat_cache.dart';
import 'package:messenger_test/services/local/chat/chat_cache_mock.dart';
import 'package:messenger_test/services/remote/chat/chat_service.dart';
import 'package:messenger_test/services/remote/chat/chat_service_mock.dart';

void main() {
  group('Bloc test', () {
    final ChatService service = ChatServiceMock();
    final ChatCache cache = ChatCacheMock();
    final ChatRepository repository = ChatRepository(service, cache);

    late RoomBloc roomBloc;

    setUp(() {
      roomBloc = RoomBloc(repository, 'chat1');
    });

    tearDown(() {
      roomBloc.close();
    });


  });
}