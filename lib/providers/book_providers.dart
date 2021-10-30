import 'package:bookstore/models/book.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookstoreNotifier extends StateNotifier<List<Book>> {
  BookstoreNotifier() : super([]);

  void add(Book book) {
    state = [...state, book];
  }

  void addAll(List<Book> books) {
    state = [...state, ...books];
  }

  void updateOne(Book book) {
    final i = state.indexWhere((e) => e.isbn13 == book.isbn13);
    state = [...state.sublist(0, i), book, ...state.sublist(i + 1)];
  }
}

final booksProvider = StateNotifierProvider<BookstoreNotifier, List<Book>>(
  (ref) => BookstoreNotifier(),
);

final filteredBooksProvider = Provider((ref) {
  return ref.watch(booksProvider);
});
