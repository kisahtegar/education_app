import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/src/course/features/materials/domain/entities/picked_resource.dart';
import 'package:education_app/src/course/features/materials/presentation/widgets/picked_resource_horizontal_text.dart';
import 'package:flutter/material.dart';

/// The `PickedResourceTile` widget is used to display a tile for a picked
/// resource.
///
/// This widget is typically used in a list or grid to represent a single picked
/// resource. It displays the resource's name, author, title, and description,
/// along with edit and delete buttons.
class PickedResourceTile extends StatelessWidget {
  /// Creates a `PickedResourceTile` widget with the specified [resource],
  /// [onEdit], and [onDelete] callbacks.
  ///
  /// The [resource] parameter represents the picked resource to display.
  /// The [onEdit] callback is invoked when the edit button is pressed,
  /// and the [onDelete] callback is invoked when the delete button is pressed.
  const PickedResourceTile(
    this.resource, {
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  /// The picked resource to display in the tile.
  final PickedResource resource;

  /// A callback function invoked when the edit button is pressed.
  final VoidCallback onEdit;

  /// A callback function invoked when the delete button is pressed.
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Image.asset(MediaRes.material),
            ),
            title: Text(
              resource.path.split('/').last,
              maxLines: 1,
            ),
            contentPadding: const EdgeInsets.only(left: 16, right: 5),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
                IconButton(onPressed: onDelete, icon: const Icon(Icons.close)),
              ],
            ),
          ),
          const Divider(height: 1),
          PickedResourceHorizontalText(label: 'Author', value: resource.author),
          PickedResourceHorizontalText(label: 'Title', value: resource.title),
          PickedResourceHorizontalText(
            label: 'Description',
            value: resource.description.trim().isEmpty
                ? '"None"'
                : resource.description,
          ),
        ],
      ),
    );
  }
}
