import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../routes/app_routes.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final List<_ServiceCategory> _categories = [
    _ServiceCategory(
      name: 'Nails',
      services: [
        _ServiceItem(name: 'Full Set Acrylic', price: 55, isMostBooked: true),
        _ServiceItem(name: 'Fill In', price: 35),
        _ServiceItem(name: 'Gel Manicure', price: 40),
        _ServiceItem(name: 'Nail Art (per nail)', price: 5),
      ],
    ),
    _ServiceCategory(
      name: 'Pedicure',
      services: [
        _ServiceItem(name: 'Classic Pedicure', price: 35),
        _ServiceItem(name: 'Gel Pedicure', price: 45),
      ],
    ),
  ];

  void _editService(_ServiceItem service) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        final controller = TextEditingController(text: service.price.toString());
        return Padding(
          padding: EdgeInsets.fromLTRB(
            24, 20, 24,
            MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(service.name, style: AppTextStyles.h3),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                autofocus: true,
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  labelText: 'Price (\$)',
                  labelStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      service.price = int.tryParse(controller.text) ?? service.price;
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Text('Save', style: AppTextStyles.buttonText),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addService() async {
    final result = await Navigator.pushNamed(context, AppRoutes.addService);

    if (result != null) {
      final data = result as Map;
      setState(() {
        final category = _categories.firstWhere(
              (c) => c.name == data['category'],
          orElse: () => _categories[0],
        );
        category.services.add(
          _ServiceItem(name: data['name'], price: data['price']),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'My Services',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                      Text(
                        'Tap to edit price',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _addService,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),


            ..._categories.map((cat) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
                  child: Text(cat.name.toUpperCase(), style: AppTextStyles.labelMuted),
                ),
                ...cat.services.map(
                      (s) => _ServiceRow(service: s, onTap: () => _editService(s)),
                ),
              ],
            )),

            // Add Button
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _addService,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: Text('+ Add New Service', style: AppTextStyles.buttonText),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ── Models ──────────────────────────────────────────────

class _ServiceCategory {
  final String name;
  final List<_ServiceItem> services;
  const _ServiceCategory({required this.name, required this.services});
}

class _ServiceItem {
  final String name;
  int price;
  final bool isMostBooked;
  _ServiceItem({required this.name, required this.price, this.isMostBooked = false});
}

// ── Service Row Widget ───────────────────────────────────

class _ServiceRow extends StatelessWidget {
  final _ServiceItem service;
  final VoidCallback onTap;
  const _ServiceRow({required this.service, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.name, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
                  if (service.isMostBooked) ...[
                    const SizedBox(height: 3),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'most booked',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 10,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Text(
              '\$${service.price}',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, size: 16, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}