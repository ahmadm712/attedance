import 'package:attendance/data/models/offices_model.dart';
import 'package:attendance/injection.dart';
import 'package:attendance/presentation/cubit/location_cubit/location_cubit.dart';
import 'package:attendance/utils/global_functions.dart';
import 'package:attendance/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MasterLocationPage extends StatefulWidget {
  const MasterLocationPage({Key? key}) : super(key: key);

  @override
  State<MasterLocationPage> createState() => _MasterLocationPageState();
}

class _MasterLocationPageState extends State<MasterLocationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: '');

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  final globalFunction = locator<GlobalFunctions>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Office"),
            elevation: 0,
          ),
          floatingActionButton: SizedBox(
            child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          content: Stack(
                            children: <Widget>[
                              Positioned(
                                right: -15.0,
                                top: -15.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.red,
                                    child: Icon(
                                      Icons.close,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: kColorPrimary,
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.3)))),
                                      child: Center(
                                        child: Text(
                                          'Add Company',
                                          style: globalFunction
                                              .textTheme(context: context)
                                              .headline3!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.2))),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          right: BorderSide(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2)))),
                                                  child: Center(
                                                      child: Icon(
                                                          Icons
                                                              .account_balance_outlined,
                                                          size: 30,
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.4))),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: TextFormField(
                                                  controller: _nameController,
                                                  validator: (value) {
                                                    return value!.isNotEmpty
                                                        ? null
                                                        : "Enter any text";
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "E.g Hashmicro",
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 20),
                                                          border:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          errorBorder: InputBorder
                                                              .none,
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .black26,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: ElevatedButton(
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 40,
                                          child: Center(
                                              child: Text(
                                            "Submit",
                                            style: globalFunction
                                                .textTheme(context: context)
                                                .headline3!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                          )),
                                        ),
                                        onPressed: () async {
                                          if (globalFunction.validate(
                                            formkey: _formKey,
                                          )) {
                                            OfficesModel office = OfficesModel(
                                                name: _nameController.text,
                                                id: '01');

                                            context
                                                .read<LocationCubit>()
                                                .addMasterLocation(office);
                                            context
                                                .read<LocationCubit>()
                                                .getLocation();
                                            _nameController.clear();

                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: const Text('Add Office Data')),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            scrollDirection: Axis.vertical,
            child: BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                if (state is LocationLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LocationSucces && state.office != null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Company Name',
                            style: globalFunction
                                .textTheme(context: context)
                                .headline3!
                                .copyWith(color: Colors.black, fontSize: 17),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Text(state.office!.name,
                              style: globalFunction
                                  .textTheme(context: context)
                                  .headline3!
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Company Latitude ',
                            style: globalFunction
                                .textTheme(context: context)
                                .headline3!
                                .copyWith(color: Colors.black, fontSize: 17),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Text(
                            state.office!.location!.latitude.toString(),
                            style: globalFunction
                                .textTheme(context: context)
                                .headline3!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Company Longitude ',
                            style: globalFunction
                                .textTheme(context: context)
                                .headline3!
                                .copyWith(color: Colors.black, fontSize: 17),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Text(
                            state.office!.location!.longitude.toString(),
                            style: globalFunction
                                .textTheme(context: context)
                                .headline3!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Company Address ',
                            style: globalFunction
                                .textTheme(context: context)
                                .headline3!
                                .copyWith(color: Colors.black, fontSize: 17),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Text(
                            state.office!.addres!,
                            textAlign: TextAlign.center,
                            style: globalFunction
                                .textTheme(context: context)
                                .headline3!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                          )
                        ],
                      ),
                    ],
                  );
                } else if (state is LocationFailed) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                return Center(
                  child: Text('No Office Data avaible, Try to add it',
                      style: globalFunction
                          .textTheme(context: context)
                          .headline3!
                          .copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
