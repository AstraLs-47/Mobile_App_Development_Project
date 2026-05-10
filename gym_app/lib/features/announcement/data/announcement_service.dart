// Project imports:
import '../../../core/services/mock_db.dart';
import '../../../core/models/announcement_model.dart';

class AnnouncementService {
  final MockDB _db = MockDB();

  Future<List<Announcement>> fetchAnnouncements() async {
    await Future.delayed(const Duration(seconds: 1));
    return _db.announcements.map((a) => Announcement.fromJson(a)).toList();
  }

  Future<void> addAnnouncement(Announcement announcement) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _db.addAnnouncement(announcement.toJson().map((k, v) => MapEntry(k, v.toString())));
  }

  Future<void> deleteAnnouncement(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _db.removeAnnouncement(id);
  }
}
