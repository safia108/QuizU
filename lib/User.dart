class User {
  late String message;
  late String token;

  User(this.message, this.token);

  factory User.fromJson(dynamic json) {
    return User(json['message'], json['token']);
  }

  @override
  String toString() {
    return '{ ${this.message}, ${this.token} }';
  }
}
