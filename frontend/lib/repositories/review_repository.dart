import 'dart:async';

/// Review Model for Local Shop & Product Feedback
class ReviewModel {
  final String reviewId;
  final String targetId; // shopId or productId
  final String userName;
  final double rating;
  final String comment;
  final DateTime createdAt;

  const ReviewModel({
    required this.reviewId,
    required this.targetId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });
}

/// Review Repository for Customer Reviews & Shop Feedback
class ReviewRepository {
  static final ReviewRepository _instance = ReviewRepository._internal();
  factory ReviewRepository() => _instance;
  ReviewRepository._internal();

  final List<ReviewModel> _reviews = [
    ReviewModel(
      reviewId: 'r1',
      targetId: 's1',
      userName: 'Rahul K.',
      rating: 5.0,
      comment: 'Super fast pickup! Products were kept packed and ready at the store counter.',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    ReviewModel(
      reviewId: 'r2',
      targetId: 's1',
      userName: 'Priya M.',
      rating: 4.5,
      comment: 'Saved ₹45 compared to other shops nearby. Great experience!',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  /// Get reviews for a shop or product
  Future<List<ReviewModel>> getReviews(String targetId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _reviews.where((r) => r.targetId == targetId).toList();
  }

  /// Submit a new review
  Future<bool> submitReview({
    required String targetId,
    required String userName,
    required double rating,
    required String comment,
  }) async {
    await Future.delayed(const Duration(milliseconds: 250));
    _reviews.insert(
      0,
      ReviewModel(
        reviewId: 'r${_reviews.length + 1}',
        targetId: targetId,
        userName: userName,
        rating: rating,
        comment: comment,
        createdAt: DateTime.now(),
      ),
    );
    return true;
  }
}
