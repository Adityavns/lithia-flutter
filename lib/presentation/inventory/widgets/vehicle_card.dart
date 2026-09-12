import 'package:flutter/material.dart';

import '../../../domain/entities/vehicle.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({super.key, required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xffdddddd)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              if (vehicle.imageUrl != null)
                Image.network(
                  vehicle.imageUrl!,
                  height: 265,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(height: 265),
                )
              else
                const SizedBox(height: 265),
              Positioned(
                top: 14,
                right: 14,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${vehicle.year ?? ''}',
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color(0xff4d4d4d),
                  ),
                ),
                Text(
                  '${vehicle.make} ${vehicle.model}',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (vehicle.trim.isNotEmpty)
                  Text(
                    '${vehicle.trim}  |  ${vehicle.mileage ?? 0} miles',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff555555),
                    ),
                  ),
                const Divider(height: 25),
                Text(
                  vehicle.price ?? 'Price unavailable',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (vehicle.isGoodDeal)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Good deal',
                      style: TextStyle(
                        color: Color(0xff1454a6),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
