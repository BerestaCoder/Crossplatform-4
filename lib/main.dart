import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});  @override  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lime), useMaterial3: true),
      home: const MyHomePage(title: 'Списки'),);  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});  final String title;  @override  State<MyHomePage> createState() => _MyHomePageState();}

class _MyHomePageState extends State<MyHomePage> {
  final columnItems = List.generate(10, (index) => GestureDetector(
      onTap: () => setState(() => columnItems.remove(index)),
      child: Text('Предмет ${index + 1}')),
  );
  final listViewItems = List.generate(10, (index) => 'Предмет ${index + 1}');
  final listViewSeperatedItems = List.generate(10, (index) => 'Предмет ${index + 1}');

  void remove(int index) {
    setState(() {
      columnItems.removeAt(index);
    });
  }

  void _addItem() {
    setState(() {
      switch (currentPageIndex) {
        case 0:
          columnItems.add(GestureDetector(child: Text('Добавленный предмет')));
        case 1:
          listViewItems.add('Добавленный предмет');
        case 2:
          listViewSeperatedItems.add('Добавленный предмет');
      }
    });
  }

  int currentPageIndex = 0;

  @override  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,title: Text(widget.title),),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Theme.of(context).colorScheme.inversePrimary,
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.looks_one),
              icon: Icon(Icons.looks_one_outlined),
              label: 'Column',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.looks_two),
              icon: Icon(Icons.looks_two_outlined),
              label: 'ListView',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.looks_3),
              icon: Icon(Icons.looks_3_outlined),
              label: 'ListView.separated',
            ),
          ]
      ),
      body: [

        // ================ Column
        Column(
            children: columnItems
        ),

        // ================ ListView

        ListView(
            children: listViewItems.map((item) => GestureDetector(
              onTap: () => setState(() => listViewItems.remove(item)),
              child: Text(item),
            )).toList()
        ),

        // ================ ListView.separated
        ListView.separated(
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () => setState(() => listViewSeperatedItems.removeAt(index)),
              child: Text(listViewSeperatedItems[index]),
            );
          },
          separatorBuilder: (_, __) => const Divider(),
          itemCount: listViewSeperatedItems.length,
        ),

      ][currentPageIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Добавить предмет',
        child: const Icon(Icons.add),
      ),
    );
  }
}