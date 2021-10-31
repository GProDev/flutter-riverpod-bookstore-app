import 'package:bookstore/clients/_client_base.dart';
import 'package:bookstore/models/book.dart';

final _clientBase = ClientBase();

Future<List<Book>>? fetchBooks() async {
  try {
    final res = await _clientBase.dio.get('/search/mongodb');
    if (res.statusCode == 200) {
      return res.data['books'].map<Book>((e) => Book.fromJson(e)).toList();
    } else {
      throw 'Failed fetching books [${res.statusCode}]';
    }
  } on Exception catch (e) {
    throw 'Failed fetching books [$e]';
  }
}
