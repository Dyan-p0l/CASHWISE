import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import 'package:intl/intl.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}


class _AddIncomeScreenState extends State<AddIncomeScreen> {

  final TextEditingController amountController = TextEditingController();
  final TextEditingController labelController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final List<String> categories = [
    "Salary",
    "Allowance",
    "Bonus",
    "Gift",
    "Others",
  ];

  String? selectedCategory;
  double totalIncome = 0;

  @override
  void initState() {
    super.initState();
    _loadIncomeTotal();
  }

  Future<void> _loadIncomeTotal() async {
    totalIncome = await DBHelper.instance.getTotalIncome();
    setState(() {});
  }

  @override
  void dispose() {
    amountController.dispose();
    labelController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020733),
      body: 
        SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "ADD INCOME",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // TOTAL INCOME
            Column(
              children: [
                Text(
                  "₱${totalIncome.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "TOTAL INCOME",
                  style: TextStyle(
                    color: Color(0XFF04FAA8),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // WHITE ROUNDED CONTAINER
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      // AMOUNT FIELD NI SYA
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Amount",
                            style:
                                TextStyle(fontSize: 14, fontWeight: FontWeight.w600)
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 301,
                            child: TextField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Enter amount",
                                filled: true,
                                fillColor: Colors.grey[300],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),

                      SizedBox(width: 301,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Category",
                                      style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 8),

                                  // DROPDOWN
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[300],
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    items: categories
                                        .map((c) => DropdownMenuItem(
                                              value: c,
                                              child: Text(c),
                                            ))
                                        .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCategory = value;
                                        });
                                      },
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Date",
                                      style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 8),

                                  // DATE PICKER FIELD
                                  TextField(
                                    controller: dateController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: "Tap to select date",
                                      suffixIcon: const Icon(Icons.calendar_today),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),  
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.grey, // your desired color
                                          width: 1.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.blue, // color when focused
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      final pickedDate = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                        initialDate: DateTime.now(),
                                      );

                                      if (pickedDate != null) {
                                        dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      ),

                      // PARA SA CATEGORY UG DATE

                      const SizedBox(height: 20),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Label",
                              style:
                                  TextStyle(fontSize: 14, fontWeight: FontWeight.w600)
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 301,
                            child: TextField(
                            controller: labelController,
                            decoration: InputDecoration(
                                hintText: "Enter label",
                                filled: true,
                                fillColor: Colors.grey[300],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ]
                      ),
                      
                      const SizedBox(height: 30),

                      // SAVE UG CANCEL BUTTONS
                      SizedBox(
                        width: 301,
                        child: Row(
                          children: [
                            // SAVE
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0XFF56DFB1),
                                  foregroundColor: const Color(0XFF02032D),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () async {
                                  final amount = double.tryParse(
                                      amountController.text) ??
                                      0;

                                  if (amount == 0 ||
                                      selectedCategory == null ||
                                      dateController.text.isEmpty ||
                                      labelController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Please fill out all fields."),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }

                                  await DBHelper.instance.addTransaction({
                                    "amount": amount,
                                    "category": selectedCategory!,
                                    "date": dateController.text,
                                    "label": labelController.text,
                                    "type": "income",
                                  });

                                  Navigator.pop(context);
                                },
                                child: const Text("SAVE"),
                              ),
                            ),

                            const SizedBox(width: 16),

                            // CANCEL
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF040B4F),
                                  foregroundColor: const Color(0XFF56DFB1),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: const Text("CANCEL"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
