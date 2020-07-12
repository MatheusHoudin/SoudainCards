import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soudain/core/constants/colors.dart';
import 'package:soudain/features/home/presentation/widgets/header.dart';
import 'package:soudain/features/home/presentation/bloc/user_data_bloc.dart';
import 'package:soudain/injection_container.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: secondaryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: BlocProvider(
                  create: (BuildContext context) => sl<UserDataBloc>(),
                  child: Header(),
                ),
              ),
              Expanded(
                flex: 18,
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}