import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:give_me_jobs_web/app/shared/models/course_model.dart';
import 'package:give_me_jobs_web/app/shared/models/vacancy_model.dart';

class HomeState {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController qntVacancyController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final pageController = PageController();

  int selectPage;
  List<CourseModel> courses;
  List<VacancyModel> vacancies;
  String labelFile;
  CourseModel? selectedCourse;
  Uint8List? notice;
  int totalVacancies;

  HomeState({
    required this.titleController,
    required this.vacancies,
    required this.totalVacancies,
    required this.descController,
    required this.qntVacancyController,
    required this.selectPage,
    required this.courses,
    required this.scaffoldKey,
    required this.labelFile,
    required this.selectedCourse,
    required this.notice,
  });
  HomeState.initialState({
    this.selectPage = 0,
    this.totalVacancies = 0,
    this.courses = const [],
    this.vacancies = const [],
    this.labelFile = 'Selecione um arquivo...',
  });

  HomeState copyWith({
    TextEditingController? titleController,
    TextEditingController? descController,
    TextEditingController? qntVacancyController,
    GlobalKey<ScaffoldState>? scaffoldKey,
    int? selectPage,
    int? totalVacancies,
    List<CourseModel>? courses,
    List<VacancyModel>? vacancies,
    String? labelFile,
    CourseModel? selectedCourse,
    Uint8List? notice,
  }) {
    return HomeState(
      notice: notice ?? this.notice,
      totalVacancies: totalVacancies ?? this.totalVacancies,
      selectedCourse: selectedCourse ?? this.selectedCourse,
      labelFile: labelFile ?? this.labelFile,
      scaffoldKey: scaffoldKey ?? this.scaffoldKey,
      titleController: titleController ?? this.titleController,
      descController: descController ?? this.descController,
      qntVacancyController: qntVacancyController ?? this.qntVacancyController,
      selectPage: selectPage ?? this.selectPage,
      courses: courses ?? this.courses,
      vacancies: vacancies ?? this.vacancies,
    );
  }

  void clear() {
    titleController.clear();
    descController.clear();
    qntVacancyController.clear();
    notice = null;
  }
}
