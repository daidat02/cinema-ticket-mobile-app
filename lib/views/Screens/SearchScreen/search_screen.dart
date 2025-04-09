import 'package:flutter/material.dart';
import 'package:shop/models/MovieModel.dart';
import 'package:shop/views/Widgets/page_appBar_widget.dart';

class SearchScreen extends StatefulWidget {
  final List<Movie> movies;

  const SearchScreen({super.key, required this.movies});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Movie> _filteredMovies;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  bool _isSearching = false;
  String _searchQuery = '';

  // Thêm danh sách các thể loại phim và thể loại đang được chọn
  final List<String> _genres = [
    'Tất cả',
    'Hành động',
    'Tình cảm',
    'Kinh dị',
    'Hài hước',
    'Viễn tưởng'
  ];
  String _selectedGenre = 'Tất cả';

  @override
  void initState() {
    super.initState();
    _filteredMovies = List.from(widget.movies);
    _searchFocus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isSearching = _searchFocus.hasFocus;
    });
  }

  // Cập nhật phương thức tìm kiếm để kết hợp với bộ lọc thể loại
  void _applyFilters() {
    if (_searchQuery.isEmpty && _selectedGenre == 'Tất cả') {
      setState(() {
        _filteredMovies = List.from(widget.movies);
      });
      return;
    }

    final results = widget.movies.where((movie) {
      // Lọc theo từ khóa tìm kiếm
      bool matchesSearch = true;
      if (_searchQuery.isNotEmpty) {
        final title = movie.title?.toLowerCase() ?? '';
        final director = movie.director?.toLowerCase() ?? '';
        final actor = movie.actor?.toLowerCase() ?? '';
        final searchQuery = _searchQuery.toLowerCase();

        matchesSearch = title.contains(searchQuery) ||
            director.contains(searchQuery) ||
            actor.contains(searchQuery);
      }

      // Lọc theo thể loại
      bool matchesGenre = true;
      if (_selectedGenre != 'Tất cả') {
        final genre = movie.genre?.toLowerCase() ?? '';
        matchesGenre = genre.toLowerCase() == _selectedGenre.toLowerCase();
      }

      return matchesSearch && matchesGenre;
    }).toList();

    setState(() {
      _filteredMovies = results;
    });
  }

  // Cập nhật phương thức tìm kiếm để lưu trữ query
  void _searchMovies(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applyFilters();
  }

  // Thêm phương thức chọn thể loại
  void _selectGenre(String genre) {
    setState(() {
      _selectedGenre = genre;
    });
    _applyFilters();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.removeListener(_onFocusChange);
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Tìm kiếm phim',
          style: TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF333333)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: _isSearching ? Colors.white : const Color(0xFFF0F0F2),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: _isSearching
                      ? const Color(0xFF3D7CF3)
                      : Colors.transparent,
                  width: 2,
                ),
                boxShadow: _isSearching
                    ? [
                        const BoxShadow(
                          color: Color(0x1A3D7CF3),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocus,
                decoration: InputDecoration(
                  hintText: 'Nhập tên phim, diễn viên hoặc đạo diễn...',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                  prefixIcon: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      Icons.search,
                      color: _isSearching
                          ? const Color(0xFF3D7CF3)
                          : Colors.grey[400],
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            _searchMovies('');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : null,
                ),
                onChanged: _searchMovies,
                style: const TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: _genres
                  .map((genre) =>
                      _buildFilterChip(genre, genre == _selectedGenre))
                  .toList(),
            ),
          ),
          const SizedBox(height: 10),
          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kết quả (${_filteredMovies.length})',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                // Sort dropdown
                GestureDetector(
                  onTap: () {
                    _showSortOptions(context);
                  },
                  child: Row(
                    children: [
                      const Text(
                        'Sắp xếp: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),
                      const Text(
                        'Mới nhất',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3D7CF3),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blue[600],
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Movie list
          Expanded(
            child: _filteredMovies.isEmpty
                ? _buildEmptyResults()
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: _filteredMovies.length,
                    itemBuilder: (context, index) {
                      final movie = _filteredMovies[index];
                      return _MovieCard(movie: movie);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Sắp xếp theo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 20),
              _buildSortOption(
                  context, 'Mới nhất', Icons.calendar_today_outlined),
              _buildSortOption(
                  context, 'Đánh giá cao nhất', Icons.star_outline),
              _buildSortOption(context, 'Tên phim (A-Z)', Icons.sort_by_alpha),
              _buildSortOption(
                  context, 'Thời lượng', Icons.access_time_outlined),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF3D7CF3)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF333333),
        ),
      ),
      onTap: () {
        // Thực hiện sắp xếp theo tùy chọn được chọn
        Navigator.pop(context);
        // Ví dụ: sắp xếp theo tên
        if (title == 'Tên phim (A-Z)') {
          setState(() {
            _filteredMovies
                .sort((a, b) => (a.title ?? '').compareTo(b.title ?? ''));
          });
        }

        // Thêm các tùy chọn sắp xếp khác ở đây
      },
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF666666),
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          _selectGenre(label);
        },
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF3D7CF3),
        checkmarkColor: Colors.white,
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.transparent : Colors.grey[300]!,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_search.png', // Thêm hình ảnh này vào thư mục assets
            width: 120,
            height: 120,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.movie_filter_outlined,
              size: 80,
              color: Color(0xFFCCCCCC),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Không tìm thấy phim phù hợp',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              _selectedGenre != 'Tất cả'
                  ? 'Không có phim thể loại $_selectedGenre phù hợp với tìm kiếm của bạn'
                  : 'Hãy thử từ khóa khác hoặc bỏ bớt bộ lọc',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              _searchController.clear();
              _selectGenre('Tất cả');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3D7CF3),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 2,
            ),
            child: const Text(
              'Xem tất cả phim',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;

  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Xử lý khi nhấn vào phim
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster phim với Hero animation
              Hero(
                tag: 'movie_${movie.id}',
                child: Container(
                  width: 110,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: movie.imageUrl != null
                        ? Image.network(
                            movie.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: Icon(Icons.image_not_supported,
                                    size: 50, color: Colors.grey),
                              ),
                            ),
                          )
                        : Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(Icons.movie,
                                  size: 50, color: Colors.grey),
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Thông tin phim
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title ?? 'Không có tiêu đề',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Đánh giá phim

                    const SizedBox(height: 12),
                    // Thông tin bổ sung
                    if (movie.genre != null)
                      _buildInfoRow(Icons.movie_filter_outlined, movie.genre!),
                    if (movie.duration != null)
                      _buildInfoRow(
                          Icons.access_time_rounded, '${movie.duration!} phút'),
                    if (movie.releaseDate != null)
                      _buildInfoRow(Icons.calendar_today_outlined,
                          '${movie.releaseDate!.day}/${movie.releaseDate!.month}/${movie.releaseDate!.year}'),
                    if (movie.director != null)
                      _buildInfoRow(Icons.person_outline, movie.director!),

                    const SizedBox(height: 12),
                    // Nút xem chi tiết
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          // Xử lý khi nhấn vào nút
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3D7CF3),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          minimumSize: const Size(100, 36),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Chi tiết',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFF888888),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
