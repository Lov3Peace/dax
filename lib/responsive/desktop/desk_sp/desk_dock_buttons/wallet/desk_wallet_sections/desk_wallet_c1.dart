import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class WalletC1 extends StatelessWidget {
  WalletC1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.5.h),
      child: Container(
        height: 36.h,
        width: 33.w,
        decoration: const BoxDecoration(
          color: Color(0xFF272626),
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSectionTitle('Wallet Address'),
              _buildWalletAddressRow(),
              _buildDivider(),
              _buildProjectContributionSection(),
              _buildDivider(),
              _buildDepositsSection(),
            ],
          ),
        ),
      ),
    );
  }

// Universal build that can be used at any point.
// creates the title for a section
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

// this build is for the wallet address row that houses the wallets address and
// the button that unlocks the encryption on it.
  Widget _buildWalletAddressRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'xxxx-4321',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('View'),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.grey,
      indent: 0,
      endIndent: 0,
    );
  }

//This build will house the numerous potential contributions and display them
// when called.
// note: these contributions were manually inputed but they will be generated when automatically
// any time new contributions are done.
  Widget _buildProjectContributionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSectionTitle('Project Contributions'),
        _buildContributionRow('Lagom Mini', 374),
        _buildContributionRow('Niche Zero', 550),
      ],
    );
  }

// This builds the contribution row itself and everything that goes in the row
// which will be the project name that you are contributing to and the amount
// that was contributed.
  Widget _buildContributionRow(String projectName, double amount) {
    return Padding(
      padding: EdgeInsets.only(top: 2.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            projectName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            NumberFormat.simpleCurrency(locale: 'en-US', decimalDigits: 2).format(amount),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

// this builds the deposit scetion as a whole.
// note: all things within this section will be updated as money is put into and withdrawed from the wallet
  Widget _buildDepositsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSectionTitle('Deposits'),
        _buildDepositRow('Wallet', 10000),
      ],
    );
  }

// This builds the deposits row itself and everything that goes in the row
// which will be the source (wallet) that you are depositing the money into
  Widget _buildDepositRow(String source, double amount) {
    return Padding(
      padding: EdgeInsets.only(top: 2.5.h, bottom: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            source,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            NumberFormat.simpleCurrency(locale: 'en-US', decimalDigits: 2).format(amount),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
