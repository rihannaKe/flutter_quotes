class Quote {
  String text;
  String author;

  Quote(String text, String author) {
    this.text = text;
    this.author = author;
  }

  Quote.fromJson(Map json)
      : text = json['text'],
        author = json['author'] == null ? 'Unknown' : json['author'];

  Map toJson() {
    return { 'text': text, 'author': author == null ? 'Unknown' : author};
  }

}