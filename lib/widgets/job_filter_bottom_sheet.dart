import 'package:flutter/material.dart';
import 'package:talent_trail/config/theme.dart';
import 'package:talent_trail/models/job.dart';
import 'package:talent_trail/widgets/custom_button.dart';

class JobFilterBottomSheet extends StatefulWidget {
  final Map<String, dynamic> initialFilters;
  final Function(Map<String, dynamic>) onApplyFilters;
  final VoidCallback onResetFilters;

  const JobFilterBottomSheet({
    super.key,
    required this.initialFilters,
    required this.onApplyFilters,
    required this.onResetFilters,
  });

  @override
  State<JobFilterBottomSheet> createState() => _JobFilterBottomSheetState();
}

class _JobFilterBottomSheetState extends State<JobFilterBottomSheet> {
  final _locationController = TextEditingController();
  final _categoryController = TextEditingController();
  final _minSalaryController = TextEditingController();
  
  JobType? _selectedJobType;
  bool _isRemote = false;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize with existing filters
    _locationController.text = widget.initialFilters['location'] ?? '';
    _categoryController.text = widget.initialFilters['category'] ?? '';
    _minSalaryController.text = widget.initialFilters['minSalary']?.toString() ?? '';
    _selectedJobType = widget.initialFilters['type'];
    _isRemote = widget.initialFilters['isRemote'] ?? false;
  }
  
  @override
  void dispose() {
    _locationController.dispose();
    _categoryController.dispose();
    _minSalaryController.dispose();
    super.dispose();
  }
  
  void _applyFilters() {
    final filters = <String, dynamic>{};
    
    if (_locationController.text.isNotEmpty) {
      filters['location'] = _locationController.text;
    }
    
    if (_categoryController.text.isNotEmpty) {
      filters['category'] = _categoryController.text;
    }
    
    if (_minSalaryController.text.isNotEmpty) {
      filters['minSalary'] = double.tryParse(_minSalaryController.text);
    }
    
    if (_selectedJobType != null) {
      filters['type'] = _selectedJobType;
    }
    
    if (_isRemote) {
      filters['isRemote'] = true;
    }
    
    widget.onApplyFilters(filters);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter Jobs',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.onResetFilters();
                  Navigator.pop(context);
                },
                child: const Text('Reset All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _locationController,
            label: 'Location',
            hint: 'e.g., San Francisco, CA',
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _categoryController,
            label: 'Category',
            hint: 'e.g., Software Development',
            icon: Icons.category_outlined,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _minSalaryController,
            label: 'Minimum Salary',
            hint: 'e.g., 50000',
            icon: Icons.attach_money,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          _buildJobTypeSelector(),
          const SizedBox(height: 16),
          _buildRemoteToggle(),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Cancel',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isOutlined: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: 'Apply',
                  onPressed: _applyFilters,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          keyboardType: keyboardType,
        ),
      ],
    );
  }

  Widget _buildJobTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Job Type',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildJobTypeChip(JobType.fullTime, 'Full-time'),
            _buildJobTypeChip(JobType.partTime, 'Part-time'),
            _buildJobTypeChip(JobType.internship, 'Internship'),
            _buildJobTypeChip(JobType.contract, 'Contract'),
            _buildJobTypeChip(JobType.freelance, 'Freelance'),
          ],
        ),
      ],
    );
  }

  Widget _buildJobTypeChip(JobType type, String label) {
    final isSelected = _selectedJobType == type;
    
    return FilterChip(
      selected: isSelected,
      label: Text(label),
      onSelected: (selected) {
        setState(() {
          _selectedJobType = selected ? type : null;
        });
      },
      backgroundColor: Colors.white,
      selectedColor: AppColors.primary.withOpacity(0.1),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : AppColors.darkGrey,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? AppColors.primary : AppColors.lightGrey,
      ),
      checkmarkColor: AppColors.primary,
    );
  }

  Widget _buildRemoteToggle() {
    return SwitchListTile(
      title: Text(
        'Remote Only',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: const Text('Show only remote positions'),
      value: _isRemote,
      onChanged: (value) {
        setState(() {
          _isRemote = value;
        });
      },
      activeColor: AppColors.primary,
    );
  }
}