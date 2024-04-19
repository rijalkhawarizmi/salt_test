import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/home/presentation/cubit/home/home_cubit.dart';
import 'package:flutter_application_1/src/home/presentation/view/detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/timer_dobounce.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _debouncer = Debouncer(milliseconds: 1000);
  String countryId = 'us';
  void handleClick(String value) {
    setState(() {
      countryId = value;
      context.read<HomeCubit>().getListHome(
          countryID: countryId,
          search: newsNameSearch,
          category: valueCategory);
    });
  }

  final chooseCountry = ['id', 'us'];

  List<String> liststringname = [
    'Teknologi',
    'Kesehatan',
    'Olahraga',
    'Hiburan',
    'Ilmu',
    'Bisnis',
  ];
  List<String> liststringnameenglish = [
    'Technology',
    'Health',
    'Sports',
    'Entertainment',
    'Science',
    'Business',
  ];
  List<String> liststringAPI = [
    'technology',
    'health',
    'sports',
    'entertainment',
    'science',
    'business',
  ];

  String? valueCategory;
  bool isprescategory = false;
  int? thisindex;

  Widget makecontainer(String value, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          valueCategory = liststringAPI[index];
          isprescategory = true;
          thisindex = index;
          context.read<HomeCubit>().getListHome(
              countryID: countryId,
              search: newsNameSearch,
              category: valueCategory);
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: thisindex == index ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: countryId == 'id'
                ? Text(
                    liststringname[index],
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  )
                : Text(
                    liststringnameenglish[index],
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  )),
      ),
    );
  }

  String newsNameSearch = '';
  searchNews(String value) {
    setState(() {
      newsNameSearch = value;
      context.read<HomeCubit>().getListHome(
          countryID: countryId,
          search: newsNameSearch,
          category: valueCategory);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<HomeCubit>()
        .getListHome(countryID: 'us', search: '', category: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          countryId == "id"
              ? PopupMenuButton<String>(
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return chooseCountry.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice == "id" ? "Indonesia" : "Amerika"),
                      );
                    }).toList();
                  },
                )
              : PopupMenuButton<String>(
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return chooseCountry.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice == "us" ? "Amerika" : "Indonesia"),
                      );
                    }).toList();
                  },
                ),
        ],
        centerTitle: true,
        title: Text(
          'News',
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 1),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return context.read<HomeCubit>().getListHome(
              countryID: countryId, search: '', category: valueCategory);
        },
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (value) {
                  _debouncer.run(() async {
                    searchNews(value);
                  });
                },
                decoration: InputDecoration(
                  hintText: countryId == 'id' ? 'Cari Berita' : 'Search News',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 70,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: countryId == 'id'
                      ? liststringname
                          .asMap()
                          .entries
                          .map(
                            (MapEntry map) => makecontainer(map.value, map.key),
                          )
                          .toList()
                      : liststringname
                          .asMap()
                          .entries
                          .map(
                            (MapEntry map) => makecontainer(map.value, map.key),
                          )
                          .toList()),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is HomeSuccess) {
                  return state.listHome.isEmpty
                                ? Expanded(
                                  child: Center(
                                      child: Text(
                                          'Tidak menemukan apa yang anda cari')),
                                )
                                : Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10, crossAxisCount: 2),
                        itemCount: state.listHome.length,
                        itemBuilder: (context, index) {
                          final listdata = state.listHome[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return DetailPage(url: listdata.url);
                              }));
                            },
                            child:  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      '${listdata.urlToImage}'))),
                                        ),
                                        Text(
                                          '${listdata.title}',
                                          maxLines: 3,
                                        )
                                      ],
                                    ),
                                  ),
                          );
                        }),
                  );
                } else if (state is HomeFailed) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const SizedBox(
                    child: Text('dsds'),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
