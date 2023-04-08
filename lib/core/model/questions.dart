class Questions {
  String? question_title;
  String? question_context;
  String? question_degree;
  String? question_writer;
  String? user_id;
  String? question_key;
  String? imageFile;



  Questions( this.question_title, this.question_context,
      this.question_degree, this.question_writer, this.user_id,this.imageFile, this.question_key);

  factory Questions.fromJson(String key, Map<dynamic,dynamic> json){

    return Questions(json["question_title"] as String,  json["question_context"] as String,  json["question_degree"] as String , json["question_writer"] as String, json["user_id"] as String,json["image"] as String,key);

  }
}