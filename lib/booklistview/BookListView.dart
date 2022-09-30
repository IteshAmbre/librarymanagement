// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookListView extends StatefulWidget {
  final Iterable list;
  const BookListView({Key? key, required this.list}) : super(key: key);

  @override
  State<BookListView> createState() => _BookListViewState(list);
}

class _BookListViewState extends State<BookListView> {
  Iterable list;
  _BookListViewState(
    this.list,
  );

  TextEditingController search = TextEditingController();

  Stream<dynamic> getRandomNumberFact() async* {
    yield* Stream.periodic(const Duration(seconds: 5), (_) async {
      return list;
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    // print(list);
    return ScreenUtilInit(
        designSize: const Size(411.42857142857144, 891.4285714285714),
        minTextAdapt: true,
        // splitScreenMode: true,
        builder: (ctx, child) {
          return Scaffold(
            body: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.h, right: 10.h, top: 50.h),
                    child: TextField(
                      controller: search,
                      decoration: const InputDecoration(
                        hintText: "Search",
                      ),
                    ),
                  ),
                  StreamBuilder<dynamic>(
                    stream: getRandomNumberFact(),
                    builder: (context, snapshot) {
                      List? data = snapshot.data;
                      List filterlist = [];
                      var hello = list.where((element) =>
                          element['author']
                                  .toLowerCase()
                                  .contains(search.text.toLowerCase()) ==
                              true ||
                          element['book']
                                  .toLowerCase()
                                  .contains(search.text.toLowerCase()) ==
                              true);
                      for (var a in hello) {
                        filterlist.add(a);
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: search.text.isEmpty == true
                              ? data!.length
                              : filterlist.length,
                          itemBuilder: (BuildContext context, int index) {
                            // print(hello);
                            if (search.text.isEmpty) {
                              return Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.blueAccent)),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.h, vertical: 20.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.h, vertical: 20.h),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Book Name:- ${data![index]['book'].toString()}",
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "Auhtor Name:- ${data[index]['author'].toString()}",
                                    ),
                                  ],
                                ),
                              );
                            } else if (filterlist[index]['author']
                                        .toLowerCase()
                                        .contains(search.text.toLowerCase()) ==
                                    true ||
                                filterlist[index]['location']
                                        .toLowerCase()
                                        .contains(search.text.toLowerCase()) ==
                                    true) {
                              return Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.blueAccent)),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.h, vertical: 20.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.h, vertical: 20.h),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Book Name:- ${filterlist[index]['book'].toString()}",
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(
                                      "Auhtor Name:- ${filterlist[index]['author'].toString()}",
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const CircularProgressIndicator();
                          },
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
