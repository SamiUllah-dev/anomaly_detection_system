import 'package:anomaly_detection_system/constants/global_variables.dart';
import 'package:anomaly_detection_system/features/community/models/person.dart';
import 'package:anomaly_detection_system/providers/people_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  static const routeName = '/community-people';
  const CommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  bool _isLoading = true;
  @override
  void didChangeDependencies() async {
    await getPeople();
    super.didChangeDependencies();
  }

  Future<void> getPeople() async {
    await ref.read(peopleDataProvider.notifier).getPeople(context);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community People'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer(builder: (context, ref, child) {
              final data = ref.watch(peopleDataProvider);
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 08,
                        child: ListTile(
                          title: Text(
                            data[index].name,
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(data[index].phoneNumber),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                splashRadius: 18,
                                onPressed: () async {
                                  Person? updatedPerson =
                                      await _createOrUpdatePersonDialog(
                                          context: context,
                                          existingPerson: data[index]);

                                  ref
                                      .read(peopleDataProvider.notifier)
                                      .updatePerson(
                                          context: context,
                                          person: updatedPerson!);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: GlobalVariables.secondaryColor,
                                ),
                              ),
                              IconButton(
                                splashRadius: 18,
                                onPressed: () async {
                                  await ref
                                      .read(peopleDataProvider.notifier)
                                      .deletePerson(
                                          context: context,
                                          person: data[index]);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              );
            }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: GlobalVariables.secondaryColor,
        onPressed: () async {
          Person? newPerson =
              await _createOrUpdatePersonDialog(context: context);
          ref.read(peopleDataProvider.notifier).addPerson(person: newPerson);
        },
        label: const Text('Add Person'),
        icon: const Icon(Icons.person),
      ),
    );
  }
}

Future<Person?> _createOrUpdatePersonDialog(
    {required BuildContext context, Person? existingPerson}) {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  nameController.text = existingPerson == null ? '' : existingPerson.name;
  phoneNumberController.text =
      existingPerson == null ? '' : existingPerson.phoneNumber;
  return showDialog<Person?>(
    context: context,
    builder: ((context) => SimpleDialog(
          title: Text(
            existingPerson != null ? 'Update Person' : 'Add Person',
          ),
          contentPadding: const EdgeInsets.all(20),
          children: [
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) return 'field required';
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: phoneNumberController,
                    validator: (value) {
                      if (value!.isEmpty) return 'field required';
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Phone number'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      late Person? newPerson;
                      if (existingPerson != null) {
                        newPerson = Person(
                            id: existingPerson.id,
                            name: nameController.text,
                            phoneNumber: phoneNumberController.text);
                      } else {
                        newPerson = Person(
                            id: '',
                            name: nameController.text,
                            phoneNumber: phoneNumberController.text);
                      }
                      Navigator.of(context).pop(newPerson);
                    }
                  },
                  child: Text(existingPerson == null ? 'Add' : 'Update'),
                ),
              ],
            )
          ],
        )),
  );
}
