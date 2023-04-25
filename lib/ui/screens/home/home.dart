import 'package:driving_test/config/colors.dart';
import 'package:driving_test/config/images.dart';
import 'package:driving_test/state/bottomitem/bottom_item_cubit.dart';
import 'package:driving_test/ui/screens/exam/exam.dart';
import 'package:driving_test/ui/screens/home/widgets/dashboard.dart';
import 'package:driving_test/ui/screens/learn/learn.dart';
import 'package:driving_test/ui/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    LearnScreen(),
    ExamScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var bottomStateCubit =
        BlocProvider.of<BottomItemCubit>(context, listen: true);
    var currentIndex = bottomStateCubit.pos;

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.matisse,
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: bottomStateCubit.onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Image(
              image: AppImages.homeOutline,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            activeIcon: Image(
              image: AppImages.home,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AppImages.learnOutline,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            activeIcon: Image(
              image: AppImages.learn,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AppImages.testOutline,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            activeIcon: Image(
              image: AppImages.test,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            label: 'Test',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AppImages.profileOutline,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            activeIcon: Image(
              image: AppImages.profile,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
