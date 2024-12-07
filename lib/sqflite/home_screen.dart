import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:local_stograge/sqflite/controller_database.dart';
import 'package:local_stograge/sqflite/save_screen.dart';

import 'model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ControllerDatabase db;

  Future<List<Model>>? listModel;

  Future initData() async {
    db = ControllerDatabase();
    setState(() {
      listModel = db.getData();
    });
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            title: const Text("Dating note"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SaveScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: RefreshIndicator(
              onRefresh: () => initData(),
              child: _buildBody(),
            ),
          )
        ],
      ),
    );
  }

  _buildBody() {
    return FutureBuilder<List<Model>>(
      future: listModel,
      builder: (context, AsyncSnapshot<List<Model>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Error",
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final data = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SaveScreen(
                                  model: data,
                                ),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(10),
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          onPressed: (context) async {
                            await ControllerDatabase()
                                .deleteData(id: data.id!)
                                .then(
                              (value) {
                                initData();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Note delete success'),
                                    backgroundColor: Colors.blue,
                                  ),
                                );
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(10),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              data.description,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 3,
                            ),
                            Text(
                              data.date,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
