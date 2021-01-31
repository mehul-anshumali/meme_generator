class Meme {
  final String imgUrl;

  Meme({this.imgUrl});

  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
      imgUrl: json['url'],
    );
  }
}
