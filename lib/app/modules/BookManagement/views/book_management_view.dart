import 'package:book_list/app/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/book_management_controller.dart';

class BookManagementView extends GetView<BookManagementController> {
  const BookManagementView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Book Management', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'All Books',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: Obx(() {
                      return Wrap(
                        spacing: 20,
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: controller.books.map((item) {
                          return book(item);
                        }).toList(),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                showCreateBookDialog(controller);
              },
              child: Icon(Icons.add, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

Widget book(Map<String, dynamic> item) {
  return InkWell(
    onTap: () {
      Get.toNamed(Routes.BOOK_DETAIL, arguments: item['id']);
    },
    child: Container(
      width: 178,
      height: 290,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: CachedNetworkImage(
              imageUrl: "http://192.168.10.37:8000${item['image']}",
              width: double.infinity,
              height: 215,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: double.infinity,
                height: 215,
                color: Colors.grey.shade900,
              ),
              errorWidget: (context, url, error) => Container(
                width: double.infinity,
                height: 215,
                color: Colors.grey.shade900,
                child: Icon(Icons.error, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  item['author'],
                  style: TextStyle(
                    color: Colors.white60,
                    fontFamily: 'Poppins',
                    fontSize: 11,
                  ),
                ),
                Text(
                  "Stock: ${item['available_stock']}",
                  style: TextStyle(
                    color: Colors.white60,
                    fontFamily: 'Poppins',
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

void showCreateBookDialog(BookManagementController controller) {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final isbnController = TextEditingController();

  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with gradient
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create New Book',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Add a new book to your library',
                          style: TextStyle(
                            color: Colors.white70,
                            fontFamily: 'Poppins',
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Field
                    _buildInputLabel('Book Title'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: titleController,
                      hint: 'Enter book title',
                      icon: Icons.title,
                    ),
                    const SizedBox(height: 20),

                    // Author Field
                    _buildInputLabel('Author Name'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: authorController,
                      hint: 'Enter author name',
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 20),

                    // Category Dropdown
                    _buildInputLabel('Category'),
                    const SizedBox(height: 8),
                    Obx(() {
                      if (controller.category.isEmpty) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey[700]!,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.blue[400],
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Loading categories...",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey[700]!,
                            width: 1.5,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            dropdownColor: Colors.grey[850],
                            value: controller.selectedCategory.value,
                            hint: Row(
                              children: [
                                Icon(
                                  Icons.category_outlined,
                                  color: Colors.grey[500],
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  "Select a category",
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey[400],
                            ),
                            items: controller.category.map((item) {
                              return DropdownMenuItem<String>(
                                value: item['name'],
                                child: Row(
                                  children: [
                                    Container(width: 8, height: 8),
                                    const SizedBox(width: 12),
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.selectedCategory.value = value;
                            },
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.grey[700]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (titleController.text.isEmpty ||
                            authorController.text.isEmpty ||
                            isbnController.text.isEmpty ||
                            controller.selectedCategory.value == null) {
                          Get.snackbar(
                            'Error',
                            'Please fill all fields',
                            backgroundColor: Colors.red[400],
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                          );
                          return;
                        }
                        // controller.createBook(
                        //   title: titleController.text,
                        //   author: authorController.text,
                        //   isbn: isbnController.text,
                        // );
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Color(0xFFFF7622),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create Book',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

Widget _buildInputLabel(String label) {
  return Text(
    label,
    style: const TextStyle(
      color: Colors.white,
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget _buildTextField({
  required TextEditingController controller,
  required String hint,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[850],
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey[700]!, width: 1.5),
    ),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[500], fontFamily: 'Poppins'),
        prefixIcon: Icon(icon, color: Colors.grey[500], size: 20),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    ),
  );
}
