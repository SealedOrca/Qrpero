import 'package:ap1/screens/dscreen.dart';
import 'package:ap1/setting/about.dart';
import 'package:ap1/setting/autosetting.dart';
import 'package:ap1/setting/customersupport.dart';
import 'package:ap1/setting/faq.dart';
import 'package:ap1/sp.dart';
import 'package:flutter/material.dart';

class MyTabBar extends StatefulWidget {
  final DataManager dataManager;

  const MyTabBar({Key? key, required this.dataManager}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyTabBarState createState() => _MyTabBarState();
}

class _TabItem {
  final String label;
  final IconData icon;

  _TabItem(this.label, this.icon);
}

class _MyTabBarState extends State<MyTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<_TabItem> _tabs = [
    _TabItem('History', Icons.history),
    _TabItem('Favorites', Icons.favorite_border),
  ];

  final selectedItems = <String>{};
  bool isDeleting = false;

  final scanSettings = ScanSettings();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner App'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text(''),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/cpq.jpg'), // Replace with your cover photo
                  fit: BoxFit.cover,
                ),
              ),
              accountEmail: null,
            ),
            ListTile(
              title: const Text('Customer Support'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactSupportSettingsPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('FAQ Screen'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAQScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: _tabs.length,
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: _tabs.map((tab) {
                return Tab(
                  text: tab.label,
                  icon: Icon(
                    tab.icon,
                    color: const Color.fromARGB(255, 8, 8, 8),
                  ),
                );
              }).toList(),
              indicatorColor: Colors.white,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  HistoryScreen(
                    dataManager: widget.dataManager,
                    selectedItems: selectedItems,
                    onDelete: _deleteItem,
                    onFavoritePressed: _onFavoritePressed,
                  ),
                  FavoritesScreen(
                    dataManager: widget.dataManager,
                    onFavoritePressed: _onFavoritePressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onFavoritePressed(String uniqueId) {
    widget.dataManager.toggleFavorite(uniqueId);
  }

  void _deleteItem(String uniqueId) {
    setState(() {
      selectedItems.remove(uniqueId);
    });
  }
}

class HistoryScreen extends StatefulWidget {
  final DataManager dataManager;
  final Set<String> selectedItems;
  final Function(String) onDelete;
  final Function(String) onFavoritePressed;

  const HistoryScreen({
    Key? key,
    required this.dataManager,
    required this.selectedItems,
    required this.onDelete,
    required this.onFavoritePressed,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool isDeleting = false;
  bool showSelectAllIcon = false;
  List<Map<String, dynamic>> historyData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (widget.selectedItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showDeleteMenu(context);
              },
            ),
          if (showSelectAllIcon && !isDeleting && historyData.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.select_all_sharp),
              onPressed: () {
                _selectAllItems(context);
              },
            ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getHistoryData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              historyData = snapshot.data!;
              showSelectAllIcon = widget.selectedItems.isNotEmpty;

              if (historyData.isEmpty) {
                return const Center(
                  child: Text('No scan data available'),
                );
              }

              return isDeleting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: historyData.length,
                      itemBuilder: (context, index) {
                        final item = historyData[index];
                        final isSelected =
                            widget.selectedItems.contains(item['uniqueId']);

                        return ListTile(
                          leading: Checkbox(
                            value: isSelected,
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  widget.selectedItems.add(item['uniqueId']);
                                } else {
                                  widget.selectedItems.remove(item['uniqueId']);
                                }
                                showSelectAllIcon = widget.selectedItems.isNotEmpty;
                              });
                            },
                          ),
                          title: Text(item['data'] as String),
                          subtitle: Text('ID: ${item['uniqueId']}'),
                          trailing: FutureBuilder<bool>(
                            future: _isItemFavorite(item['uniqueId']),
                            builder: (context, favoriteSnapshot) {
                              if (favoriteSnapshot.connectionState ==
                                  ConnectionState.done) {
                                final isFavorite =
                                    favoriteSnapshot.data ?? false;
                                return IconButton(
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isFavorite ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () {
                                    _handleFavoriteAction(item['uniqueId']);
                                  },
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DataDetailScreen(
                                  data: item['data'],
                                  item: item,
                                  dataManager: widget.dataManager,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
            }
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _getHistoryData() async {
    return await widget.dataManager.getHistoryItems() ?? [];
  }

  Future<bool> _isItemFavorite(String uniqueId) async {
    return await widget.dataManager.isFavorite(uniqueId);
  }

  void _showDeleteMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Items'),
          content: const Text(
              'Do you want to delete the selected items or all items?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete Selected'),
              onPressed: () {
                _deleteSelectedItems();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteSelectedItems() async {
    final selectedIds =
        widget.selectedItems.toList(); // Create a copy of the set
    for (var id in selectedIds) {
      await widget.dataManager
          .removeFromHistory(id); // Remove each item from the database
      widget.selectedItems.remove(id); // Remove the item from the set
    }
    setState(() {
      showSelectAllIcon = widget.selectedItems.isNotEmpty;
    });
  }

  void _selectAllItems(BuildContext context) {
    for (var item in historyData) {
      widget.selectedItems.add(item['uniqueId']);
    }
    setState(() {
      showSelectAllIcon = true;
    });
  }

  void _handleFavoriteAction(String uniqueId) async {
    await widget.onFavoritePressed(uniqueId);
    setState(() {});
  }
}

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
              subtitle: Text(
                  'ID: ${item['uniqueIdReference']}'), // Use uniqueIdReference here
              trailing: IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () async {
                  _loadFavoriteItems();
                  await widget.dataManager.removeFromFavorites(
                      item['uniqueIdReference']); // Use uniqueIdReference here
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









