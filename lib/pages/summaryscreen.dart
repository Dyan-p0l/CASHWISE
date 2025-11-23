import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  double balance = 0;
  double totalIncome = 0;
  double totalExpense = 0;

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  Future<void> _loadSummary() async {
    final db = DBHelper.instance;

    double inc = await db.getTotalIncome();
    double exp = await db.getTotalExpense();
    double bal = await db.getBalance();

    setState(() {
      totalIncome = inc;
      totalExpense = exp;
      balance = bal;
    });
  }

  int _selectedIndex = 0;
  bool _showAddOptions = false; // show add income / expense buttons

  @override
  Widget build(BuildContext context) {

    final media = MediaQuery.of(context);
    final double bottomInset = media.viewPadding.bottom; 
    const double estimatedNavBarHeight = 10.0;
    final double visibleBottom = estimatedNavBarHeight + 14 + bottomInset; 
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
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "₱${balance.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Theme.of(context).primaryColor,
                                ),
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
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "₱${totalIncome.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
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
                              children: [
                                const Text(
                                  "Total expenses",
                                  style: TextStyle(
                                      color: Color(0XFF02032D),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 20),
                                const Icon(Icons.payment, color: Colors.white, size: 58),
                                const SizedBox(height: 20),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "₱${totalExpense.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0XFF02032D),
                                    ),
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
                              onPressed: () async {
                                setState(() => _showAddOptions = false);
                                await Navigator.pushNamed(context, '/addincome'); // wait until the user returns
                                _loadSummary();
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
                              onPressed: () async {
                                setState(() => _showAddOptions = false);
                                await Navigator.pushNamed(context, '/addexpenses');
                                _loadSummary();
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
      ),);

  }


  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        if (index == 1) {
          setState((){
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
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 33, color: Colors.black),
          Text('$label', style: TextStyle(color: Colors.black)),
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
