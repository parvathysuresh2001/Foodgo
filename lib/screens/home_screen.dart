import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class FoodItem {
  final String name;
  final String subtitle;
  final String image;
  final double rating;
  bool isFavorite;

  FoodItem({
    required this.name,
    required this.subtitle,
    required this.image,
    required this.rating,
    this.isFavorite = false,
  });
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color foodgoYellow = Color(0xFFF7C331);
  static const Color darkText = Color(0xFF1F2333);

  int _selectedCategory = 0;
  final List<String> _categories = ['All', 'Combos', 'Sliders', 'Classics'];

  final List<FoodItem> _foods = [
    FoodItem(
      name: 'Cheeseburger',
      subtitle: "Wendy's Burger",
      image: 'assets/image1.png',
      rating: 4.9,
    ),
    FoodItem(
      name: 'Hamburger',
      subtitle: 'Veggie Burger',
      image: 'assets/image2.png',
      rating: 4.8,
    ),
    FoodItem(
      name: 'Hamburger',
      subtitle: 'Chicken Burger',
      image: 'assets/image3.png',
      rating: 4.6,
    ),
    FoodItem(
      name: 'Hamburger',
      subtitle: 'Fried Chicken Burger',
      image: 'assets/image4.png',
      rating: 4.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: title + profile avatar
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Foodgo',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Order your favourite food!',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 26,
                          backgroundImage: const AssetImage(
                            'assets/profile.png',
                          ),
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Search bar + filter button
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.search, color: Colors.black45),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Search',
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade500,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: foodgoYellow,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.tune, color: darkText),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Category chips
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final selected = index == _selectedCategory;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedCategory = index),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selected
                                    ? foodgoYellow
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _categories[index],
                                style: TextStyle(
                                  color: selected ? darkText : Colors.black54,
                                  fontWeight: selected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Food grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _foods.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.78,
                          ),
                      itemBuilder: (context, index) {
                        return _FoodCard(
                          item: _foods[index],
                          onFavoriteToggle: () {
                            setState(() {
                              _foods[index].isFavorite =
                                  !_foods[index].isFavorite;
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: foodgoYellow,
        elevation: 4,
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(CupertinoIcons.add, color: Colors.white, size: 34),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: foodgoYellow,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.house_fill,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.person,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const SizedBox(width: 48),

              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.doc_text,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.heart,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FoodCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback onFavoriteToggle;

  const _FoodCard({required this.item, required this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(child: Image.asset(item.image, fit: BoxFit.contain)),
          ),
          const SizedBox(height: 8),
          Text(
            item.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          Text(
            item.subtitle,
            style: const TextStyle(color: Colors.black45, fontSize: 12),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text('${item.rating}', style: const TextStyle(fontSize: 13)),
                ],
              ),
              GestureDetector(
                onTap: onFavoriteToggle,
                child: Icon(
                  item.isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 20,
                  color: item.isFavorite ? Colors.redAccent : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
