import 'package:todo/models1/category.dart';
import 'package:todo/repositories/repository.dart';

class CategoryService {
  Repository _repository;

  CategoryService() {
    _repository = Repository();
  }
  //* Create data
  saveCategory(Category category) async {
    return await _repository.insertData('categories', category.categoryMap());
  }

  //* Read data from the Table
  readCategories() async {
    return await _repository.readData('categories');
  }

  //* Read data from table by Id
  readCategoryById(categoryId) async {
    return await _repository.readDataById('categories', categoryId);
  }

  //* Update data from the table
  updateCategory(Category category) async {
    return await _repository.updateData('categories', category.categoryMap());
  }

  //* Delete data from the table
  deleteCategory(categoryId) async {
    return await _repository.deleteData('categories', categoryId);
  }
}
