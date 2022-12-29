import 'package:anomaly_detection_system/constants/global_variables.dart';
import 'package:anomaly_detection_system/features/community/models/person.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommunityScreen extends ConsumerWidget {
  static const routeName = '/community-people';
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community People'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: GlobalVariables.secondaryColor,
        onPressed: () => _createOrUpdatePersonDialog(context: context),
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
