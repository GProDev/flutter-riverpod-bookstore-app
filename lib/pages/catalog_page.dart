import 'dart:developer';

import 'package:bookstore/clients/book_client.dart';
import 'package:bookstore/pages/book_page.dart';
import 'package:bookstore/providers/book_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatalogPage extends ConsumerStatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends ConsumerState<CatalogPage> {
  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    final books = ref.watch(filteredBooksProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books Catalog'),
        elevation: 1,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 60,
              // width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Expanded(child: TextField()),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Search'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  for (final book in books)
                    ListTile(
                      leading: Image.network(book.image, height: 50),
                      title: Text(book.title),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookPage(
                              isbn13: book.isbn13,
                              isbn10: book.isbn10,
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadBooks() async {
    try {
      log('Loading books ...');
      final books = await fetchBooks();
      if (books != null) {
        ref.read(booksProvider.notifier).addAll(books);
      }
      log('Loaded books');
    } on Exception catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
    }
  }
}
