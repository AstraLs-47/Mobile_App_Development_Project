// Project imports:
import '../../../core/data/mock_db.dart';
import '../../../core/models/announcement_model.dart';

class AnnouncementService {
  final MockDB _db = MockDB();

  Future<List<Announcement>> fetchAnnouncements() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final announcements = _db.announcements;
      return announcements.map((a) => Announcement.fromJson(a)).toList();
    } catch (e) {
      throw Exception('Failed to fetch announcements: $e');
    }
  }

  Future<void> addAnnouncement(Announcement announcement) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final jsonData = announcement.toJson().map(
        (k, v) => MapEntry(k, v.toString())
      );
      _db.addAnnouncement(jsonData);
    } catch (e) {
      throw Exception('Failed to add announcement: $e');
    }
  }

  Future<void> deleteAnnouncement(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _db.removeAnnouncement(id);
    } catch (e) {
      throw Exception('Failed to delete announcement: $e');
    }
  }
}