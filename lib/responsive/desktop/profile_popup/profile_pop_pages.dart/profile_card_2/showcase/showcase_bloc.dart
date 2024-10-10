import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

abstract class UploadEvent {}

class FileUploaded extends UploadEvent {
  final File file;

  FileUploaded(this.file);
}

class FileRemoved extends UploadEvent {
  final File file;

  FileRemoved(this.file);
}

class UploadState {
  final List<File> uploadedFiles;

  UploadState({required this.uploadedFiles});
}

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc() : super(UploadState(uploadedFiles: [])) {
    on<FileUploaded>(_onFileUploaded);
    on<FileRemoved>(_onFileRemoved);
    _loadUploadedFiles();
  }

  Future<void> _onFileUploaded(FileUploaded event, Emitter<UploadState> emit) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = event.file.uri.pathSegments.last;
    final savedFile = await event.file.copy('${appDir.path}/$fileName');

    final updatedFiles = List<File>.from(state.uploadedFiles)..add(savedFile);
    emit(UploadState(uploadedFiles: updatedFiles));
  }

  Future<void> _onFileRemoved(FileRemoved event, Emitter<UploadState> emit) async {
    final updatedFiles = List<File>.from(state.uploadedFiles)..remove(event.file);
    emit(UploadState(uploadedFiles: updatedFiles));

    // Optionally delete the file from local storage
    if (await event.file.exists()) {
      await event.file.delete();
    }
  }

  Future<void> _loadUploadedFiles() async {
    final appDir = await getApplicationDocumentsDirectory();
    final files = appDir.listSync().whereType<File>().toList();
    emit(UploadState(uploadedFiles: files));
  }
}
