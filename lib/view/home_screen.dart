import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../res/color.dart';
import '../utils/routes/routes_name.dart';
import '../view_model/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  HomeViewModel homeViewModel = HomeViewModel();
  @override
  void initState() {
    homeViewModel.fetchProductListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              userPreference.remove().then((value) {
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
            child: Text("Log out"),
          )
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context) => homeViewModel,
        child: Consumer<HomeViewModel>(builder: (context, value, _) {
          switch (value.productList.status) {
            case Status.LOADING:
              return CircularProgressIndicator();
            case Status.ERROR:
              return Text(value.productList.message.toString());
            case Status.COMPLETED:
              return ListView.builder(
                  itemCount: value.productList.data!.products!.length,
                  itemBuilder: (context, index) {
                    return Text("sfafaf");
                  });
            default:
              return Container(
                height: 50,
                width: 100,
                color: Colors.red,
              );
          }
        }),
      ),
    );
  }
}
