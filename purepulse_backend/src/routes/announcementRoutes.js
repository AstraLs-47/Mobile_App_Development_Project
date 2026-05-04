const express = require('express');
const router = express.Router();
const announcementController = require('../controllers/announcementController');
const { auth, authorize } = require('../middleware/auth');

router.get('/', announcementController.list);
router.get('/:id', announcementController.getById);
router.post('/', auth, authorize('admin'), announcementController.create);
router.put('/:id', auth, authorize('admin'), announcementController.update);
router.delete('/:id', auth, authorize('admin'), announcementController.delete);

module.exports = router;