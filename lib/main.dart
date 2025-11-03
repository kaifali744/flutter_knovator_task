import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/api_client.dart';
import 'core/hive_service.dart';
import 'data/repository/post_repository.dart';
import 'bloc/post_bloc.dart';
import 'presentation/screens/post_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('postsBox'); // stores list of post JSONs under 'posts'
  await Hive.openBox(
    'readBox',
  ); // stores set/list of read post ids under 'readIds'

  final apiClient = ApiClient();
  final hiveService = HiveService();
  final repository = PostRepository(
    apiClient: apiClient,
    hiveService: hiveService,
  );

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final PostRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) => PostBloc(repository: repository)..add(LoadPostsEvent()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Knovator Posts',
          theme: ThemeData(
            fontFamily: 'Poppins',
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF33A1E0)),
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Tasa',
                fontSize: 22,
              ),
              centerTitle: true,
              color: Color(0xFF154D71),
            ),
            // fontFamily:
          ),
          home: const PostListScreen(),
        ),
      ),
    );
  }
}
