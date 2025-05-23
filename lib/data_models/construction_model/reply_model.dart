import 'dart:io';

class ReplyModel {
  String? creditLineId;
  String? questionId;
  String? reply;
  List<File>? documents;
  ReplyModel({this.creditLineId, this.questionId, this.reply, this.documents});
}
