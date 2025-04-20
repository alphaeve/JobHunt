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
  },
  {
    id: '24',
    title: 'Delivery Executive',
    company: 'QuickDrop Logistics',
    location: 'Surat, Gujarat',
    type: 'Full-time',
    salary: '₹15,000 – ₹20,000 PM',
    description: 'Deliver packages to customer locations using bike. Daily targets with incentives.',
    requirements: [
      'Bike and valid driving license',
      'Smartphone with GPS',
      'Minimum 10th pass'
    ],
    postedDate: '2 days ago'
  },
  {
    id: '25',
    title: 'Machine Operator (CNC)',
    company: 'Rajkot Gears Pvt. Ltd.',
    location: 'Rajkot, Gujarat',
    type: 'Full-time',
    salary: '₹17,000 – ₹22,000 PM',
    description: 'Operate CNC machines and ensure quality in mechanical part production.',
    requirements: [
      'ITI/Diploma in Fitter/Turner',
      'Basic machine handling knowledge',
      '1 year experience preferred'
    ],
    postedDate: '1 day ago'
  },
  {
    id: '26',
    title: 'Retail Sales Associate',
    company: 'StyleSmart Garments',
    location: 'Ahmedabad, Gujarat',
    type: 'Full-time',
    salary: '₹12,000 – ₹16,000 PM',
    description: 'Assist customers in selecting clothing and maintaining store cleanliness.',
    requirements: [
      '12th pass minimum',
      'Good communication skills',
      'Friendly and outgoing nature'
    ],
    postedDate: '3 days ago'
  },
  {
    id: '27',
    title: 'Hospital Ward Assistant',
    company: 'Sunrise MultiSpecialty Hospital',
    location: 'Vadodara, Gujarat',
    type: 'Full-time',
    salary: '₹13,000 – ₹17,000 PM',
    description: 'Support patients and nurses with daily ward activities and cleanliness.',
    requirements: [
      '10th/12th pass',
      'Basic patient care knowledge',
      'Compassionate and reliable'
    ],
    postedDate: '2 days ago'
  },
  {
    id: '28',
    title: 'Telecaller - Domestic BPO',
    company: 'ConnectCare Solutions',
    location: 'Bharuch, Gujarat',
    type: 'Full-time',
    salary: '₹10,000 – ₹14,000 PM + Incentives',
    description: 'Call customers to promote financial services and record feedback.',
    requirements: [
      '12th pass',
      'Fluent in Hindi/Gujarati',
      'Basic computer knowledge'
    ],
    postedDate: '5 days ago'
  },
  {
    id: '29',
    title: 'AC Service Technician',
    company: 'CoolTech Services',
    location: 'Vadodara, Gujarat',
    type: 'Full-time',
    salary: '₹16,000 – ₹20,000 PM',
    description: 'Installation, maintenance, and servicing of air conditioning units.',
    requirements: [
      'ITI in Refrigeration/AC',
      'Bike and tool kit',
      'Field work readiness'
    ],
    postedDate: '4 days ago'
  },
  {
    id: '30',
    title: 'Back Office Executive',
    company: 'Finzo Microfinance',
    location: 'Ahmedabad, Gujarat',
    type: 'Full-time',
    salary: '₹14,000 – ₹18,000 PM',
    description: 'Handle data entry, documentation, and client follow-up from office.',
    requirements: [
      '12th pass or Diploma',
      'MS Excel & typing skills',
      'Attention to detail'
    ],
    postedDate: '1 day ago'
  },
  {
    id: '31',
    title: 'Electrician – Industrial',
    company: 'ShreeTech Industries',
    location: 'Rajkot, Gujarat',
    type: 'Full-time',
    salary: '₹18,000 – ₹22,000 PM',
    description: 'Maintain and repair factory electrical lines and panels.',
    requirements: [
      'ITI in Electrician trade',
      'Knowledge of industrial wiring',
      'Safety-conscious'
    ],
    postedDate: '6 days ago'
  },
  {
    id: '32',
    title: 'Field Technician – Broadband',
    company: 'FiberOne Telecom',
    location: 'Surat, Gujarat',
    type: 'Full-time',
    salary: '₹15,000 – ₹19,000 PM',
    description: 'Install broadband lines and troubleshoot customer connectivity issues.',
    requirements: [
      'Diploma or ITI in Networking',
      'Bike with fuel allowance',
      'Basic networking knowledge'
    ],
    postedDate: '3 days ago'
  },
  {
    id: '33',
    title: 'Warehouse Packing Staff',
    company: 'SwiftPack Solutions',
    location: 'Bharuch, Gujarat',
    type: 'Full-time',
    salary: '₹11,000 – ₹14,000 PM',
    description: 'Pick, pack, and sort products in a warehouse environment.',
    requirements: [
      'Physically fit',
      '10th pass minimum',
      'Ready for shift work'
    ],
    postedDate: '2 days ago'
  },
  
    {
      id: '34',
      title: 'Mobile Repair Technician',
      company: 'GadgetFix Mobile Services',
      location: 'Ahmedabad, Gujarat',
      type: 'Full-time',
      salary: '₹16,000 – ₹20,000 PM',
      description: 'Repair smartphones, replace screens, and diagnose issues at service center.',
      requirements: [
        'ITI in Electronics or experience in mobile repair',
        'Basic soldering and diagnostic tools knowledge',
        'Customer-friendly attitude'
      ],
      postedDate: '3 days ago'
    },
    {
      id: '35',
      title: 'CCTV Installation Technician',
      company: 'SecureVision Surveillance',
      location: 'Surat, Gujarat',
      type: 'Full-time',
      salary: '₹14,500 – ₹18,500 PM',
      description: 'Install and maintain CCTV camera systems at client locations.',
      requirements: [
        'ITI/Diploma in Electronics or Electrical',
        'Bike for travel',
        'Knowledge of DVR/NVR setup'
      ],
      postedDate: '2 days ago'
    },
    {
      id: '36',
      title: 'Bakery Helper',
      company: 'Bread & Butter Bakers',
      location: 'Rajkot, Gujarat',
      type: 'Full-time',
      salary: '₹10,000 – ₹13,000 PM',
      description: 'Assist in baking, packing, and cleaning tasks in a commercial bakery.',
      requirements: [
        '10th pass',
        'Willingness to work early morning shifts',
        'Clean and hygienic habits'
      ],
      postedDate: '5 days ago'
    },
    {
      id: '37',
      title: 'Pharmacy Counter Assistant',
      company: 'HealthLine Pharmacy',
      location: 'Vadodara, Gujarat',
      type: 'Full-time',
      salary: '₹13,000 – ₹16,000 PM',
      description: 'Assist customers with purchasing medicines and handle billing counter.',
      requirements: [
        '12th pass with basic medical knowledge',
        'Good communication skills',
        'Basic computer billing knowledge'
      ],
      postedDate: '1 day ago'
    },
    {
      id: '38',
      title: 'Tailoring Assistant',
      company: 'FitStitch Apparel',
      location: 'Bharuch, Gujarat',
      type: 'Full-time',
      salary: '₹11,000 – ₹14,000 PM',
      description: 'Support master tailor with cutting, stitching, and finishing garments.',
      requirements: [
        '10th pass',
        'Basic knowledge of stitching machines',
        'Attention to detail'
      ],
      postedDate: '4 days ago'
    },
    {
      id: '39',
      title: 'Computer Typist – Office Work',
      company: 'BrightDesk Solutions',
      location: 'Ahmedabad, Gujarat',
      type: 'Full-time',
      salary: '₹12,000 – ₹16,000 PM',
      description: 'Enter and maintain office records, typing documents and reports.',
      requirements: [
        '12th pass or above',
        'Typing speed 30+ WPM',
        'MS Word and Excel knowledge'
      ],
      postedDate: '2 days ago'
    },
    {
      id: '40',
      title: 'Cooking Assistant – Mess & Canteen',
      company: 'TastyBites Canteen Services',
      location: 'Rajkot, Gujarat',
      type: 'Full-time',
      salary: '₹10,000 – ₹13,500 PM',
      description: 'Support main cook in food preparation and cleaning in a mess or canteen.',
      requirements: [
        'Basic cooking knowledge',
        'Clean habits and team worker',
        'Willing to work early or night shifts'
      ],
      postedDate: '3 days ago'
    },
    {
      id: '41',
      title: 'Housekeeping Staff – Hotel',
      company: 'RoyalView Residency',
      location: 'Vadodara, Gujarat',
      type: 'Full-time',
      salary: '₹11,000 – ₹14,000 PM',
      description: 'Maintain cleanliness in hotel rooms, corridors, and common areas.',
      requirements: [
        'Physically fit',
        '10th pass preferred',
        'Experience in hotel cleaning is a plus'
      ],
      postedDate: '6 days ago'
    },
    {
      id: '42',
      title: 'Printing Press Helper',
      company: 'PrintTech Solutions',
      location: 'Surat, Gujarat',
      type: 'Full-time',
      salary: '₹11,500 – ₹15,000 PM',
      description: 'Assist in operating offset and digital printing machines and material loading.',
      requirements: [
        '10th pass minimum',
        'Basic machine handling experience',
        'Attention to quality and safety'
      ],
      postedDate: '2 days ago'
    },
    {
      id: '43',
      title: 'Field Executive – Insurance Documents',
      company: 'LifeAssist Agencies',
      location: 'Bharuch, Gujarat',
      type: 'Full-time',
      salary: '₹13,000 – ₹17,000 PM + Travel Allowance',
      description: 'Collect customer documents, verify details and assist in KYC updates.',
      requirements: [
        '12th pass',
        'Bike and smartphone',
        'Well-dressed and trustworthy'
      ],
      postedDate: '1 day ago'
    }
];
