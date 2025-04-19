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
  logo: string;
}

export const jobs = [
  {
    id: '1',
    title: 'Call Center / BPO Executive',
    company: 'Various Companies',
    location: 'Mumbai, India',
    type: 'Full-time',
    salary: '₹22,482 – ₹26,489 PM',
    description: 'Handling inbound calls, customer service, and solving client queries in various industries.',
    requirements: [
      'Good communication skills',
      'Basic knowledge of MS Office',
      'Customer service experience is a plus'
    ],
    postedDate: '2 days ago'
  },
  {
    id: '2',
    title: 'Receptionist / Front Desk Assistant',
    company: 'Various Companies',
    location: 'Delhi, India',
    type: 'Full-time',
    salary: '₹20,675 – ₹24,003 PM',
    description: 'Handling front desk operations, managing office schedules, and customer greetings.',
    requirements: [
      'Good interpersonal skills',
      'Basic computer skills',
      'Prior experience in a similar role'
    ],
    postedDate: '3 days ago'
  },
  {
    id: '3',
    title: 'Sales Executive / Telecaller',
    company: 'Various Companies',
    location: 'Bangalore, India',
    type: 'Full-time',
    salary: '₹19,756 – ₹29,905 PM',
    description: 'Selling products or services over the phone or in person, generating leads, and closing sales.',
    requirements: [
      'Good communication skills',
      'Sales experience is preferred',
      'Ability to handle rejection'
    ],
    postedDate: '4 days ago'
  },
  {
    id: '4',
    title: 'Courier Boy / Delivery Agent',
    company: 'Swiggy, Zomato, Amazon, etc.',
    location: 'Chennai, India',
    type: 'Full-time',
    salary: '₹22,093 – ₹28,649 PM',
    description: 'Delivering packages or food items within the city, ensuring timely and safe delivery.',
    requirements: [
      'Good local knowledge',
      'Valid driving license',
      'Familiarity with delivery apps'
    ],
    postedDate: '5 days ago'
  },
  {
    id: '5',
    title: 'Bank Mitra (Agent)',
    company: 'Various Banks',
    location: 'Rural Areas, India',
    type: 'Full-time',
    salary: '₹21,187 – ₹25,785 PM',
    description: 'Acting as a liaison between the bank and rural customers, handling deposits and withdrawals.',
    requirements: [
      'Basic knowledge of banking',
      'Ability to work in rural areas',
      'Communication skills'
    ],
    postedDate: '6 days ago'
  },
  {
    id: '6',
    title: 'Data Entry Operator',
    company: 'Various Companies',
    location: 'Hyderabad, India',
    type: 'Full-time',
    salary: '₹21,206 – ₹27,859 PM',
    description: 'Entering and managing data, performing clerical duties in an office setting.',
    requirements: [
      'Typing speed of 40+ WPM',
      'Knowledge of MS Office',
      'Attention to detail'
    ],
    postedDate: '7 days ago'
  },
  {
    id: '7',
    title: 'Retail Store Staff',
    company: 'D-Mart, Reliance Smart, etc.',
    location: 'Pune, India',
    type: 'Full-time',
    salary: '₹19,124 – ₹26,161 PM',
    description: 'Assisting customers, restocking shelves, and handling checkout processes.',
    requirements: [
      'Customer service experience',
      'Good communication skills',
      'Willingness to work in shifts'
    ],
    postedDate: '8 days ago'
  },
  {
    id: '8',
    title: 'Tally / Accounting Assistant',
    company: 'Various Companies',
    location: 'Kolkata, India',
    type: 'Full-time',
    salary: '₹18,166 – ₹24,110 PM',
    description: 'Handling accounts, managing bookkeeping entries, and generating financial reports.',
    requirements: [
      'Tally certification',
      'Basic accounting knowledge',
      'Attention to detail'
    ],
    postedDate: '9 days ago'
  },
  {
    id: '9',
    title: 'Electrician',
    company: 'Various Companies',
    location: 'Ahmedabad, India',
    type: 'Full-time',
    salary: '₹24,264 – ₹26,304 PM',
    description: 'Installing and repairing electrical systems in homes, offices, and industrial settings.',
    requirements: [
      'Electrician certification',
      'Knowledge of electrical wiring and systems',
      'Hands-on experience in electrical repairs'
    ],
    postedDate: '10 days ago'
  },
  {
    id: '10',
    title: 'Plumber',
    company: 'Various Companies',
    location: 'Lucknow, India',
    type: 'Full-time',
    salary: '₹20,124 – ₹22,654 PM',
    description: 'Repairing, installing, and maintaining plumbing systems in residential and commercial buildings.',
    requirements: [
      'Plumbing certification',
      'Experience with plumbing systems',
      'Good problem-solving skills'
    ],
    postedDate: '11 days ago'
  },
  {
    id: '11',
    title: 'Welder / Fitter / Turner',
    company: 'Various Companies',
    location: 'Surat, India',
    type: 'Full-time',
    salary: '₹19,161 – ₹25,230 PM',
    description: 'Welding and fitting parts for machinery and structures.',
    requirements: [
      'Welding certification',
      'Experience with welding tools',
      'Ability to read blueprints'
    ],
    postedDate: '12 days ago'
  },
  {
    id: '12',
    title: 'Mechanic (2W/4W)',
    company: 'Various Companies',
    location: 'Jaipur, India',
    type: 'Full-time',
    salary: '₹23,119 – ₹24,447 PM',
    description: 'Repairing and servicing two-wheelers and four-wheelers.',
    requirements: [
      'Mechanic certification',
      'Experience in vehicle repair',
      'Knowledge of automotive systems'
    ],
    postedDate: '13 days ago'
  },
  {
    id: '13',
    title: 'Housekeeper / Maid',
    company: 'Various Agencies',
    location: 'Varanasi, India',
    type: 'Full-time',
    salary: '₹15,000 – ₹18,000 PM',
    description: 'Cleaning, maintaining household items, and performing other household tasks.',
    requirements: [
      'Experience in housekeeping',
      'Attention to cleanliness',
      'Good communication skills'
    ],
    postedDate: '14 days ago'
  },
  {
    id: '14',
    title: 'Chef / Cook',
    company: 'Various Hotels & Restaurants',
    location: 'Goa, India',
    type: 'Full-time',
    salary: '₹25,000 – ₹35,000 PM',
    description: 'Preparing meals and managing kitchen activities in restaurants and hotels.',
    requirements: [
      'Experience in cooking and kitchen management',
      'Knowledge of food safety standards',
      'Creativity and passion for cooking'
    ],
    postedDate: '15 days ago'
  },
  {
    id: '15',
    title: 'Security Guard',
    company: 'Various Agencies',
    location: 'Chandigarh, India',
    type: 'Full-time',
    salary: '₹18,000 – ₹22,000 PM',
    description: 'Protecting people and property, monitoring surveillance systems.',
    requirements: [
      'Basic security training',
      'Physical fitness',
      'Ability to handle emergency situations'
    ],
    postedDate: '16 days ago'
  }
];
