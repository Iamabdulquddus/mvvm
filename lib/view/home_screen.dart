import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../res/color.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    homeViewModel.fetchProductListApi();
    super.initState();

  }

  @override
  void dispose() {
    titleController.dispose();
    titleFocusNode.dispose();
    descController.dispose();
    descFocusNode.dispose();
    super.dispose();
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
           // String id = value.token;
          switch (value.productList.status) {
            case Status.LOADING:
              return CircularProgressIndicator();
            case Status.ERROR:
              return Text(value.productList.message.toString());
            case Status.COMPLETED:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: titleController,
                            keyboardType: TextInputType.emailAddress,
                            focusNode: titleFocusNode,
                            decoration: const InputDecoration(
                              hintText: "Enter title",
                              labelText: "Title",
                              prefixIcon: Icon(Icons.alternate_email),
                            ),
                            onFieldSubmitted: (valu) {
                              Utils.fieldFocusChange(
                                  context, titleFocusNode, descFocusNode);
                            },
                          ),
                          SizedBox(height: 5,),
                          TextFormField(
                            controller: titleController,
                            keyboardType: TextInputType.emailAddress,
                            focusNode: descFocusNode,
                            decoration: const InputDecoration(
                              hintText: "Enter description",
                              labelText: "Description",
                              prefixIcon: Icon(Icons.alternate_email),
                            ),

                          ),
                          SizedBox(height: 5,),
                          ElevatedButton(onPressed: (){
                            if (titleController.text.isEmpty && descController.text.isNotEmpty) {
                              Utils.flushBarErrorMessage("Please enter title or description", context);
                            }  else {
                              Map data = {
                                'userId': id,
                               'title': 'Link okay',
                                'desc':
                                'Flutter is working with notes api',
                              };
                              homeViewModel.notesApi(data, context);
                              if (kDebugMode) {
                                print('Notes api hit');
                              }
                            }
                          }, child: Text("Add Note"),),
                        ],
                      ),
                    ),
                    ListView.builder(

                        itemCount: value.productList.data!.products!.length,
                        itemBuilder: (context, index) {
                          return Text("sfafaf");
                        }),
                  ],
                ),
              );
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
