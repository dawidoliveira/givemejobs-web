import 'package:flutter/material.dart';
import 'package:give_me_jobs_web/app/modules/home/home_store.dart';
import 'package:give_me_jobs_web/app/shared/models/course_model.dart';

class SelectInputCourseWidget extends StatelessWidget {
  const SelectInputCourseWidget({
    Key? key,
    required this.store,
  }) : super(key: key);

  final HomeStore store;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: DropdownButtonFormField(
        hint: const Text('Selecione um curso...'),
        value: store.state.selectedCourse,
        onChanged: (value) {
          store.changeData(
            course: value as CourseModel?,
          );
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 17),
        ),
        items: [
          ...store.state.courses.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e.name),
            );
          }),
        ],
      ),
    );
  }
}
