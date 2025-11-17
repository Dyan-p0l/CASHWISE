import 'package:flutter/material.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF02032D),

      appBar: AppBar(
        backgroundColor: const Color(0xFF02032D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const SizedBox(height: 10),
            const Text(
              "Financial Circulation",
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 30,
              ),
            ),

            const SizedBox(height: 25),

            // TOP SECTION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // CURRENT BALANCE NI
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: 420,
                    width: 294,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current\nBalance",
                          style: TextStyle(
                            fontSize: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(height: 10),
                        Image(image: AssetImage('assets/images/wallet.png'), height: 205, width: 205,),
                        SizedBox(height: 10),
                        Text(
                          "₱20.51",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 40,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //PIKAS COLUMN DUHA KA SECTION(income ug expenses)
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        height: 200,
                        width: 145,
                        decoration: BoxDecoration(
                          color: const Color(0xFF56DFB1),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        // TOTAL NA INCOME
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Total income",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                              ),
                            ),
                            SizedBox(height: 20),
                            Icon(Icons.trending_up, color: Theme.of(context).primaryColor, size: 58,),
                            SizedBox(height: 20),
                            Text(
                              "₱1000.51",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // TOTAL NA EXPENSES
                      Container(
                        padding: const EdgeInsets.all(16),
                        height: 200,
                        width: 145,
                        decoration: BoxDecoration(
                          color: const Color(0XFFFF4D50),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "Total expenses",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                              ),
                            ),
                            SizedBox(height: 20),
                            Icon(Icons.payment, color: Colors.white, size: 58,),
                            SizedBox(height: 20),
                            Text(
                              "₱980.00",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFF56DFB1),
            selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
            unselectedItemColor: Colors.black,

            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
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
}
