import 'package:education_app/core/common/widgets/course_picker.dart';
import 'package:education_app/core/common/widgets/info_field.dart';
import 'package:education_app/core/enums/notification_enum.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/extensions/int_extensions.dart';
import 'package:education_app/core/res/colours.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/features/materials/data/models/resource_model.dart';
import 'package:education_app/src/course/features/materials/domain/entities/picked_resource.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource.dart';
import 'package:education_app/src/course/features/materials/presentation/app/cubit/material_cubit.dart';
import 'package:education_app/src/course/features/materials/presentation/widgets/edit_resource_dialog.dart';
import 'package:education_app/src/course/features/materials/presentation/widgets/picked_resource_tile.dart';
import 'package:education_app/src/notifications/presentation/widgets/notification_wrapper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide MaterialState;
import 'package:flutter_bloc/flutter_bloc.dart';

/// The `AddMaterialsView` widget allows users to upload course materials.
///
/// Users can select a course, provide a general author for the materials,
/// upload multiple materials at once, and confirm the upload. The uploaded
/// materials are then associated with the selected course.
class AddMaterialsView extends StatefulWidget {
  /// Creates an `AddMaterialsView`.
  const AddMaterialsView({super.key});

  /// The route name for navigating to this view.
  static const routeName = '/add-materials';

  @override
  State<AddMaterialsView> createState() => _AddMaterialsViewState();
}

class _AddMaterialsViewState extends State<AddMaterialsView> {
  // Show loading
  bool showingLoader = false;

  // List to store picked resources for upload.
  List<PickedResource> resources = <PickedResource>[];

  // GlobalKey for the form.
  final formKey = GlobalKey<FormState>();

  // Controllers for course selection and author input.
  final courseController = TextEditingController();
  final courseNotifier = ValueNotifier<Course?>(null);
  final authorController = TextEditingController();

  // Flag to track if the author has been set manually.
  bool authorSet = false;

  /// Asynchronous method to allow the user to pick multiple resources from the
  /// device.
  ///
  /// This method uses the `FilePicker` package to open a file picker dialog,
  /// allowing the user to select one or more files. The selected files are then
  /// added to the list of `resources` with their corresponding metadata such as
  /// author and title.
  ///
  /// If the user cancels the file picker dialog or no files are selected, no
  /// changes are made to the `resources` list.
  ///
  /// This method is invoked when the "Add Materials" button is pressed.
  Future<void> pickResources() async {
    // Open the file picker dialog and await the user's selection.
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    // Check if files were selected.
    if (result != null) {
      // Iterate through the selected file paths.
      setState(() {
        resources.addAll(
          result.paths.map(
            (path) => PickedResource(
              // Set the resource's path.
              path: path!,
              // Set the author based on the user's input in the author field.
              author: authorController.text.trim(),
              // Extract the title from the file path.
              title: path.split('/').last,
            ),
          ),
        );
      });
    }
  }

  /// Edits a selected resource.
  ///
  /// This method opens a dialog for editing the selected resource. The
  /// `resourceIndex` parameter specifies the index of the resource in the
  /// `resources` list to be edited.
  ///
  /// The method creates an `EditResourceDialog`, which is a custom dialog
  /// widget for editing resource properties such as title, description, and
  /// author. The `newResource` returned by the dialog contains the updated
  /// resource data, and it is applied to the `resources` list if the user
  /// confirms the changes.
  ///
  /// If the user cancels the dialog or does not make any changes, the
  /// `resources` list remains unchanged.
  ///
  /// Parameters:
  /// - `resourceIndex`: Index of the resource to be edited.
  Future<void> editResource(int resourceIndex) async {
    // Retrieve the selected resource to be edited.
    final resource = resources[resourceIndex];

    // Open the edit resource dialog and await user input.
    final newResource = await showDialog<PickedResource>(
      context: context,
      builder: (_) => EditResourceDialog(resource),
    );

    // Check if the user confirmed the changes.
    if (newResource != null) {
      // Update the resource in the list with the edited data.
      setState(() {
        resources[resourceIndex] = newResource;
      });
    }
  }

