import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:clinic/core/services/network/local/cache_helper.dart';
import 'package:clinic/core/services/network/local/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../login/presentation/views/login_page.dart';
import '../cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> HomeCubit()..getHomeData(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Logout Successfully',),
                duration: Duration(seconds: 1),
                showCloseIcon: true,
              ),
            );

            CacheHelper.removeCacheKey(key: MySharedKeys.token).then((value) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const LoginScreen();
              }));
            });
          }
          if (state is LogoutErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Something Went Wrong'),
                  duration: Duration(seconds: 2)),
            );
          }
        },
        builder: (context, state) {
         var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF174068),
              elevation: 0,
              title: Text(
                "VCare",
                style: GoogleFonts.roboto(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              leading: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'VCare',
                      style: GoogleFonts.roboto(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  ListTile(
                    title: const Text('Logout'),
                    onTap: () {
                      cubit.logout();
                    },
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            bottomNavigationBar: BottomNavyBar(
              selectedIndex: cubit.currentIndex,
              showElevation: true,
              containerHeight: 60,
              itemCornerRadius: 24,
              curve: Curves.easeIn,
              iconSize: 30,
              onItemSelected: (index) => cubit.changeBot(index, context),
              items: cubit.tabs,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            body: SafeArea(child: cubit.screens[cubit.currentIndex]),
          );
        },
      ),
    );
  }
}
