import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  int _selectedIndex = 2;
  bool _showAddOptions = false;

  List<Map<String, dynamic>> transactions = []; // All transactions
  String _filter = "ALL"; // "ALL", "INCOME", "EXPENSES"

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    final db = DBHelper.instance;
    List<Map<String, dynamic>> txList = await db.getAllTransactions();

    setState(() {
      transactions = txList.map((tx) {
        Color color;
        IconData icon;

        switch (tx['category'].toString().toLowerCase()) {
          case 'food':
            color = Colors.red;
            icon = Icons.restaurant;
            break;
          case 'allowance':
            color = Colors.orange;
            icon = Icons.wallet_giftcard;
            break;
          case 'shopping':
            color = Colors.yellow.shade700;
            icon = Icons.shopping_bag;
            break;
          case 'recreation':
            color = Colors.cyan;
            icon = Icons.sports_esports;
            break;
          default:
            color = Colors.greenAccent;
            icon = Icons.wallet_giftcard;
        }

        return {
          "id": tx['id'],
          "title": tx['label'] ?? tx['category'],
          "category": tx['category'],
          "amount": tx['amount'],
          "isIncome": tx['type'] == 'income',
          "icon": icon,
          "color": color,
          "date": tx['date'],
        };
      }).toList();
    });
  }

  // Returns transactions filtered by _filter
  List<Map<String, dynamic>> get filteredTransactions {
    if (_filter == "ALL") return transactions;
    if (_filter == "INCOME") return transactions.where((tx) => tx['isIncome']).toList();
    if (_filter == "EXPENSES") return transactions.where((tx) => !tx['isIncome']).toList();
    return transactions;
  }
  Future<void> _deleteTransaction(Map<String, dynamic> tx) async {
    final db = DBHelper.instance;

    // Assuming your DB has an 'id' field
    int? id = tx['id'];
    if (id != null) {
      await db.deleteTransaction(id); // Implement this in your DBHelper
      setState(() {
        transactions.removeWhere((element) => element['id'] == id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final double bottomInset = media.viewPadding.bottom;
    const double estimatedNavBarHeight = 10.0;
    final double visibleBottom = estimatedNavBarHeight + 14 + bottomInset;
    final double hiddenBottom = -140.0;

    // Group filtered transactions by date
    Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var tx in filteredTransactions) {
      String date = tx['date'];
      if (!grouped.containsKey(date)) grouped[date] = [];
      grouped[date]!.add(tx);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "TRANSACTION HISTORY",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    filterButton("ALL"),
                    const SizedBox(width: 10),
                    filterButton("INCOME"),
                    const SizedBox(width: 10),
                    filterButton("EXPENSES"),
                  ],
                ),
                const SizedBox(height: 20),
                // Render grouped transactions
                ...grouped.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF02032D),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...entry.value.map((tx) => transactionItem(tx)).toList(),
                      const SizedBox(height: 25),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
          // Add options buttons
          AnimatedPositioned(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOut,
            bottom: _showAddOptions ? visibleBottom : hiddenBottom,
            left: 0,
            right: 0,
            child: IgnorePointer(
              ignoring: !_showAddOptions,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: _showAddOptions ? 1 : 0,
                curve: Curves.easeInOut,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedScale(
                          scale: _showAddOptions ? 1.0 : 0.8,
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOutBack,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0XFF56DFB1),
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(20),
                                elevation: 6,
                              ),
                              onPressed: () async {
                                setState(() => _showAddOptions = false);
                                await Navigator.pushNamed(context, '/addincome');
                                _loadTransactions();
                              },
                              child: Column(
                                children: const [
                                  Icon(Icons.account_balance_wallet,
                                      color: Color(0XFF02032D), size: 38),
                                  Text('Income', style: TextStyle(
                                      color: Color(0XFF02032D),
                                      fontSize: 14)),
                                ],
                              )),
                        ),
                        const SizedBox(height: 14),
                        AnimatedScale(
                          scale: _showAddOptions ? 1.0 : 0.8,
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOutBack,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0XFFFF4D50),
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(20),
                                elevation: 6,
                              ),
                              onPressed: () async {
                                setState(() => _showAddOptions = false);
                                await Navigator.pushNamed(context, '/addexpenses');
                                _loadTransactions();
                              },
                              child: Column(
                                children: const [
                                  Icon(Icons.payment,
                                      color: Color(0XFF02032D), size: 38),
                                  Text('Expenses', style: TextStyle(
                                      color: Color(0XFF02032D),
                                      fontSize: 12)),
                                ],
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            height: 70,
            decoration: const BoxDecoration(
              color: Color(0xFF56DFB1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.dashboard_outlined, "Summary", 0),
                _buildNavItem(Icons.add_circle, "Add", 1),
                _buildNavItem(Icons.history, "History", 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget filterButton(String label) {
    final bool isActive = _filter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _filter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF02032D) : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : Colors.black54,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget transactionItem(Map<String, dynamic> tx) {
    return Slidable(
      key: ValueKey(tx['title'] + tx['date']),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (context) => _deleteTransaction(tx),
            backgroundColor: Color(0xFFF3F4F8),
            foregroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(20),
            ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF02032D),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (tx["color"] as Color).withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                tx["icon"] as IconData,
                size: 28,
                color: tx["color"] as Color,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx["title"] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    tx["category"] as String,
                    style: TextStyle(
                      color: Colors.greenAccent.shade100,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "${tx["isIncome"] ? "+" : "–"} ₱${(tx["amount"] as double).toStringAsFixed(2)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: tx["isIncome"] ? Colors.greenAccent : Colors.redAccent,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 1) {
          setState(() {
            _showAddOptions = !_showAddOptions;
          });
        } else if (index == 2) {
          setState(() {
            _selectedIndex = index;
            _showAddOptions = false;
          });
          Navigator.pushNamed(context, '/history');
        } else {
          setState(() {
            _selectedIndex = index;
            _showAddOptions = false;
          });
          Navigator.pushNamed(context, '/summary');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.black),
          Text(label, style: TextStyle(color: Colors.black)),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.only(top: 4),
            height: isActive ? 5 : 0,
            width: 38,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}
