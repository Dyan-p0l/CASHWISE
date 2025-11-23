import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  
  int _selectedIndex = 0;
  bool _showAddOptions = false; // show add income / expense buttons


  final Map<String, List<Map<String, dynamic>>> transactions = {
    "Today": [
      {
        "title": "DOST Stipend cutie",
        "category": "Allowance",
        "amount": 8000.00,
        "isIncome": true,
        "icon": Icons.wallet_giftcard,
        "color": Colors.orange,
      },
      {
        "title": "Allowance gikan ate",
        "category": "Allowance",
        "amount": 2000.00,
        "isIncome": true,
        "icon": Icons.wallet_giftcard,
        "color": Colors.orange,
      },
    ],
    "Saturday, 22 Nov 2025": [
      {
        "title": "Kaon Ribshack",
        "category": "Food",
        "amount": 180.00,
        "isIncome": false,
        "icon": Icons.restaurant,
        "color": Colors.red,
      },
      {
        "title": "Palit chikoket",
        "category": "Food",
        "amount": 30.00,
        "isIncome": false,
        "icon": Icons.restaurant,
        "color": Colors.red,
      },
      {
        "title": "Nag yards sa JANCOR",
        "category": "Recreation",
        "amount": 100.00,
        "isIncome": false,
        "icon": Icons.sports_esports,
        "color": Colors.cyan,
      },
      {
        "title": "Allowance gikan ate",
        "category": "Allowance",
        "amount": 2000.00,
        "isIncome": true,
        "icon": Icons.wallet_giftcard,
        "color": Colors.orange,
      },
      {
        "title": "24 Cheken with gabriela",
        "category": "Food",
        "amount": 300.00,
        "isIncome": false,
        "icon": Icons.restaurant,
        "color": Colors.red,
      },
      {
        "title": "Palit battery",
        "category": "Shopping",
        "amount": 25.00,
        "isIncome": false,
        "icon": Icons.shopping_bag,
        "color": Colors.yellow.shade700,
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "TRANSACTION HISTORY",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // ------- FILTER BUTTONS -------
            Row(
              children: [
                filterButton("ALL", isActive: true),
                const SizedBox(width: 10),
                filterButton("INCOME"),
                const SizedBox(width: 10),
                filterButton("EXPENSES"),
              ],
            ),
            const SizedBox(height: 20),

            // ------- RENDER TRANSACTION SECTIONS -------
            ...transactions.entries.map((entry) {
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

                  // Each transaction tile
                  ...entry.value.map((tx) => transactionItem(tx)).toList(),

                  const SizedBox(height: 25),
                ],
              );
            }).toList(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFF56DFB1),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            currentIndex: _selectedIndex,
            onTap: (index) {
              if (index == 1) {
                setState(() => _showAddOptions = !_showAddOptions);
              }
              else if (index == 2) {
                // History button
                setState(() {
                  _selectedIndex = index;
                  _showAddOptions = false;
                });
                Navigator.pushNamed(context, '/history');
              }  
              else {
                Navigator.pushNamed(context, '/summary');   
                setState(() {
                  _selectedIndex = index;
                  _showAddOptions = false;
                });
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: "Summary",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle, size: 30),
                label: "Add Transaction",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: "History",
              ),
            ],
          ),
        ),
      ),
    
    );
  }

  Widget filterButton(String label, {bool isActive = false}) {
    return Container(
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
    );
  }

  Widget transactionItem(Map<String, dynamic> tx) {
    return Container(
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
              color: tx["color"].withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              tx["icon"],
              size: 28,
              color: tx["color"],
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx["title"],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  tx["category"],
                  style: TextStyle(
                    color: Colors.greenAccent.shade100,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Text(
            "${tx["isIncome"] ? "+" : "–"} ₱${tx["amount"].toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: tx["isIncome"] ? Colors.greenAccent : Colors.redAccent,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
