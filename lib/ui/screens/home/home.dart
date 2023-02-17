import 'package:driving_test/config/colors.dart';
import 'package:driving_test/config/images.dart';
import 'package:driving_test/state/bottomitem/bottom_item_cubit.dart';
import 'package:driving_test/ui/screens/exam/exam.dart';
import 'package:driving_test/ui/screens/home/widgets/dashboard.dart';
import 'package:driving_test/ui/screens/learn/learn.dart';
import 'package:driving_test/ui/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

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
  void initState() {
    super.initState();
    initPlugin();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    final TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    // If the system can show an authorization request dialog
    if (status == TrackingStatus.notDetermined) {
      // Show a custom explainer dialog before the system dialog
      await showCustomTrackingDialog(context);
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  Future<void> showCustomTrackingDialog(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Dear User'),
          content: const Text(
            'We care about your privacy and data security. We keep this app free by showing ads. '
            'Can we continue to use your data to tailor ads for you?\n\nYou can change your choice anytime in the app settings. '
            'Our partners will collect data and use a unique identifier on your device to show you ads.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continue'),
            ),
          ],
        ),
      );

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
