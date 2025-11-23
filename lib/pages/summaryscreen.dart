import 'package:flutter/material.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  int _selectedIndex = 0;
  bool _showAddOptions = false; // show add income / expense buttons

  @override
  Widget build(BuildContext context) {
    // Safe/robust spacing so buttons sit above the bottom nav and any system insets:
    final media = MediaQuery.of(context);
    final double bottomInset = media.viewPadding.bottom; // e.g., gesture nav area
    // estimated bottom navigation bar height (you used padding + ClipRRect)
    const double estimatedNavBarHeight = 10.0;
    // where the buttons rest when visible:
    final double visibleBottom =
        estimatedNavBarHeight + 14 + bottomInset; 
    // when hidden, place them well below the screen:
    final double hiddenBottom = -140.0;

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
      body: Stack(
        children: [
          // Main content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                            const SizedBox(height: 10),
                            Image(
                              image: const AssetImage('assets/images/wallet.png'),
                              height: 205,
                              width: 205,
                            ),
                            const SizedBox(height: 10),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Total income",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Icon(Icons.trending_up,
                                    color: Theme.of(context).primaryColor, size: 58),
                                const SizedBox(height: 20),
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
                                      fontSize: 16),
                                ),
                                SizedBox(height: 20),
                                Icon(Icons.payment, color: Colors.white, size: 58),
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

          AnimatedPositioned(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOut,
            // Use either visibleBottom or hiddenBottom depending on state:
            bottom: _showAddOptions ? visibleBottom : hiddenBottom,
            left: 0,
            right: 0,
            child: IgnorePointer(
              // Prevent taps when hidden (opacity 0 -> still blocks touches), so use IgnorePointer
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
                            onPressed: () {
                              setState(() {
                                _showAddOptions = false;
                                Navigator.pushNamed(context, '/addincome');
                              });
                            },
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.account_balance_wallet,
                                  color: Color(0XFF02032D),
                                  size: 38,
                                ),
                                const Text(
                                  'Income  ', style: TextStyle(
                                    color: Color(0XFF02032D),
                                    fontSize: 14
                                  ),
                                ),
                              ],
                            )
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Expense button
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
                            onPressed: () {
                              setState(() {
                                _showAddOptions = false;
                                Navigator.pushNamed(context, '/addexpenses');
                              } );
                            },
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.payment,
                                  color: Color(0XFF02032D),
                                  size: 38,
                                ),
                                const Text(
                                  'Expenses', style: TextStyle(
                                    color: Color(0XFF02032D),
                                    fontSize: 12
                                  ),
                                ),
                              ],
                            )
                          ),
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
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFF56DFB1),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            currentIndex: _selectedIndex,
            onTap: (index) {
              if (index == 1) {
                // toggle add options
                setState(() => _showAddOptions = !_showAddOptions);
              } else {
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
}
