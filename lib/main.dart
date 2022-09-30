import 'package:ajmera/booklistview/BookListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Library Management'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController bookname = TextEditingController();
  final TextEditingController authorname = TextEditingController();

  List books = [];

  Future savetask() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // var list = sharedPreferences.getStringList("key");
    books.add(
      {"author": authorname.text, "book": bookname.text},
    );
    // await sharedPreferences.setStringList("key", books as List<String>);
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.42857142857144, 891.4285714285714),
      minTextAdapt: true,
      builder: (ctx, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: authorname,
                    decoration: const InputDecoration(
                      hintText: "Author Name",
                    ),
                  ),
                  TextField(
                    controller: bookname,
                    decoration: const InputDecoration(
                      hintText: "Book Name",
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // books.clear();
                      savetask();
                    },
                    child: const Text("Submit"),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookListView(
                                  list: books,
                                )),
                      );
                    },
                    child: const Text("Fetch Data"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
