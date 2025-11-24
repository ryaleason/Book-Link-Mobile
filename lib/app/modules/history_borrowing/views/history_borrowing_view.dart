import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../controllers/history_borrowing_controller.dart';

class HistoryBorrowingView extends GetView<HistoryBorrowingController> {
  const HistoryBorrowingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'History Borrowing',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            if (controller.loanbook.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    'No data',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.loanbook.map((loan) {
                final status = (loan['status'] ?? '').toString().toLowerCase();
                final isPending = status == 'pending';

                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  loan['staffname'] ?? 'Tidak ada Petugas',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(status),
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                        255,
                                        33,
                                        33,
                                        33,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    status.capitalizeFirst!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (isPending) ...[
                                const SizedBox(height: 8),
                                IconButton(
                                  onPressed: () {
                                    _showDeleteConfirmation(
                                      context,
                                      loan['loan_id'],
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  tooltip: 'Delete loan',
                                ),
                              ] else ...[
                                Text(
                                  'Loan: ${loan['loan_date'] ?? ''}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontFamily: 'Poppins',
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Due: ${loan['due_date'] ?? ''}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontFamily: 'Poppins',
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: (loan['items'] as List? ?? []).map((item) {
                          return _buildBookCard(item);
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildBookCard(Map<String, dynamic> item) {
    return Container(
      width: 110,
      height: 160,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: item['image'] != null
          ? Image.network(
              "http://192.168.10.37:8000/storage/${item['image']}",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.broken_image,
                    color: Colors.white54,
                    size: 40,
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white54),
                );
              },
            )
          : const Center(
              child: Icon(Icons.book, color: Colors.white54, size: 40),
            ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return const Color.fromARGB(60, 245, 123, 0);
      case 'borrowed':
        return const Color.fromARGB(81, 0, 255, 13);
      case 'rejected':
        return const Color.fromARGB(94, 211, 47, 47);
      case 'returned':
        return const Color.fromARGB(68, 25, 118, 210);
      default:
        return const Color.fromARGB(94, 97, 97, 97);
    }
  }

  void _showDeleteConfirmation(BuildContext context, dynamic loanId) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Delete Loan',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        content: const Text(
          'Are you sure you want to delete this loan?',
          style: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.delete(loanId);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
