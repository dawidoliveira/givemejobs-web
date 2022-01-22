import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:give_me_jobs_web/app/shared/models/candidate_model.dart';
import 'package:give_me_jobs_web/app/shared/models/course_model.dart';

class VacancyModel {
  final String? id;
  final CourseModel course;
  final String title;
  final String desc;
  final int qntVacancy;
  final Uint8List? notice;
  final String? urlFile;
  final DateTime createdAt;
  final List<CandidateModel>? candidates;
  VacancyModel({
    this.id,
    required this.course,
    required this.title,
    required this.desc,
    required this.qntVacancy,
    this.notice,
    this.urlFile,
    this.candidates,
    required this.createdAt,
  });

  VacancyModel copyWith({
    String? id,
    CourseModel? course,
    String? title,
    String? desc,
    int? qntVacancy,
    Uint8List? notice,
    String? urlFile,
    DateTime? createdAt,
    List<CandidateModel>? candidates,
  }) {
    return VacancyModel(
      id: id ?? this.id,
      course: course ?? this.course,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      qntVacancy: qntVacancy ?? this.qntVacancy,
      notice: notice ?? this.notice,
      urlFile: urlFile ?? this.urlFile,
      candidates: candidates ?? this.candidates,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'course': course.toMap(),
      'title': title,
      'desc': desc,
      'qntVacancy': qntVacancy,
      'notice': notice,
      'urlFile': urlFile,
      'createdAt': createdAt,
      'candidates': candidates?.map((x) => x.toMap()).toList(),
    };
  }

  factory VacancyModel.fromMap(Map<String, dynamic> map) {
    return VacancyModel(
      id: map['id'] as String,
      course: map['course'] as CourseModel,
      title: map['title'] as String,
      desc: map['desc'] as String,
      qntVacancy: map['qntVacancy'] as int,
      notice: map['notice'] as Uint8List?,
      urlFile: map['urlFile'] as String,
      candidates: map['candidates'] as List<CandidateModel>?,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory VacancyModel.fromJson(String source) =>
      VacancyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VacancyModel(id: $id, course: $course, title: $title, desc: $desc, qntVacancy: $qntVacancy, notice: $notice, urlFile: $urlFile, candidates: $candidates, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VacancyModel &&
        other.id == id &&
        other.course == course &&
        other.title == title &&
        other.desc == desc &&
        other.qntVacancy == qntVacancy &&
        other.notice == notice &&
        other.urlFile == urlFile &&
        other.createdAt == createdAt &&
        listEquals(other.candidates, candidates);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        course.hashCode ^
        title.hashCode ^
        desc.hashCode ^
        qntVacancy.hashCode ^
        notice.hashCode ^
        urlFile.hashCode ^
        createdAt.hashCode ^
        candidates.hashCode;
  }
}
