class Token {
  final String? token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(token: json["token"]);
  }
}
