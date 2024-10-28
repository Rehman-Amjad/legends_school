import 'package:flutter/material.dart';
import 'package:legends_schools_admin/constant.dart';

import 'custom_card.dart';

class WeightHeightBloodCard extends StatelessWidget {
  const WeightHeightBloodCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          details("Weight", "53kg"),
          details("Height", "162cm"),
          details("Blood Type", "O+"),
        ],
      ),
    );
  }

  Widget details(String key, String value) {
    return Column(
      children: [
        Text(
          key,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white
          ),
        ),
      ],
    );
  }
}
