class Book {
  String title;
  String? subtitle;
  String? authors;
  String? isbn10;
  String isbn13;
  String? pages;
  String? year;
  String? rating;
  String? desc;
  String price;
  String image;
  String url;

  Book({
    required this.title,
    this.subtitle,
    this.authors,
    this.isbn10,
    required this.isbn13,
    this.pages,
    this.year,
    this.rating,
    this.desc,
    required this.price,
    required this.image,
    required this.url,
  });

  Book.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        subtitle = json['subtitle'],
        authors = json['authors'],
        isbn10 = json['isbn10'],
        isbn13 = json['isbn13'],
        pages = json['pages'],
        year = json['year'],
        rating = json['rating'],
        desc = json['desc'],
        price = json['price'],
        image = json['image'],
        url = json['url'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['authors'] = authors;
    data['isbn10'] = isbn10;
    data['isbn13'] = isbn13;
    data['pages'] = pages;
    data['year'] = year;
    data['rating'] = rating;
    data['desc'] = desc;
    data['price'] = price;
    data['image'] = image;
    data['url'] = url;
    return data;
  }
}
