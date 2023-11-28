import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/cubit/app_cubit_states.dart';
import 'package:weatherapp/cubit/app_cubits.dart';
import 'package:weatherapp/misc/colors.dart';
import 'package:weatherapp/widgets/app_large_text.dart';
import 'package:weatherapp/widgets/app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  var images = {
    'balloning.png' : 'Balloning',
    'hiking.png' : 'Hiking',
    'kayaking.png' : 'Kayaking',
    'snorkling.png' : 'Snorkling'
  };
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if(state is LoadedState){
            var info = state.places;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 50, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu, size: 30, color: Colors.black54),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 30),
                  child: AppLargeText(text: "Discover"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      labelPadding: EdgeInsets.only(left: 20, right: 20),
                      controller: _tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator:
                      CircleTabIndicator(color: AppColors.mainColor, radius: 4),
                      tabs: [
                        Tab(
                          text: 'Places',
                        ),
                        Tab(
                          text: 'Imspiration',
                        ),
                        Tab(
                          text: 'Emotions',
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 300,
                  width: double.maxFinite,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (){
                              BlocProvider.of<AppCubits>(context).detailPage(info[index]);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 15, top: 10),
                              width: 200,
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                image: DecorationImage(
                                    image: NetworkImage('http://mark.bslmeiyu.com/uploads/'+info[index].img),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          );
                        },
                        itemCount: info.length,
                        scrollDirection: Axis.horizontal,
                      ),
                      Text('There'),
                      Text('Bye'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30),
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLargeText(
                        text: 'Explore more',
                        size: 22,
                      ),
                      AppText(
                        text: 'See all',
                        color: AppColors.textColor1,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 110,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: 20),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/'+ images.keys.elementAt(index)),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: AppText(
                                  text: images.values.elementAt(index),
                                  color: AppColors.textColor2,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              ],
            );
          } else {
            return Container();
          }
        },

      )
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _pain = Paint();
    _pain.color = color;
    _pain.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, _pain);
  }
}
