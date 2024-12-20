import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timekeeper/app/home/jobs/edit_job_page.dart';
import 'package:timekeeper/app/home/jobs/job_entries/entry_list_item.dart';
import 'package:timekeeper/app/home/jobs/job_entries/entry_page.dart';
import 'package:timekeeper/app/home/jobs/list_items_builder.dart';
import 'package:timekeeper/app/home/models/entry.dart';
import 'package:timekeeper/app/home/models/job.dart';
import 'package:timekeeper/common_widgets/show_exception_alert_dialog.dart';
import 'package:timekeeper/services/database.dart';

class JobEntriesPage extends StatelessWidget {
  const JobEntriesPage({
    required this.database,
    required this.job,
  });
  final Database database;
  final Job job;

  static Future<void> show(BuildContext context, Job job) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) => JobEntriesPage(
          database: database,
          job: job,
        ),
      ),
    );
  }

  Future<void> _deleteEntry(BuildContext context, Entry entry) async {
    try {
      await database.deleteEntry(entry);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: database.jobStream(jobId: job.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final job = snapshot.data!;
          final jobName = job.name;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.chevron_left_sharp,
                  color: Colors.white,
                ), // Back button color
                onPressed: () => Navigator.pop(context),
              ),
              backgroundColor: Colors.indigo,
              elevation: 2.0,
              title: Text(
                jobName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      EditJobPage.show(context, database: database, job: job),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () =>
                      EntryPage.show(context, database: database, job: job),
                ),
              ],
            ),
            body: _buildContent(context, job),
          );
        });
  }

  Widget _buildContent(BuildContext context, Job job) {
    return StreamBuilder<List<Entry>>(
      stream: database.entriesStream(job: job),
      builder: (context, snapshot) {
        return ListItemsBuilder<Entry>(
          snapshot: snapshot,
          itemBuilder: (context, entry) {
            return DismissibleEntryListItem(
              key: Key('entry-${entry.id}'),
              entry: entry,
              job: job,
              onDismissed: () => _deleteEntry(context, entry),
              onTap: () => EntryPage.show(
                context,
                database: database,
                job: job,
                entry: entry,
              ),
            );
          },
        );
      },
    );
  }
}
