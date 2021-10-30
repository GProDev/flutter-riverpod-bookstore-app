import 'dart:developer';

import 'package:bookstore/models/book.dart';
import 'package:bookstore/providers/book_providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookPage extends ConsumerStatefulWidget {
  final String isbn13;
  final String? isbn10;
  const BookPage({Key? key, required this.isbn13, this.isbn10})
      : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends ConsumerState<BookPage> {
  @override
  void initState() {
    super.initState();
    if (widget.isbn10 == null) _fetchMoreInfo();
  }

  @override
  Widget build(BuildContext context) {
    final book =
        ref.watch(booksProvider).firstWhere((e) => e.isbn13 == widget.isbn13);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book detail'),
        elevation: 1,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(child: Image.network(book.image, height: 400)),
              Text(book.title, textScaleFactor: 2),
              Text(book.subtitle ?? '_', textScaleFactor: 1.2),
              Text(book.desc ?? '_'),
              Row(
                children: [
                  const Text('Authors: '),
                  Flexible(
                      child: Text(book.authors ?? '_', textScaleFactor: 1.2)),
                ],
              ),
              Row(
                children: [
                  const Text('Pages: '),
                  Text(book.pages ?? '_', textScaleFactor: 1.2),
                ],
              ),
              Row(
                children: [
                  const Text('Year: '),
                  Text(book.year ?? '_', textScaleFactor: 1.2),
                ],
              ),
              Row(
                children: [
                  const Text('Rating: '),
                  Text(book.rating ?? '_', textScaleFactor: 1.2),
                ],
              ),
              Row(
                children: [
                  const Text('Price: '),
                  Text(book.price, textScaleFactor: 1.2),
                ],
              ),
              Row(
                children: [
                  const Text('ISBN10: '),
                  Text(book.isbn10 ?? '_', textScaleFactor: 1.2),
                ],
              ),
              Row(
                children: [
                  const Text('ISBN13: '),
                  Text(book.isbn13, textScaleFactor: 1.2),
                ],
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetchMoreInfo() async {
    log('Fetching more info');
    try {
      final res = await Dio()
          .get('https://api.itbook.store/1.0/books/${widget.isbn13}');
      if (res.statusCode == 200) {
        final book = Book.fromJson(res.data);
        ref.read(booksProvider.notifier).updateOne(book);
      }
    } on Exception catch (e, stacktrace) {
      log(e.toString());
      log(stacktrace.toString());
    }
  }
}
