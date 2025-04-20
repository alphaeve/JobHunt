import 'package:flutter/material.dart';
import 'package:talent_trail/config/theme.dart';
import 'package:talent_trail/models/application.dart';
import 'package:intl/intl.dart';

class ApplicationCard extends StatelessWidget {
  final Application application;

  const ApplicationCard({
    super.key,
    required this.application,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.lightGrey,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        application.jobTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        application.companyName,
                        style: TextStyle(
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(application.status),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppColors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Applied on ${DateFormat('MMM dd, yyyy').format(application.appliedDate)}',
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Cover Letter',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGrey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  application.coverLetter.length > 100
                      ? '${application.coverLetter.substring(0, 100)}...'
                      : application.coverLetter,
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (application.resumeUrl != null)
                      OutlinedButton.icon(
                        onPressed: () {
                          // TODO: Open resume
                        },
                        icon: const Icon(Icons.description_outlined),
                        label: const Text('View Resume'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                      ),
                    _buildStatusInfo(application.status),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(ApplicationStatus status) {
    Color color;
    String text;
    
    switch (status) {
      case ApplicationStatus.pending:
        color = AppColors.warning;
        text = 'Pending';
        break;
      case ApplicationStatus.accepted:
        color = AppColors.success;
        text = 'Accepted';
        break;
      case ApplicationStatus.rejected:
        color = AppColors.error;
        text = 'Rejected';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStatusInfo(ApplicationStatus status) {
    IconData icon;
    String text;
    Color color;
    
    switch (status) {
      case ApplicationStatus.pending:
        icon = Icons.hourglass_empty;
        text = 'Awaiting review';
        color = AppColors.warning;
        break;
      case ApplicationStatus.accepted:
        icon = Icons.check_circle_outline;
        text = 'Application accepted';
        color = AppColors.success;
        break;
      case ApplicationStatus.rejected:
        icon = Icons.cancel_outlined;
        text = 'Application rejected';
        color = AppColors.error;
        break;
    }
    
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}