  /// Uploads selected materials to the course.
  ///
  /// This method validates the form, checks for selected resources,
  /// and ensures that the author is confirmed. If all conditions are met,
  /// it converts the selected resources into [Resource] objects and
  /// adds them to the course materials using the [MaterialCubit].
  void uploadMaterials() {
    // Validate the form fields.
    if (formKey.currentState!.validate()) {
      // Check if any resources have been selected.
      if (this.resources.isEmpty) {
        return CoreUtils.showSnackBar(context, 'No resources picked yet');
      }

      // Check if the author has been confirmed.
      if (!authorSet && authorController.text.trim().isNotEmpty) {
        return CoreUtils.showSnackBar(
          context,
          'Please tap on the check icon in '
          'the author field to confirm the author',
        );
      }

      // Convert selected resources into Resource objects.
      final resources = <Resource>[];
      for (final resource in this.resources) {
        resources.add(
          ResourceModel.empty().copyWith(
            courseId: courseNotifier.value!.id,
            fileURL: resource.path,
            title: resource.title,
            description: resource.description,
            author: resource.author,
            fileExtension: resource.path.split('.').last,
          ),
        );
      }

      // Add the materials to the course using the MaterialCubit.
      context.read<MaterialCubit>().addMaterials(resources);
    }
  }

  /// Sets the general author for all selected resources.
  ///
  /// If the author has not been manually set for each resource,
  /// this method applies a common author to all of them and confirms it.
  void setAuthor() {
    // Check if the author has already been set, and if so, return.
    if (authorSet) return;

    // Get the trimmed text from the author input field.
    final text = authorController.text.trim();

    // Unfocus the current text input.
    FocusManager.instance.primaryFocus?.unfocus();

    // Create a new list to store updated resources.
    final newResources = <PickedResource>[];

    // Iterate through the selected resources.
    for (final resource in resources) {
      // If the author has been manually set for a resource, keep it unchanged.
      if (resource.authorManuallySet) {
        newResources.add(resource);
        continue;
      }

      // Otherwise, update the resource with the common author.
      newResources.add(resource.copyWith(author: text));
    }

    // Update the resources list and confirm that the author has been set.
    setState(() {
      resources = newResources;
      authorSet = true;
    });
  }

  @override
  void dispose() {
    courseController.dispose();
    courseNotifier.dispose();
    authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationWrapper(
      onNotificationSent: () {
        Navigator.pop(context);
      },
      child: BlocListener<MaterialCubit, MaterialState>(
        listener: (context, state) {
          if (showingLoader) {
            Navigator.pop(context);
            showingLoader = false;
          }
          if (state is MaterialError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is MaterialsAdded) {
            CoreUtils.showSnackBar(
              context,
              'Material(s) uploaded successfully',
            );
            CoreUtils.sendNotification(
              context,
              title: 'New ${courseNotifier.value!.title} '
                  'Material${resources.length.pluralize}',
              body: 'A new material has been '
                  'uploaded for ${courseNotifier.value!.title}',
              category: NotificationCategory.MATERIAL,
            );
          } else if (state is AddingMaterials) {
            CoreUtils.showLoadingDialog(context);
            showingLoader = true;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: const Text('Add Materials')),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: CoursePicker(
                        controller: courseController,
                        notifier: courseNotifier,
                      ),
                    ),
                    const SizedBox(height: 10),
                    InfoField(
                      controller: authorController,
                      border: true,
                      hintText: 'General Author',
                      onChanged: (_) {
                        if (authorSet) setState(() => authorSet = false);
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          authorSet
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          color: authorSet ? Colors.green : Colors.grey,
                        ),
                        onPressed: setAuthor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'You can upload multiple materials at once.',
                      style: context.theme.textTheme.bodySmall?.copyWith(
                        color: Colours.neutralTextColour,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (resources.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: resources.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (_, index) {
                            final resource = resources[index];
                            return PickedResourceTile(
                              resource,
                              onEdit: () => editResource(index),
                              onDelete: () {
                                setState(() {
                                  resources.removeAt(index);
                                });
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: pickResources,
                          child: const Text('Add Materials'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: uploadMaterials,
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
