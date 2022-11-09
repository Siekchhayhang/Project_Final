import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:getx_testting/screen/onboarding_screen.dart';
import '../drawer/my_drawer_view.dart';
import '../drawer/my_header_drawer.dart';
import '../pages/setttings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
  // @override
  // HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController.clear();
    _priceController.clear();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  // ignore: unused_element
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.production_quantity_limits_sharp,
                      color: Colors.green,
                    ),
                    hintText: 'Product Name',
                  ),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.currency_exchange_outlined,
                      color: Colors.green,
                      size: 20,
                    ),
                    hintText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final double? price =
                        double.tryParse(_priceController.text);
                    if (price != null) {
                      await _products.add({"name": name, "price": price});
                      _nameController.text = '';
                      _priceController.text = '';
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _priceController.text = documentSnapshot['price'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              key: formKey,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.production_quantity_limits_outlined,
                      color: Colors.green,
                    ),
                    hintText: 'Product Name',
                  ),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.currency_exchange_outlined,
                      color: Colors.green,
                      size: 20,
                    ),
                    hintText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final double? price =
                        double.tryParse(_priceController.text);
                    if (price != null) {
                      await _products
                          .doc(documentSnapshot!.id)
                          .update({"name": name, "price": price});
                      _nameController.text = '';
                      _priceController.text = '';
                      if (!mounted) return;
                      Navigator.of(context).pop();
                      formKey.currentState!.reset();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await showDialog(
      context: Get.context!,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Are you sure want to delete this product?'),
          actions: [
            MaterialButton(
              onPressed: (() {
                Navigator.pop(context);
                _products.doc(productId).delete();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'You have successfully deleted a product',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            MaterialButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  int _selectedIndex = 0;
  void _navigateBottomBar(int index) {
    setState(() {
      if (_selectedIndex != 0) {
        _selectedIndex = 1;
      } else {
        _selectedIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text('Product List'),
            ],
          ),
        ),
        actions: [
          ButtonBar(
            children: [
              Row(
                children: [
                  IconButton(
                    padding: const EdgeInsets.only(right: 5),
                    alignment: Alignment.centerRight,
                    onPressed: (() {}),
                    icon: const Icon(
                      Icons.search,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Slidable(
                    startActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          borderRadius: BorderRadius.circular(12),
                          onPressed: (context) {
                            _update(documentSnapshot);
                            // formKey.currentState!.reset();
                          },
                          icon: Icons.edit,
                          label: 'Edit',
                          backgroundColor: Colors.green,
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          borderRadius: BorderRadius.circular(12),
                          onPressed: (context) {
                            _delete(documentSnapshot.id);
                          },
                          icon: Icons.delete_forever_rounded,
                          label: 'Delete',
                          backgroundColor: Colors.red,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(documentSnapshot['name']),
                      subtitle: Text(documentSnapshot['price'].toString()),
                      // trailing: SizedBox(
                      //   width: 100,
                      //   child: Row(
                      //     children: const [
                      //       // IconButton(
                      //       //     icon: const Icon(Icons.edit),
                      //       //     onPressed: () => _update(documentSnapshot)),
                      //       // IconButton(
                      //       //     icon: const Icon(Icons.delete),
                      //       //     onPressed: () => _delete(documentSnapshot.id)),
                      //     ],
                      //   ),
                      // ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

// Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OnboardingScreen()));
                },
                icon: const Icon(Icons.home)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
              icon: const Icon(Icons.settings),
            ),
            label: 'Settings',
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[500],
        elevation: 0,
        child: SingleChildScrollView(
          child: Column(
            children: const [
              MyHeaderDrawer(),
              MyDrawerListView(),
            ],
          ),
        ),
      ),
    );
  }
}
