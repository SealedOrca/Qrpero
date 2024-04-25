import 'package:ap1/screens/dscreen.dart';
import 'package:ap1/sp.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  final DataManager dataManager;
  final Function(String) onFavoritePressed;

  const FavoritesScreen({
    Key? key,
    required this.dataManager,
    required this.onFavoritePressed,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteItems();
  }

  Future<void> _loadFavoriteItems() async {
    final favoriteData = await widget.dataManager.getFavoriteItems();
    if (favoriteData != null) {
      setState(() {
        favoriteItems = favoriteData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteItems[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DataDetailScreen(
                    data: item['data'],
                    dataManager: widget.dataManager,
                  ),
                ),
              );
            },
            child: ListTile(
              leading: const Icon(
                Icons.arrow_right,
                color: Colors.black,
              ),
              title: Text(item['data'] as String),
              subtitle: Text('ID: ${item['uniqueId']}'),
              trailing: IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () async {
                  _loadFavoriteItems();
                  await widget.dataManager
                      .removeFromFavorites(item['uniqueId']);
                  _loadFavoriteItems();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
