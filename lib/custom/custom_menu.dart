import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/models/menu.dart';
import '../main.dart';
import '../controllers/menu_controller.dart';

class customMenuWidgets {
  final menuController = MenuController1();

  Widget buildMenuSection(BuildContext context, Map<String, dynamic> section) {
    String title = section['title'];
    int sectionId = section['id'];

    return FutureBuilder(
      future: menuController.fetchMenuItems(sectionId: sectionId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading menu items'));
        } else {
          List<MenuItem> items = snapshot.data ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return buildMenuItem(context, items[index]);
                },
              ),
            ],
          );
        }
      },
    );
  }

  Widget buildMenuItem(BuildContext context, MenuItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(item.imageUrl ??
                    'data:image/jpeg;base64,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'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 9),
                Text(
                  '\$${item.price}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}