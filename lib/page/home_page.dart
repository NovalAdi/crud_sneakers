import 'package:crud_sneakers/cubit/sneaker_cubit.dart';
import 'package:crud_sneakers/models/sneaker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showBottomSheet({Sneaker? sneaker, required bool isUpdate}) {
    final nameController = TextEditingController();
    final brandController = TextEditingController();
    final typeController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey();

    if (isUpdate) {
      nameController.text = sneaker!.name;
      brandController.text = sneaker.brand;
      typeController.text = sneaker.type;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: WidgetsBinding.instance.window.viewInsets.bottom * .5,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isUpdate ? 'Update ${sneaker!.name}' : 'Create Product',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Sneaker Name can not be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: 'Sneaker Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: brandController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Sneaker brand can not be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Brand',
                      labelText: 'Sneaker Brand',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: typeController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Sneaker type can not be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: 'Sneaker Type',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.of(context).pop();

                          if (isUpdate) {
                            context.read<SneakerCubit>().updateSneakers(
                                  sneaker!.id!,
                                  nameController.text,
                                  brandController.text,
                                  typeController.text,
                                );
                          } else {
                            context.read<SneakerCubit>().createSneakers(
                                  nameController.text,
                                  brandController.text,
                                  typeController.text,
                                );
                          }

                          nameController.clear();
                          brandController.clear();
                          typeController.clear();
                        }
                      },
                      icon: Icon(isUpdate ? Icons.update : Icons.save),
                      label: Text(isUpdate ? 'Update' : 'Create'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showBottomSheet(isUpdate: false);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocBuilder<SneakerCubit, SneakerState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.sneakers.isEmpty) {
              return const Center(
                child: Text('Nothing to see here'),
              );
            } else {
              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  final sneaker = state.sneakers[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sneaker.name,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(sneaker.brand),
                              const SizedBox(height: 3),
                              Text(sneaker.type),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _showBottomSheet(
                                      isUpdate: true, sneaker: sneaker);
                                },
                                icon: const Icon(Icons.edit),
                                color: Colors.amber,
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<SneakerCubit>().deleteSneakers(sneaker.id!);
                                },
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
                itemCount: state.sneakers.length,
              );
            }
          },
        ),
      ),
    );
  }
}
