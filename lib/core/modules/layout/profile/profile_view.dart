import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/configuration/theme/app_colors.dart';
import 'package:movies_app/core/models/movie_model.dart';
import 'package:movies_app/core/modules/widgets/app_button_widget.dart';
import '../../../../main.dart';
import '../../../configuration/gen/assets.gen.dart';
import '../../../configuration/routes/app_routes_name.dart';
import '../home/poster.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with TickerProviderStateMixin {
  late TabController _tabController;

  String get userName {
    final user = FirebaseAuth.instance.currentUser;
    return user?.displayName ?? "User"; // يعرض اسم المستخدم الحقيقي
  }

  // الحصول على معرف المستخدم الحالي
  String get currentUserId => FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // تنظيف الـ Controller لحماية الذاكرة
    super.dispose();
  }

  Stream<List<MovieModel>> getWishlistStream() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || uid.isEmpty) {
      return Stream.value([]);
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('wishlist')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => MovieModel.fromJson(doc.data()))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder<List<MovieModel>>(
              stream: getWishlistStream(),
              builder: (context, snapshot) {
                final wishlistCount = snapshot.data?.length ?? 0;

                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: Assets.images.avatar1.provider(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            userName,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: AppColors.textMain,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "$wishlistCount", // يعرض العدد الحقيقي للمفضلة
                            style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text("Wish List", style: theme.textTheme.titleLarge),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "0", // History Count
                            style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text("History", style: theme.textTheme.titleLarge),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            // 2. أزرار التعديل والخروج
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   AppButtonWidget(
                    title: "Edit Profile",
                    padding: 45,
                    onTap: (){
                      navigatorKey.currentState?.pushNamed(AppRoutesName.editProfile);
                    }),

                  AppButtonWidget(
                    title: "Exit",
                    padding: 32,
                    backgroundColor: AppColors.redButton,
                    titleColor: AppColors.textMain,
                    suffixIcon: Assets.icons.exitIcon.svg(
                      height: 20,
                      colorFilter: ColorFilter.mode(AppColors.textMain, BlendMode.srcIn),),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 3. شريط التبويب (TabBar)
            TabBar(
              dividerColor: AppColors.primary,
              indicatorAnimation: TabIndicatorAnimation.linear,
              indicatorColor: AppColors.buttonView,
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabController,
              tabs: const <Widget>[
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.list, color: AppColors.buttonView),
                      SizedBox(width: 8),
                      Text("Wish List", style: TextStyle(color: AppColors.textMain)),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.folder, color: AppColors.buttonView),
                      SizedBox(width: 8),
                      Text("History", style: TextStyle(color: AppColors.textMain)),
                    ],
                  ),
                ),
              ],
            ),

            // 4. محتوى التبويبات (TabBarView)
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Tab 1: قائمة الـ Wish List
                  StreamBuilder<List<MovieModel>>(
                    stream: getWishlistStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final movies = snapshot.data ?? [];

                      if (movies.isEmpty) {
                        return Center(
                          child: Assets.images.moviesEmptyImg.image(alignment: Alignment.center),
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return GestureDetector(
                            onTap: () {
                              navigatorKey.currentState?.pushNamed(
                                AppRoutesName.movieDetails,
                                arguments: movie,
                              );
                            },
                            child: Poster(
                              rating: movie.rating,
                              imageUrl: movie.mediumCoverImage,
                            ),
                          );
                        },
                      );
                    },
                  ),

                  // Tab 2: قائمة الـ History (فارغة حالياً)
                  Center(
                    child: Assets.images.moviesEmptyImg.image(alignment: Alignment.center),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}