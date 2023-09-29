import 'package:education_app/core/common/widgets/info_field.dart';
import 'package:education_app/src/course/features/materials/domain/entities/picked_resource.dart';
import 'package:flutter/material.dart';

/// The `EditResourceDialog` widget is used to display a dialog for editing
/// a picked resource's title, description, and author.
///
/// Users can input or modify the resource's title, description, and author
/// using the provided text fields. They can then confirm or cancel the changes
/// using the "Confirm" and "Cancel" buttons respectively.
class EditResourceDialog extends StatefulWidget {
  /// Creates an `EditResourceDialog` with the specified [resource].
  ///
  /// The [resource] parameter represents the picked resource that will be
  /// edited.
  const EditResourceDialog(this.resource, {super.key});

  /// The picked resource to be edited.
  final PickedResource resource;

  @override
  State<EditResourceDialog> createState() => _EditResourceDialogState();
}

class _EditResourceDialogState extends State<EditResourceDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final authorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.resource.title.trim();
    descriptionController.text = widget.resource.description.trim();
    authorController.text = widget.resource.author.trim();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoField(
                controller: titleController,
                border: true,
                hintText: 'Title',
              ),
              const SizedBox(height: 10),
              InfoField(
                controller: descriptionController,
                border: true,
                hintText: 'Description',
              ),
              const SizedBox(height: 10),
              InfoField(
                controller: authorController,
                border: true,
                hintText: 'Author',
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final newResource = widget.resource.copyWith(
                        title: titleController.text.trim(),
                        description: descriptionController.text.trim(),
                        author: authorController.text.trim(),
                        authorManuallySet: authorController.text.trim() !=
                            widget.resource.author,
                      );
                      Navigator.pop(context, newResource);
                    },
                    child: const Text('Confirm'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
