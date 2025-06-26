import 'package:dompetly/controllers/theme_controller.dart';
import 'package:dompetly/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionTabs extends StatelessWidget {
  final tabs = ['Daily', 'Weekly', 'Monthly'];

  TransactionTabs({super.key});

  final ThemeController _themeController = Get.find();

  Widget _transactionItem({
    required IconData icon,
    required Color bgColor,
    required String title,
    required String time,
    required String category,
    required String amount,
    required bool isExpense,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Icon
          CircleAvatar(
            radius: 22,
            backgroundColor: bgColor,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),

          // Title & Time
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: const TextStyle(
                    color: AppColors.oceanBlue,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Vertical Divider
          Container(height: 40, width: 1, color: AppColors.mainGreen),
          const SizedBox(width: 12),

          // Category
          Expanded(
            flex: 2,
            child: Text(category, style: const TextStyle(fontSize: 13)),
          ),

          // Vertical Divider
          Container(height: 40, width: 1, color: AppColors.mainGreen),
          const SizedBox(width: 12),

          // Amount
          Expanded(
            flex: 2,
            child: Text(
              amount,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isExpense ? Colors.redAccent : Colors.black,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          // TabBar with custom indicator
          Obx(
            () => Container(
              margin: const EdgeInsets.only(top: 26),
              decoration: BoxDecoration(
                color: _themeController.themeMode.value == ThemeMode.dark
                    ? const Color(0xFF0E3E3E)
                    : AppColors.textPrimaryDark,
                borderRadius: BorderRadius.circular(22),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: AppColors.mainGreen,
                  borderRadius: BorderRadius.circular(19),
                ),
                labelColor: Colors.white,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                labelStyle: TextStyle(fontSize: 15),
                tabs: tabs.map((tab) => Tab(text: tab)).toList(),
              ),
            ),
          ),

          Expanded(
            child: TabBarView(
              children: List.generate(
                3,
                (index) => ListView(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  children: [
                    _transactionItem(
                      icon: Icons.attach_money,
                      bgColor: AppColors.oceanBlue,
                      title: "Salary",
                      time: "08:30 - April 25",
                      category: "Monthly",
                      amount: "Rp 10.000.000",
                      isExpense: false,
                    ),
                    _transactionItem(
                      icon: Icons.local_grocery_store,
                      bgColor: AppColors.oceanBlue,
                      title: "Groceries",
                      time: "17:00 - April 24",
                      category: "Pantry",
                      amount: "-\$100,00",
                      isExpense: true,
                    ),
                    _transactionItem(
                      icon: Icons.key,
                      bgColor: AppColors.oceanBlue,
                      title: "Rent",
                      time: "8:30 - April 15",
                      category: "Rent",
                      amount: "-\$674,40",
                      isExpense: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
