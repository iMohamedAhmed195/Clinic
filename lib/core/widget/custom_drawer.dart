import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key,required this.textHappen,required this.icon,required this.contextDrawer});

 final  String textHappen ;
 final IconData icon ;
 final  BuildContext contextDrawer ;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                children: [
                  myDrawerList(
                      happened: textHappen,
                      icon: icon,
                      context: contextDrawer),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget myDrawerList(
      {required String happened,
        required IconData icon,
        required BuildContext context}) {
    return Column(
      children: [
        menuItem(text: happened, icon: icon, context: context),
      ],
    );
  }

  Widget menuItem({required String text, required IconData icon, required BuildContext context}) {
    return Material(
      child: InkWell(
        onTap: () {
          // if (text == 'Add User') {
          //   GoRouter.of(context).push(AppRouter.kAddUser);
          // } else if (text == 'Add Department') {
          //   GoRouter.of(context).push(AppRouter.kAddDepart);
          // } else if (text == 'Update User') {
          //   GoRouter.of(context).push(AppRouter.kUpdateUser);
          // } else if (text == 'Update Department') {
          //   GoRouter.of(context).push(AppRouter.kUpdateDepart);
          // }else if (text == 'Delete Departments') {
          //   GoRouter.of(context).push(AppRouter.kDeleteDepart);
          // }else if (text == 'Delete Users') {
          //   GoRouter.of(context).push(AppRouter.kDeleteUser);
          // }else if (text == 'Delete Tasks') {
          //   GoRouter.of(context).push(AppRouter.kDeleteTasks);
          // }

        },
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            height: 50,
            color: const Color(0xffF3FAF9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
