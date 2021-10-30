import 'dart:developer';

import 'package:bookstore/models/book.dart';
import 'package:bookstore/pages/book_page.dart';
import 'package:bookstore/providers/book_providers.dart';
import 'package:dio/dio.dart';
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
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.network(books[index].image, height: 50),
                    title: Text(books[index].title),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookPage(
                            isbn13: books[index].isbn13,
                            isbn10: books[index].isbn10,
                          ),
                        ),
                      );
                    },
                  );
                },
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
      final res =
          await Dio().get('https://api.itbook.store/1.0/search/mongodb');
      final books =
          res.data?['books'].map<Book>((e) => Book.fromJson(e)).toList();
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
