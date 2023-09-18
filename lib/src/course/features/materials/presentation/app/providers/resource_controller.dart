// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:education_app/src/course/features/materials/domain/entities/resource.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controller class for managing the download and caching of educational resources.
class ResourceController extends ChangeNotifier {
  /// Initializes a [ResourceController] instance.
  ///
  /// Requires a [FirebaseStorage] instance for managing cloud storage operations
  /// and a [SharedPreferences] instance for caching file paths.
  ResourceController({
    required FirebaseStorage storage,
    required SharedPreferences prefs,
  })  : _storage = storage,
        _prefs = prefs;

  final FirebaseStorage _storage;
  final SharedPreferences _prefs;

  Resource? _resource;

  bool _loading = false;
  bool _downloading = false;

  double _percentage = 0;

  /// Returns the download progress percentage.
  double get percentage => _percentage;

  /// Returns `true` if a download operation is in progress, `false` otherwise.
  bool get loading => _loading;

  /// Returns `true` if a file is currently being downloaded, `false` otherwise.
  bool get downloading => _downloading;

  /// Returns the currently managed educational resource.
  Resource? get resource => _resource;

  /// Generates a unique key for caching the path of a downloaded educational
  /// resource file in SharedPreferences. The key is constructed by
  /// concatenating the string 'material_file_path' with the ID of the
  /// currently managed educational resource.
  String get _pathKey => 'material_file_path${_resource!.id}';

  /// Initializes the controller with a specific educational resource.
  ///
  /// If the provided resource is the same as the current one, no action is taken.
  void init(Resource resource) {
    if (_resource == resource) return;
    _resource = resource;
  }

  /// Retrieves a cached file from the device's storage.
  ///
  /// Returns a [File] object if the file exists in the cache, or `null` otherwise.
  Future<File> _getFileFromCache() async {
    final cachedFilePath = _prefs.getString(_pathKey);
    return File(cachedFilePath!);
  }

  /// Checks if a cached file exists.
  ///
  /// Returns `true` if the cached file exists; otherwise, it returns `false`
  /// and removes the cached file path from preferences if it doesn't exist.
  bool get fileExists {
    // Retrieve the cached file path from SharedPreferences using the _pathKey.
    final cachedFilePath = _prefs.getString(_pathKey);
    // If the cached file path is null, no file exists, so return false.
    if (cachedFilePath == null) return false;
    // Create a File object using the cached file path.
    final file = File(cachedFilePath);
    // Check if the file actually exists on the device's file system.
    final fileExists = file.existsSync();
    // If the file does not exist, remove the cached file path from SharedPreferences.
    if (!fileExists) _prefs.remove(_pathKey);
    // Return whether the file exists or not.
    return fileExists;
  }

  /// Downloads and saves the educational resource file to the device's cache.
  ///
  /// This method initiates the download process, tracks progress, and caches the
  /// downloaded file upon successful completion.
  ///
  /// Returns a [File] object representing the downloaded file or `null` if the
  /// download fails.
  Future<File?> downloadAndSaveFile() async {
    // Set loading and downloading flags to true.
    _loading = true;
    _downloading = true;
    notifyListeners();

    // Get the device's temporary directory.
    final cacheDir = await getTemporaryDirectory();
    final file = File(
      '${cacheDir.path}/'
      '${_resource!.id}.${_resource!.fileExtension}',
    );

    // Check if the file already exists in the cache.
    if (file.existsSync()) return file;

    try {
      // Create a reference to the file on Firebase Storage.
      final ref = _storage.refFromURL(_resource!.fileURL);
      var successful = false;

      // Start the download task.
      final downloadTask = ref.writeToFile(file);

      // Listen to snapshot events to track download progress.
      downloadTask.snapshotEvents.listen((taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            // Calculate and update the download progress percentage.
            _percentage =
                taskSnapshot.bytesTransferred / taskSnapshot.totalBytes;
            notifyListeners();
          case TaskState.paused:
            break;
          case TaskState.success:
            // Download completed successfully.
            _downloading = false;

            // Save the file path to SharedPreferences for future access.
            await _prefs.setString(_pathKey, file.path);
            successful = true;
          case TaskState.canceled:
            successful = false;
          case TaskState.error:
            successful = false;
        }
      });

      // Wait for the download task to complete.
      await downloadTask;

      // Return the downloaded file if the download was successful.
      return successful ? file : null;
    } catch (e) {
      return null;
    } finally {
      // Set loading and downloading flags to false and notify listeners.
      _loading = false;
      _downloading = false;
      notifyListeners();
    }
  }

  /// Deletes the cached educational resource file from the device's storage.
  Future<void> deleteFile() async {
    if (fileExists) {
      final file = await _getFileFromCache();
      await file.delete();
      await _prefs.remove(_pathKey);
    }
  }

  /// Opens the cached educational resource file using an appropriate application.
  Future<void> openFile() async {
    if (fileExists) {
      final file = await _getFileFromCache();
      await OpenFile.open(file.path);
    }
  }
}
