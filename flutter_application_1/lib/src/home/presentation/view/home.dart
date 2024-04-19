import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/home/presentation/cubit/home/home_cubit.dart';
import 'package:flutter_application_1/src/home/presentation/view/detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeCubit>().getListHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'News',
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 1),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: RefreshIndicator(
          onRefresh: () {
            return context.read<HomeCubit>().getListHome();
          },
          child: Column(
            children: <Widget>[
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is HomeSuccess) {
                    return Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 2),
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
                              child: Container(
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
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
