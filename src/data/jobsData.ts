export interface Job {
  id: string;
  title: string;
  company: string;
  location: string;
  type: string;
  salary: string;
  description: string;
  requirements: string[];
  postedDate: string;
  logo?: string; // Optional logo if you want to add in future
}

export const jobs: Job[] = [
  {
    id: '1',
    title: 'Call Center / BPO Executive',
    company: 'TelePro Services',
    location: 'Ahmedabad, Gujarat',
    type: 'Full-time',
    salary: '₹22,482 – ₹26,489 PM',
    description: 'Handling inbound calls, customer service, and solving client queries.',
    requirements: [
      'Good communication skills',
      'Basic knowledge of MS Office',
      'Customer service experience is a plus',
    ],
    postedDate: '2 days ago',
  },
  {
    id: '2',
    title: 'Sales Executive / Telecaller',
    company: 'QuickDeals Ltd.',
    location: 'Vadodara, Gujarat',
    type: 'Full-time',
    salary: '₹20,675 – ₹24,003 PM',
    description: 'Calling leads, following up, and converting sales in a retail environment.',
    requirements: [
      'Fluency in local language and Hindi',
      'Sales experience preferred',
      'Ability to handle rejection',
    ],
    postedDate: '3 days ago',
  },
  {
    id: '3',
    title: 'Data Entry Operator',
    company: 'ExcelSoft Solutions',
    location: 'Rajkot, Gujarat',
    type: 'Full-time',
    salary: '₹19,756 – ₹25,000 PM',
    description: 'Entering, managing, and updating company data records accurately.',
    requirements: [
      'Typing speed of 35+ WPM',
      'Knowledge of MS Excel',
      'Attention to detail',
    ],
    postedDate: '4 days ago',
  },
  {
    id: '4',
    title: 'Courier Delivery Agent',
    company: 'Speedy Express',
    location: 'Bharuch, Gujarat',
    type: 'Full-time',
    salary: '₹18,000 – ₹23,000 PM',
    description: 'Timely delivery of parcels across city zones. Route tracking and pickup verification.',
    requirements: [
      'Valid 2-wheeler license',
      'Basic smartphone operation',
      'Local area knowledge',
    ],
    postedDate: '5 days ago',
  },
  {
    id: '5',
    title: 'Retail Store Assistant',
    company: 'D-Mart',
    location: 'Surat, Gujarat',
    type: 'Full-time',
    salary: '₹18,000 – ₹22,000 PM',
    description: 'Shelf management, assisting customers, billing, and inventory support.',
    requirements: [
      'Customer-friendly attitude',
      'Willing to work shifts',
      'Experience in retail preferred',
    ],
    postedDate: '6 days ago',
  },
  {
    id: '6',
    title: 'Electrician',
    company: 'Shakti Electricals',
    location: 'Vadodara, Gujarat',
    type: 'Full-time',
    salary: '₹21,000 – ₹26,000 PM',
    description: 'Wiring, installations, and troubleshooting for residential and office projects.',
    requirements: [
      'Certified Electrician course',
      'Basic tools knowledge',
      '2+ years experience',
    ],
    postedDate: '6 days ago',
  },
  {
    id: '7',
    title: 'Housekeeping Staff',
    company: 'CleanCare Services',
    location: 'Ahmedabad, Gujarat',
    type: 'Full-time',
    salary: '₹15,000 – ₹18,000 PM',
    description: 'Daily cleaning, maintenance, and sanitation of assigned workspaces.',
    requirements: [
      'Work ethic and discipline',
      'Experience in housekeeping',
      'Knowledge of cleaning supplies',
    ],
    postedDate: '7 days ago',
  },
  {
    id: '8',
    title: 'Mechanic (2W/4W)',
    company: 'AutoCare Garage',
    location: 'Rajkot, Gujarat',
    type: 'Full-time',
    salary: '₹22,000 – ₹26,000 PM',
    description: 'Diagnosing, repairing and servicing two- and four-wheelers.',
    requirements: [
      'Auto mechanic certification',
      'Knowledge of vehicle systems',
      'Experience preferred',
    ],
    postedDate: '8 days ago',
  },
  {
    id: '9',
    title: 'Front Desk Assistant',
    company: 'Hotel Shubh Stay',
    location: 'Surat, Gujarat',
    type: 'Full-time',
    salary: '₹19,000 – ₹23,000 PM',
    description: 'Guest handling, bookings, and managing check-in/check-out process.',
    requirements: [
      'Good communication in English/Hindi',
      'Pleasant personality',
      'Basic computer knowledge',
    ],
    postedDate: '9 days ago',
  },
  {
    id: '10',
    title: 'Security Guard',
    company: 'SecureZone Pvt Ltd.',
    location: 'Bharuch, Gujarat',
    type: 'Full-time',
    salary: '₹16,000 – ₹20,000 PM',
    description: 'Monitoring premises, checking visitors, and ensuring workplace safety.',
    requirements: [
      'Basic security training',
      'Physical fitness',
      'Alertness and discipline',
    ],
    postedDate: '10 days ago',
  },
  {
    id: '16',
    title: 'Bank Clerk Assistant',
    company: 'State Bank Branch',
    location: 'Ahmedabad, Gujarat',
    type: 'Full-time',
    salary: '₹20,000 – ₹25,000 PM',
    description: 'Assisting bank operations, managing forms, helping customers with basic queries.',
    requirements: [
      '12th pass or graduate',
      'Basic computer skills',
      'Customer handling experience is a plus'
    ],
    postedDate: '1 day ago'
  },
  {
    id: '17',
    title: 'Ward Assistant',
    company: 'City Hospital',
    location: 'Surat, Gujarat',
    type: 'Full-time',
    salary: '₹16,000 – ₹19,000 PM',
    description: 'Assisting patients, cleaning beds, and supporting nurses in the general ward.',
    requirements: [
      'Physically fit',
      'Basic hygiene training',
      'Empathy and patience'
    ],
    postedDate: '2 days ago'
  },
  {
    id: '18',
    title: 'Hospital Receptionist',
    company: 'Shree Care Hospital',
    location: 'Vadodara, Gujarat',
    type: 'Full-time',
    salary: '₹18,000 – ₹22,000 PM',
    description: 'Handling patient registration, phone calls, and appointment scheduling.',
    requirements: [
      'Good communication skills',
      'Basic computer and typing knowledge',
      'Polite and professional attitude'
    ],
    postedDate: '2 days ago'
  },
  {
    id: '19',
    title: 'Pharmacy Assistant',
    company: 'CityMed Pharmacy',
    location: 'Bharuch, Gujarat',
    type: 'Full-time',
    salary: '₹17,000 – ₹21,000 PM',
    description: 'Assisting pharmacist in medicine stock, billing, and helping customers.',
    requirements: [
      'Basic knowledge of medicines',
      'Retail experience preferred',
      'Attention to detail'
    ],
    postedDate: '3 days ago'
  },
  {
    id: '20',
    title: 'Peon / Office Helper',
    company: 'Local Government Office',
    location: 'Surat, Gujarat',
    type: 'Full-time',
    salary: '₹15,000 – ₹18,000 PM',
    description: 'Helping with document transfer, tea service, and basic cleaning duties.',
    requirements: [
      'Minimum 10th pass',
      'Honest and punctual',
      'Physically active'
    ],
    postedDate: '3 days ago'
  },
  {
    id: '21',
    title: 'Teller / Cashier',
    company: 'Gramin Bank',
    location: 'Vadodara, Gujarat',
    type: 'Full-time',
    salary: '₹20,000 – ₹24,000 PM',
    description: 'Handling cash transactions, deposits, and withdrawals in a rural bank branch.',
    requirements: [
      'Basic knowledge of accounting',
      'Comfortable handling cash',
      'Good with people'
    ],
    postedDate: '4 days ago'
  },
  {
    id: '22',
    title: 'Hospital Cleaning Staff',
    company: 'CarePoint Hospital',
    location: 'Ahmedabad, Gujarat',
    type: 'Full-time',
    salary: '₹14,000 – ₹17,000 PM',
    description: 'Ensuring hygiene and cleanliness in all hospital areas and patient rooms.',
    requirements: [
      'Experience in housekeeping',
      'Understanding of sanitization standards',
      'Willingness to work shifts'
    ],
    postedDate: '4 days ago'
  },
  {
    id: '23',
    title: 'ATM Service Assistant',
    company: 'SecureATM Services',
    location: 'Bharuch, Gujarat',
    type: 'Full-time',
    salary: '₹18,500 – ₹21,000 PM',
    description: 'Maintaining ATM cash load schedule and reporting service issues.',
    requirements: [
      'Bike and driving license',
      'Basic tech understanding',
      'Trustworthy nature'
    ],
    postedDate: '5 days ago'
  }
  
];
