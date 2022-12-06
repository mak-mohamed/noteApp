class Note {
  int? noteId;
  int? noteIdusers;
  String? noteTitle;
  String? noteBody;
  String? noteImage;

  Note(
      {this.noteId,
      this.noteIdusers,
      this.noteTitle,
      this.noteBody,
      this.noteImage});

  Note.fromJson(Map<String, dynamic> json) {
    noteId = json['note_id'];
    noteIdusers = json['note_idusers'];
    noteTitle = json['note_title'];
    noteBody = json['note_body'];
    noteImage = json['note_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['note_id'] = noteId;
    data['note_idusers'] = noteIdusers;
    data['note_title'] = noteTitle;
    data['note_body'] = noteBody;
    data['note_image'] = noteImage;
    return data;
  }
}
