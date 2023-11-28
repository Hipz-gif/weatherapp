import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/cubit/app_cubit_states.dart';
import 'package:weatherapp/cubit/app_cubits.dart';
import 'package:weatherapp/misc/colors.dart';
import 'package:weatherapp/widgets/app_button.dart';
import 'package:weatherapp/widgets/app_large_text.dart';
import 'package:weatherapp/widgets/app_text.dart';
import 'package:weatherapp/widgets/responsive_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int gottenStars = 4;
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state){
          DetailState detailState = state as DetailState;
          return Scaffold(
            body: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.maxFinite,
                      height: 350,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage('http://mark.bslmeiyu.com/uploads/'+ detailState.places.img),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 50,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<AppCubits>(context).goHome();
                            },
                            icon: Icon(Icons.arrow_back_ios),
                            color: Colors.white),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 260,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppLargeText(
                                text: detailState.places.name,
                                color: Colors.black.withOpacity(0.8),
                              ),
                              AppLargeText(
                                text: '\$'+ detailState.places.price.toString(),
                                color: AppColors.mainColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.mainColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              AppText(
                                text: detailState.places.location,
                                color: AppColors.mainColor,
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Wrap(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    color: index < detailState.places.stars
                                        ? AppColors.starColor
                                        : AppColors.textColor2,
                                  );
                                }),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              AppText(
                                text: detailState.places.stars.toString() + '.0',
                                color: AppColors.textColor2,
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          AppLargeText(
                            text: 'People',
                            color: Colors.black.withOpacity(0.8),
                          ),
                          SizedBox(height: 5),
                          AppText(
                            text: 'Number of people in your group',
                            color: AppColors.textColor2,
                          ),
                          Wrap(
                            children: List.generate(5, (index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: AppButton(
                                    size: 50,
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                    backgroundColor: selectedIndex == index
                                        ? Colors.black
                                        : AppColors.buttonBackground,
                                    borderColor: selectedIndex == index
                                        ? Colors.black
                                        : AppColors.buttonBackground,
                                    text: (index + 1).toString(),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 20),
                          AppLargeText(
                            text: 'Desciption',
                            color: Colors.black.withOpacity(0.8),
                          ),
                          SizedBox(height: 10),
                          AppText(
                            text:
                            detailState.places.description,
                            color: AppColors.mainTextColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        AppButton(size: 60,
                          color: AppColors.textColor1,
                          backgroundColor: Colors.white,
                          borderColor: AppColors.textColor1,
                          isIcon: true,
                          icon: Icons.favorite_border,
                        ),
                        SizedBox(width: 20),
                        ResponsiveButton(
                          isResponsive: true,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
