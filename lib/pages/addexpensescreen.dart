import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

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
                    "ADD EXPENSES",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // TOTAL EXPENSES
            Column(
              children: const [
                Text(
                  "₱ 980.51",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "TOTAL EXPENSES",
                  style: TextStyle(
                    color: Color(0XFFFF4167),
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
                                    onChanged: (value) {},
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
                                        dateController.text =
                                            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
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
                                onPressed: () {
                                  // Save action
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
