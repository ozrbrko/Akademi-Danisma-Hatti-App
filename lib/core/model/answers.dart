class Answers {
  String? answer_context;
  String? answer_writer;
  String? user_id;
  String? answer_key;


  Answers(
      this.answer_context, this.answer_writer, this.user_id, this.answer_key);

  factory Answers.fromJson(String key, Map<dynamic,dynamic> json){

    return Answers(json["answer_context"] as String,  json["answer_writer"] as String,  json["user_id"] as String ,key);

  }
}