import '../features/blog/create/create_blog.dart';
import '../features/layout/main_layout.dart';
import 'router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainLayoutPage(),
    ),
    GoRoute(
      path: RouteOf.home,
      builder: (context, state) => const MainLayoutPage(),
    ),
    GoRoute(
      path: RouteOf.createBlog,
      builder: (context, state) => const CreateBlogPage(),
    ),
  ],
);
