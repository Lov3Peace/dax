import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/tactile_button.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../util/gradient_container.dart';
import 'showcase_bloc.dart';

class UploadShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadBloc(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Showcase',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            BlocBuilder<UploadBloc, UploadState>(
              builder: (context, state) {
                if (state.uploadedFiles.isEmpty) {
                  return Text(
                    'Upload attachments like personal achievements, resume, transcript, or even photos...',
                    style: TextStyle(fontSize: 16),
                  );
                } else {
                  return SizedBox(
                    height: 200, // Height for the scrollable container
                    child: SingleChildScrollView(
                      child: Column(
                        children: state.uploadedFiles.map((file) {
                          return ListTile(
                            title: Text(file.path.split('/').last),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                BlocProvider.of<UploadBloc>(context).add(FileRemoved(file));
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 2.h,
            ),
            TactileButton(
              onTap: () {
                _pickFiles(context);
              },
              child: GradientContainer(
                gradient1: red,
                gradient2: purp,
                height: 5,
                width: 20,
                neonGlow: purp,
                text: 'Upload Files',
                textSize: 12,
                borderColor: const Color.fromARGB(0, 255, 255, 255),
                borderRadius: 500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFiles(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      for (var filePath in result.paths) {
        if (filePath != null) {
          final file = File(filePath);
          BlocProvider.of<UploadBloc>(context).add(FileUploaded(file));
        }
      }
    }
  }
}
