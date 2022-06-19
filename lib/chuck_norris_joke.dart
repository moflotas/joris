class ChuckNorrisJoke {
  late List<dynamic> categories;
  late String url;
  late String value;

  ChuckNorrisJoke(this.categories, this.url, this.value);

  @override
  String toString() {
    return value;
  }
}