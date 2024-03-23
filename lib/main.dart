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
  final columnItems = List.generate(10, (index) => 'Предмет ${index + 1}');
  final listViewItems = List.generate(10, (index) => 'Предмет ${index + 1}');
  final listViewSeperatedItems = List.generate(10, (index) => 'Предмет ${index + 1}');
  void _addItem() {
    setState(() {
      switch (currentPageIndex) {
        case 0:
          columnItems.add('Добавленный предмет');
        case 1:
          listViewItems.add('Добавленный предмет');
        case 2:
          listViewSeperatedItems.add('Добавленный предмет');
      }
    });
  }
  void _deleteColumnItem(int index){
    setState(() {
      columnItems.removeAt(index);
    });
  }
  void _deleteListViewItem(int index){
    setState(() {
      listViewItems.removeAt(index);
    });
  }
  void _deleteListViewSeperatedItem(int index){
    setState(() {
      listViewSeperatedItems.removeAt(index);
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
        floatingActionButton: FloatingActionButton(
          onPressed: _addItem,
          tooltip: 'Добавить предмет',
          child: const Icon(Icons.add),
        ),
      body: [

        // ================ Column
        Column(
            children: [
              for (int i = 0; i < columnItems.length; i++)
                Card(
                  child: ListTile(
                    title: Text(columnItems[i]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteColumnItem(i),
                    ),
                  )
                )
            ]
        ),

        // ================ ListView

        ListView(
            children: [
              for (int i = 0; i < listViewItems.length; i++)
                Card(
                    child: ListTile(
                      title: Text(listViewItems[i]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteListViewItem(i),
                      ),
                    )
                )
            ]
        ),

        // ================ ListView.separated
        ListView.separated(
          itemBuilder: (_, index) {
            return Card(
                child: ListTile(
                  title: Text(listViewSeperatedItems[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteListViewSeperatedItem(index),
                  ),
                )
            );
          },
          separatorBuilder: (_, __) => const Divider(),
          itemCount: listViewSeperatedItems.length,
        ),
      ][currentPageIndex]
    );
  }
}