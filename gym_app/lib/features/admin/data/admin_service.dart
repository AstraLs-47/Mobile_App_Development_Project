// Project imports:
import '../../../core/services/mock_db.dart';
import '../../../core/models/announcement_model.dart';

class AdminService {
  final MockDB _db = MockDB();

  Future<List<Announcement>> fetchAnnouncements() async {
    return _db.announcements.map((a) => Announcement.fromJson(a)).toList();
  }

  Future<void> addAnnouncement(Announcement announcement) async {
    _db.addAnnouncement(announcement.toJson().map((k, v) => MapEntry(k, v.toString())));
  }

  Future<void> updateAnnouncement(Announcement announcement) async {
    _db.updateAnnouncement(announcement.id, announcement.toJson().map((k, v) => MapEntry(k, v.toString())));
  }

  Future<void> deleteAnnouncement(String id) async {
    _db.removeAnnouncement(id);
  }

  Future<Map<String, dynamic>> fetchDashboardStats() async {
    return {
      'avgBmi': _db.calculateAvgBMI(),
      'avgHr': _db.calculateAvgHR(),
      'totalProducts': _db.getTotalProducts(),
      'totalActivities': _db.activities.length,
      'announcementsCount': _db.announcements.length,
      'productTypeData': _db.getProductTypeData(),
      'categoryDistribution': _db.getCategoryDistribution(),
      'engagementData': _db.weeklyEngagementData,
      'recentActivities': _db.recentActivities,
    };
  }
}
