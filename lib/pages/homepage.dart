import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pt_pick_up_platform/auth/auth_provider.dart';
import 'package:pt_pick_up_platform/controllers/category_controller.dart';
import 'package:pt_pick_up_platform/controllers/order_controller.dart';
import 'package:pt_pick_up_platform/controllers/restaurant_controller.dart';
import 'package:pt_pick_up_platform/listeners/order_status_screen.dart';
import 'package:pt_pick_up_platform/models/restaurant.dart';
import 'package:pt_pick_up_platform/pages/account_page.dart';
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
  int? selectedCategoryId;
  bool isCategoryFilterd = true;
  // bool isLoading = true;

  List<Restaurant> allRestaurants = [];

  Timer? searchDebounceTimer;

  Future<void> filterRestaurantsByCategory(int categoryId) async {
    setState(() {
      selectedCategoryId = selectedCategoryId == categoryId ? null : categoryId;
    });
  }

  void resetCategoryFilter() {
    setState(() {
      selectedCategoryId = null;
    });
  }

  Future<void> resetRestaurantFilter() async {
    setState(() {
      selectedCategoryId = null;
      isCategoryFilterd = false;
    });
  }

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

  // void resetFilter() {
  //   setState(() {
  //     filteredRestaurants = allRestaurants;
  //     selectedCategoryId = null;
  //   });
  // }

  Widget build(BuildContext context) {
// final authProvider = Provider.of<AuthProvider>(context);

    final authProvider = Provider.of<AuthProvider>(context);

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
            icon: Icon(authProvider.isLoggedIn ? Icons.logout : Icons.login),
            // icon: Icon(Icons.logout),

            onPressed: () {
              if (authProvider.isLoggedIn) {
                authProvider.logOut();
              } else {
                Navigator.pushNamed(context, '/login');
              }
            },
            tooltip: authProvider.isLoggedIn ? 'Log out' : 'Log in',
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
                                      return GestureDetector(
                                        onTap: () => filterRestaurantsByCategory(category.id),
                                        child: Container(
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
                                        ),
                                      );
                                    },
                                  );
                                }),
                          ),
                          if (selectedCategoryId != null)
                            //** To remove  the popular tag */
                            // const SizedBox.shrink()

                            Padding(padding: EdgeInsets.only(top: 50), child: Text('All restaurants with the selected category'))
                          else
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
                                  FutureBuilder<List<Restaurant>>(
                                      future: restaurantController.retrievePopularRestaurants(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (snapshot.hasError) {
                                          return const Text("There was an error");
                                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                          return const Text('No data fond');
                                        }

                                        //         FutureBuilder<List<Restaurant>>(
                                        // future: restaurantController.fetchRestaurants(),
                                        // builder: (context, snapshot) {
                                        //   if (snapshot.connectionState == ConnectionState.waiting) {
                                        //     return const Center(child: CircularProgressIndicator());
                                        //   } else if (snapshot.hasError) {
                                        //     return const Text('There was an error');
                                        //   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                        //     return const Text('No data found');
                                        //   }

                                        final List<Restaurant> popularRestaurants = snapshot.data!;

                                        return SizedBox(
                                          height: itemHeight, // Limit the height to fit one row
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: popularRestaurants.length,
                                            itemBuilder: (context, index) {
                                              final restaurantItem = popularRestaurants[index];
                                              final restaurantId = restaurantItem.id;
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
                                                          //  Icon(Icons.image, size: 40, color: Colors.grey),
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
                                                              restaurantItem.name ?? "Unknown Restaurant",
                                                              style: TextStyle(
                                                                fontSize: titleFontSize,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                            buildCategory(restaurantId: restaurantId),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.star, color: Colors.amber, size: 14),
                                                                Text(
                                                                  ' ${restaurantItem.rating.toStringAsFixed(1)} · ${restaurantItem.reviewCount} reviews',
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
                                        );
                                      })
                                ],
                              ),
                            ),
                          FutureBuilder<List<Restaurant>>(
                            future: selectedCategoryId != null ? RestaurantController().fetchRestaurantsByCategory(selectedCategoryId!) : restaurantController.fetchRestaurants(),

                            // : restaurantController.fetchRestaurants(),
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
                                  selectedCategoryId != null
                                      ? SizedBox()
                                      : Text(
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
        currentIndex: 0,
        onTap: (index) {
          // if (index == 0) {
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (context) => const HomePage()),
          //   );
          // }
          if (index == 1) {
            Navigator.of(context).pushReplacementNamed('/order-overview');
          } else if (index == 2) {
            Navigator.of(context).pushReplacementNamed('/account');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account')
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchDebounceTimer?.cancel();
    searchController.dispose();
    super.dispose();
  }

  Widget displayFilterCategory() {
    return Scaffold();
  }
}

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
