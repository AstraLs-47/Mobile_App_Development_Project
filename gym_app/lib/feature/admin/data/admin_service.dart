// Project imports:
import '../../../core/models/announcement_model.dart';
import 'admin_repository.dart';

class AdminService {
  final AdminRepository _repository = AdminRepository();

  Future<List<Announcement>> fetchAnnouncements() async {
    return _repository.announcements
        .map((a) => Announcement.fromJson(a))
        .toList();
  }

  Future<void> addAnnouncement(Announcement announcement) async {
    _repository.addAnnouncement(
      announcement.toJson().map((k, v) => MapEntry(k, v.toString())),
    );
  }

  Future<void> updateAnnouncement(Announcement announcement) async {
    final index = _repository.announcements.indexWhere(
      (a) => a['title'] == announcement.title,
    );
    if (index != -1) {
      _repository.updateAnnouncement(
        index,
        announcement.toJson().map((k, v) => MapEntry(k, v.toString())),
      );
    }
  }

  Future<void> deleteAnnouncement(String id) async {
    final announcement = _repository.announcements.firstWhere(
      (a) => a['title'] == id,
      orElse: () => {},
    );
    if (announcement.isNotEmpty) {
      _repository.removeAnnouncement(announcement);
    }
  }

  Future<Map<String, dynamic>> fetchDashboardStats() async {
    return {
      'avgBmi': _repository.avgBmi,
      'avgHr': _repository.avgHr,
      'totalProducts': _repository.totalProducts,
      'totalActivities': _repository.activities.length,
      'announcementsCount': _repository.announcements.length,
      'productTypeData': _repository.productsByTypeData,
      'categoryDistribution': _repository.categoryDistribution,
      'engagementData': _repository.weeklyEngagementData,
      'recentActivities': _repository.recentActivities,
    };
  }
}
