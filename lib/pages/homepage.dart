import 'package:flutter/material.dart';
import 'package:pt_pick_up_platform/controllers/category_controller.dart';
import 'package:pt_pick_up_platform/controllers/order_controller.dart';
import 'package:pt_pick_up_platform/controllers/restaurant_controller.dart';
import 'package:pt_pick_up_platform/listeners/order_status_screen.dart';
import 'package:pt_pick_up_platform/models/restaurant.dart';
import 'package:pt_pick_up_platform/pages/detail_menu_item.dart';
import 'package:pt_pick_up_platform/pages/detailed_restaurant_view.dart';
import 'package:pt_pick_up_platform/pages/order_overview.dart';
import '../models/category.dart';
import 'package:pt_pick_up_platform/controllers/menu_controller.dart';

import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //For searching
  final TextEditingController searchController = TextEditingController();
  List<Restaurant> filteredRestaurants = [];
  bool isSearching = false;

  Timer? searchDebounceTimer;

  @override
  void initState() {
    super.initState();
    searchController.addListener(onSearchChange);
  }

  void onSearchChange() {
    if (searchDebounceTimer?.isActive ?? false) searchDebounceTimer?.cancel();
    searchDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      final query = searchController.text.toLowerCase();
      searchRestaurants(query);
    });
  }

  Future<void> searchRestaurants(String query) async {
    if (query.isEmpty) {
      setState(() {
        filteredRestaurants = [];
        isSearching = false;
      });
      return;
    }
    try {
      final allRestaurants = await RestaurantController().fetchRestaurants();
      setState(() {
        filteredRestaurants = allRestaurants.where((restaurant) => restaurant.name?.toLowerCase().contains(query.toLowerCase()) ?? false).toList();
      });
    } catch (e) {
      // print('Error searching for restaurants: $e');
      setState(() {
        filteredRestaurants = [];
      });
    }
  }

  Widget build(BuildContext context) {
    final categoryController = CategoryController();
    final restaurantController = RestaurantController();
    final screenSize = MediaQuery.of(context).size;
    final orderController = OrderController();
    final screenWidth = screenSize.width;

    final itemWidth = (screenSize.width / 2) - 24;
    final double titleFontSize = screenWidth < 350 ? 14 : 16;
    final double subtitleFontSize = screenWidth < 350 ? 12 : 14;
    final itemHeight = itemWidth * 1.4;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Pick-up',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              //Category listbuilder
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for restaurants',
                        prefixIcon: const Icon(Icons.search),
                        suffix: isSearching
                            ? IconButton(
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {
                                    isSearching = false;
                                    filteredRestaurants = [];
                                  });
                                },
                                icon: Icon(Icons.clear))
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onChanged: (value) {
                        setState(() {
                          isSearching = value.isNotEmpty;
                        });
                        searchRestaurants(value);
                      },
                    ),
                  ),
                  if (isSearching)
                    Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: screenSize.width < 340 ? 1 : 2,
                              childAspectRatio: 0.8, // Slightly increased height
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: filteredRestaurants.length,
                            itemBuilder: (context, index) {
                              final restaurantItem = filteredRestaurants[index];
                              final restaurantId = restaurantItem.id;

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantDetailPage(restaurant: restaurantItem)));
                                },
                                child: Hero(
                                  tag: 'restaurant-${restaurantItem.id}',
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16), // Slightly more rounded corners
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withAlpha(50), // Slightly more prominent shadow
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: const BorderRadius.vertical(
                                                top: Radius.circular(16), // Matching container's border radius
                                              ),
                                            ),
                                            child: Center(
                                              child: restaurantItem.imgUrl == null || restaurantItem.imgUrl!.isEmpty
                                                  ? const Icon(
                                                      Icons.image,
                                                      size: 40,
                                                      color: Colors.grey,
                                                    )
                                                  : Image.network(
                                                      restaurantItem.imgUrl!,
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0), // Increased padding
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(restaurantItem.name ?? 'Restaurant Name', style: Theme.of(context).textTheme.headlineMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                                                buildCategory(restaurantId: restaurantId),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                          size: 14,
                                                        ),
                                                        Text(
                                                          '${restaurantItem.rating.toStringAsFixed(1)}  ',
                                                          style: const TextStyle(fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                    Text(
                                                      '${restaurantItem.reviewCount} reviews',
                                                      style: const TextStyle(fontSize: 12),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Categories',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            height: 100,
                            child: FutureBuilder<List>(
                                // stream: null,
                                future: categoryController.fetchCategories(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasError) {
                                    return Text("There wen't something wrong: ${snapshot.error}");
                                  }
                                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return const Text('No data found');
                                  }
                                  List categories = snapshot.data!;
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categories.length,
                                    itemBuilder: (context, index) {
                                      final category = categories[index];
                                      // print(category.name);
                                      return Container(
                                        width: 90,
                                        margin: const EdgeInsets.only(right: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.deepOrange.withAlpha(25),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(category.icon, color: Colors.deepOrange, size: 28),
                                            // Text(category.iconName),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              category.name ?? 'Category name',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Popular',
                                  style: Theme.of(context).textTheme.headlineLarge,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: itemHeight, // Limit the height to fit one row
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal, // Horizontal scroll
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: itemWidth, // Set the width for each item
                                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                        decoration: BoxDecoration(
                                          color: Colors.deepOrange.withAlpha(25),
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withAlpha(25),
                                              spreadRadius: 1,
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius: const BorderRadius.vertical(
                                                    top: Radius.circular(12),
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Icon(Icons.image, size: 40, color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Popular Item ${index + 1}',
                                                      style: TextStyle(
                                                        fontSize: titleFontSize,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      'Labels/Tags',
                                                      style: TextStyle(
                                                        fontSize: subtitleFontSize, // Dynamic font size for subtitle
                                                        color: Colors.grey[600],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: const [
                                                        Icon(Icons.star, color: Colors.amber, size: 14),
                                                        Text(
                                                          ' 4.5 · 20min',
                                                          style: TextStyle(fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          FutureBuilder<List<Restaurant>>(
                            future: restaurantController.fetchRestaurants(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return const Text('There was an error');
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Text('No data found');
                              }

                              final List<Restaurant> restaurant = snapshot.data!;
                              // final restaurantId = restaurant[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Other restaurants',
                                    style: Theme.of(context).textTheme.headlineLarge,
                                  ),
                                  const SizedBox(height: 12),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: screenSize.width < 340 ? 1 : 2,
                                      childAspectRatio: 0.75,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                    ),
                                    itemCount: restaurant.length,
                                    itemBuilder: (context, index) {
                                      final restaurantItem = restaurant[index];
                                      // final retrieveCategory = await categoryController.fetchRestaurantCategory(restaurantId: restaurantItem.id);
                                      // final retrieveCategory = await categoryController.fetchRestaurantCategory(restaurantId: restaurantItem.id);
                                      final restaurantId = restaurantItem.id;

                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => RestaurantDetailPage(restaurant: restaurantItem),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: 'restaurant-${restaurantItem.id}',
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withAlpha(25),
                                                  spreadRadius: 1,
                                                  blurRadius: 10,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                                    ),
                                                    child: Center(
                                                      child: restaurantItem.imgUrl == null || restaurantItem.imgUrl!.isEmpty
                                                          ? const Icon(
                                                              Icons.image,
                                                              size: 40,
                                                              color: Colors.grey,
                                                            )
                                                          : Image.network(
                                                              restaurantItem.imgUrl!,
                                                              fit: BoxFit.cover,
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          restaurantItem.name ?? 'Restaurant Name',
                                                          style: Theme.of(context).textTheme.headlineMedium,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        buildCategory(restaurantId: restaurantId),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Colors.amber,
                                                                  size: 14,
                                                                ),
                                                                Text(
                                                                  '${restaurantItem.rating.toStringAsFixed(1)}  ',
                                                                  style: const TextStyle(fontSize: 12),
                                                                ),
                                                              ],
                                                            ),

                                                            // Text(
                                                            //   '20min',
                                                            //   style: const TextStyle(fontSize: 12),
                                                            // ),
                                                            Text(
                                                              '${restaurantItem.reviewCount} reviews',
                                                              style: const TextStyle(fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // Set the current index
        onTap: (index) {
          if (index == 0) {
            // Navigate to Home Page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 1) {
            // Navigate to Orders Page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OrdersPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Orders'),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showMenuItemDetails(context);
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  @override
  void dispose() {
    searchDebounceTimer?.cancel();
    searchController.dispose();
    super.dispose();
  }
}

// void showMenuItemDetails(
//   BuildContext context,
// ) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (_) => MenuItemBottomSheet( menuItem: ,),
//   );
// }

Widget buildCategory({required restaurantId}) {
  return LayoutBuilder(builder: (context, constraints) {
    return FutureBuilder<List<Category>>(
        future: CategoryController().fetchRestaurantCategory(restaurantId: restaurantId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('There was an error');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const SizedBox.shrink();
          }
          final categories = snapshot.data!;
          if (constraints.maxWidth < 200) {
            return const SizedBox.shrink();
          }

          return Wrap(
            spacing: 8,
            runSpacing: 4,
            children: categories.map((category) {
              return Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category.name,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
          );
        });
  });
}
