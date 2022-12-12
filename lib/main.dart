import 'dart:io';

import 'package:driving_test/app.dart';
import 'package:driving_test/config/constants.dart';
import 'package:driving_test/config/store_config.dart';
import 'package:driving_test/core/network.dart';
import 'package:driving_test/data/repositories/question_repository.dart';
import 'package:driving_test/data/source/network/network_datasource.dart';
import 'package:driving_test/state/bottomitem/bottom_item_cubit.dart';
import 'package:driving_test/state/chapters/chapter_bloc.dart';
import 'package:driving_test/state/exam/exam_bloc.dart';
import 'package:driving_test/state/iap/iap_bloc.dart';
import 'package:driving_test/state/learn/learn_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  if (Platform.isIOS || Platform.isMacOS) {
    StoreConfig(
      store: Store.appleStore,
      apiKey: AppConstants.appleApiKey,
    );
  } else if (Platform.isAndroid) {
    StoreConfig(
      store: Store.googlePlay,
      apiKey: AppConstants.googleApiKey,
    );
  }

  runApp(
    MultiRepositoryProvider(
      providers: [
        ///
        /// Services
        ///
        RepositoryProvider<NetworkManager>(
          create: (context) => NetworkManager(),
        ),

        ///
        /// Data sources
        ///
        RepositoryProvider<NetworkDataSource>(
          create: (context) =>
              NetworkDataSource(context.read<NetworkManager>()),
        ),

        ///
        /// Repositories
        ///
        RepositoryProvider<QuestionRepository>(
          create: (context) => QuestionDefaultRepository(
            context.read<NetworkDataSource>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          ///
          /// BLoCs
          ///
          BlocProvider<BottomItemCubit>(
            create: (_) => BottomItemCubit(),
          ),
          BlocProvider<ChapterBloc>(
            create: (context) =>
                ChapterBloc(context.read<QuestionRepository>()),
          ),
          BlocProvider<LearnBloc>(create: (_) => LearnBloc()),
          BlocProvider<ExamBloc>(create: (_) => ExamBloc()),
          BlocProvider<IAPBloc>(create: (_) => IAPBloc()),
        ],
        child: const DrivingTestApp(),
      ),
    ),
  );
}
