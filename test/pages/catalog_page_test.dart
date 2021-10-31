import 'package:bookstore/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  const baseUrl = 'https://api.itbook.store';
  const sampleOfBooks = [
    {
      'title': 'Practical MongoDB',
      'subtitle': 'Architecting, Developing, and Administering MongoDB',
      'isbn13': '9781484206485',
      'price': '\$41.57',
      'image': 'https://itbook.store/img/books/9781484206485.png',
      'url': 'https://itbook.store/books/9781484206485'
    }
  ];
  late Dio dio;
  late DioAdapter dioAdapter;

  group('Catalog', () {
    setUp(() {
      dio = Dio(BaseOptions(baseUrl: baseUrl));
      dioAdapter = DioAdapter(dio: dio);
    });

    testWidgets(
      'Display books from booksProvider',
      (WidgetTester tester) async {
        const route = '/1.0/search/mongodb';
        dioAdapter.onGet(route, (server) {
          server.reply(200, {'books': sampleOfBooks});
        });
        await tester.pumpWidget(const ProviderScope(child: MyApp()));
        await tester.pump(const Duration(seconds: 2));
        expect(find.text('Practical MongoDB'), findsOneWidget);
      },
    );
  });
}
