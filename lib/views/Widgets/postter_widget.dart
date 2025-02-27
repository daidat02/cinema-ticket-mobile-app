import 'package:flutter/material.dart';

class PosterWidget extends StatelessWidget {
  const PosterWidget({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: AspectRatio(
        aspectRatio: 5 / 6.5,
        child: imageUrl!.startsWith('http')
            ? Image.network(
                imageUrl ?? '',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, color: Colors.red, size: 50),
                ),
              )
            : Image.asset(
                imageUrl ?? 'assets/images/placeholder.png',
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
