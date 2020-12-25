import '../models/index.dart' as Models;

Models.Pagination getBasicPagination({pageSize}) => Models.Pagination()
  ..pageSize = pageSize != null ? pageSize : 10
  ..pageNum = 1
  ..isCompleted = false
  ..isLoading = false;
