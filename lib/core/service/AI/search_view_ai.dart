/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies_app/core/configuration/theme/app_colors.dart';
import '../../../models/movie_model.dart';
import '../../../network/http_requests_service.dart';
import '../details/movie_details_view.dart'; // افترض وجود مسار شاشة التفاصيل لديك

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  List<MovieModel> _searchResults = [];
  bool _isLoading = false;
  bool _hasSearched = false;
  String? _errorMessage;

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  /// دالة التحكم بالبحث مع تقنية الـ Debounce
  void _onSearchChanged(String query) {
    // إلغاء المؤقت السابق إذا كتب المستخدم حرفاً جديداً قبل انتهاء الـ 500ms
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
        _hasSearched = false;
        _errorMessage = null;
      });
      return;
    }

    // بدء مؤقت جديد ينتظر 500 ملي ثانية بعد توقف المستخدم عن الكتابة
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _fetchSearchResults(trimmedQuery);
    });
  }

  /// طلب البيانات من السيرفر
  Future<void> _fetchSearchResults(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _hasSearched = true;
    });

    try {
      // استدعاء دالة البحث من الـ Service الخاصة بك
      final results = await HttpRequestsService.searchMovies(query);

      if (!mounted) return;

      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = "حدث خطأ أثناء جلب البيانات: $e";
        _isLoading = false;
      });
    }
  }

  /// تفريغ حقل البحث وإعادة الشاشة للحالة الأولى
  void _clearSearch() {
    _searchController.clear();
    _onSearchChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          style: const TextStyle(color: Colors.white),
          cursorColor: AppColors.buttonView,
          decoration: InputDecoration(
            hintText: "Search for a movie...",
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: _clearSearch,
            )
                : null,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  /// بناء واجهة الجسم بناءً على الحالة الحالية (UI States)
  Widget _buildBody() {
    // 1. حالة التحميل (Loading State)
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 2. حالة وجود خطأ (Error State)
    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _errorMessage!,
            style: const TextStyle(color: Colors.redAccent, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // 3. حالة عدم بدء البحث بعد (Initial State)
    if (!_hasSearched) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie_creation_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "Type something to start searching...",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    // 4. حالة البحث بدون نتائج (Empty Results State)
    if (_searchResults.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "No movies found matching your search.",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      );
    }

    // 5. حالة إرجاع النتائج بنجاح (Success State)
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final movie = _searchResults[index];
        return _buildMovieCard(movie);
      },
    );
  }

  /// كارت إظهار الفيلم في نتائج البحث
  Widget _buildMovieCard(MovieModel movie) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          MovieDetailsView.routeName,
          arguments: movie,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // صورة غلاف الفيلم مع معالجة الصورة المفقودة
            Positioned.fill(
              child: movie.mediumCoverImage.isNotEmpty
                  ? Image.network(
                movie.mediumCoverImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.grey[800]),
              )
                  : Container(color: Colors.grey[800]),
            ),

            // تدرج ظلي خلف النص لسهولة القراءة
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black87],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // شريط التقييم العلوي
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black70,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      movie.rating.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                  ],
                ),
              ),
            ),

            // اسم الفيلم وسنة الإنتاج في الأسفل
            Positioned(
              bottom: 12,
              left: 8,
              right: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (movie.year.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      movie.year,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/