import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scroll_to_example/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Scroll To Top & Bottom';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = ScrollController();
  int index = 0;

  @override
  void initState() {
    super.initState();

    controller.addListener(listenScrolling);
  }

  void listenScrolling() {
    if (controller.position.atEdge) {
      final isTop = controller.position.pixels == 0;

      if (isTop) {
        Utils.showSnackBar(context, text: 'Reached Start');
      } else {
        Utils.showSnackBar(context, text: 'Reached End');
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: buildList(),
        bottomNavigationBar: buildBottomBar(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_downward),
          onPressed: scrollDown,
        ),
      );

  Widget buildList() => ListView.builder(
        controller: controller,
        itemCount: 50,
        itemBuilder: (context, index) => ListTile(
          title: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(fontSize: 32),
            ),
          ),
        ),
      );

  Widget buildBottomBar() {
    final style = TextStyle(color: Colors.white);

    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_upward),
          title: Text('Scroll To Top', style: style),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_downward),
          title: Text('Scroll To Bottom', style: style),
        ),
      ],
      onTap: (int index) {
        final isSwitchingTab = this.index != index;
        setState(() => this.index = index);

        if (isSwitchingTab) return;
        final isScrollingTop = index == 0;

        if (isScrollingTop) {
          scrollUp();
        } else {
          scrollDown();
        }
      },
    );
  }

  void scrollUp() {
    final double start = 0;

    controller.jumpTo(start);
    // controller.animateTo(start, duration: Duration(seconds: 1), curve: Curves.easeIn);
  }

  void scrollDown() {
    final double end = controller.position.maxScrollExtent;

    controller.jumpTo(end);
    // controller.animateTo(end, duration: Duration(seconds: 1), curve: Curves.easeIn);
  }
}
