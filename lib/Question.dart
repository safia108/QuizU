class Questions {
  late String Question;
  late String a;
  late String b;
  late String c;
  late String d;
  late String correct;

  Questions(this.Question, this.a, this.b, this.c, this.d, this.correct);

  factory Questions.fromJson(dynamic json) {
    return Questions(json['Question'], json['a'], json['b'], json['c'],
        json['d'], json['correct']);
  }

  @override
  String toString() {
    return '{ ${this.Question} , ${this.a} , ${this.b} , ${this.c} , ${this.d} , ${this.correct} }';
  }
}
