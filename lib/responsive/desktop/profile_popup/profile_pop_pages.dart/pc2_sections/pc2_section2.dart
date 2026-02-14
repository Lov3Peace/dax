import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/profile_popup/profile_pop_pages.dart/carousel_contents_temp.dart';
import 'package:flutter_application_1/util/imports.dart';

import '../../../../../main.dart';
import '../../../../../util/gradient_label.dart';
import '../../../../../util/tactile_button.dart';
import '../../../desk_decks.dart';

class Pc2Section2 extends StatefulWidget {
  Pc2Section2({super.key});

  @override
  State<Pc2Section2> createState() => _Pc2Section2State();
}

class _Pc2Section2State extends State<Pc2Section2> {
  List<File> uploadedFiles = [];

  Future<void> pickFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        uploadedFiles
            .addAll(result.paths.whereType<String>().map((path) => File(path)));
      });
    }
  }

  void removeFile(File file) {
    setState(() {
      uploadedFiles.remove(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CarouselContentsTemp(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(70, 32, 32, 40),
          borderRadius: const BorderRadius.all(
            Radius.circular(40),
          ),
          border: Border.all(color: deckBorderColor),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(2.h(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Showcase',
                  style: TextStyle(
                      fontSize: 5.sp(context), fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 1.h(context)),
                uploadedFiles.isEmpty
                    ? Text(
                        'Upload attachments like personal achievements, resume, transcript, or even photos...',
                        style: TextStyle(fontSize: 2.5.sp(context)),
                      )
                    : SizedBox(
                        height: 200,
                        child: SingleChildScrollView(
                          child: Column(
                            children: uploadedFiles.map((file) {
                              return ListTile(
                                title: Text(file.path.split('/').last),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => removeFile(file),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                SizedBox(height: 2.h(context)),
                TactileButton(
                  onTap: pickFiles,
                  child: GradientContainer(
                    gradient1: red,
                    gradient2: purp,
                    height: 4.h(context),
                    width: 7.w(context),
                    neonGlow: purp,
                    text: 'Upload Files',
                    textSize: 2.5.sp(context),
                    borderColor: const Color.fromARGB(0, 255, 255, 255),
                    borderRadius: 500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
