import '../models/index.dart' as Models;

Models.Pagination getBasicPagination() => Models.Pagination()
  ..pageSize = 10
  ..pageNum = 1
  ..isCompleted = false
  ..isLoading = false;
