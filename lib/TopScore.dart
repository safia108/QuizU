class TopScore {
  late String name;
  late String score;

  TopScore(this.name, this.score);

  factory TopScore.fromJson(dynamic json) {
    return TopScore(json['name'], json['score']);
  }

  @override
  String toString() {
    return '{ ${this.name} , ${this.score} }';
  }
}
