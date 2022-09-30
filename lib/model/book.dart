class Book {
  String authorname;
  String bookname;

  Book({required this.authorname, required this.bookname}) {
    authorname = this.authorname;
    bookname = this.bookname;
  }

  toJson() {
    return {"authorname": authorname, "bookname": bookname};
  }

  fromJson(jsonData) {
    return Book(
        authorname: jsonData['authorname'], bookname: jsonData['bookname']);
  }

  Book.fromJson(Map<String, dynamic> json)
      : authorname = json['author'],
        bookname = json['book'];
}
