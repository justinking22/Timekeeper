import 'package:flutter/material.dart';
import 'package:timekeeper/app/home/models/job.dart';

class JobListTile extends StatelessWidget {
  const JobListTile({
    super.key,
    required this.job,
    required this.onTap,
  });

  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
