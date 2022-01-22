import 'dart:convert';

class CandidateModel {
  final String id;
  final String name;
  final String? imgUrl;
  final String? curriculum;
  final String email;
  final String? tel;
  CandidateModel({
    required this.id,
    required this.name,
    this.imgUrl,
    this.curriculum,
    required this.email,
    this.tel,
  });

  CandidateModel copyWith({
    String? id,
    String? name,
    String? imgUrl,
    String? curriculum,
    String? email,
    String? tel,
  }) {
    return CandidateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      curriculum: curriculum ?? this.curriculum,
      email: email ?? this.email,
      tel: tel ?? this.tel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'curriculum': curriculum,
      'email': email,
      'tel': tel,
    };
  }

  factory CandidateModel.fromMap(Map<String, dynamic> map) {
    return CandidateModel(
      id: map['id'] as String,
      name: map['name'] as String,
      imgUrl: map['imgUrl'] as String?,
      curriculum: map['curriculum'] as String?,
      email: map['email'] as String,
      tel: map['tel'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory CandidateModel.fromJson(String source) =>
      CandidateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CandidateModel(id: $id, name: $name, imgUrl: $imgUrl, curriculum: $curriculum, email: $email, tel: $tel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CandidateModel &&
        other.id == id &&
        other.name == name &&
        other.imgUrl == imgUrl &&
        other.curriculum == curriculum &&
        other.email == email &&
        other.tel == tel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imgUrl.hashCode ^
        curriculum.hashCode ^
        email.hashCode ^
        tel.hashCode;
  }
}
