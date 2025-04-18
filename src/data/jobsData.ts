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

export const jobs: Job[] = [
  {
    id: '1',
    title: 'Chemical Engineer',
    company: 'Reliance Industries',
    location: 'Mumbai, Maharashtra',
    type: 'Full-time',
    salary: '₹6,00,000 - ₹9,00,000 PA',
    description: 'Leading chemical manufacturer seeks experienced Chemical Engineer for process optimization and plant operations.',
    requirements: [
      'B.Tech/B.E. in Chemical Engineering',
      '2-5 years experience in chemical plant operations',
      'Knowledge of process safety management',
      'Strong analytical and problem-solving skills',
      'Experience with HAZOP studies'
    ],
    postedDate: '2 days ago',
    logo: 'https://images.pexels.com/photos/2760243/pexels-photo-2760243.jpeg'
  },
  {
    id: '2',
    title: 'Electrical Engineer',
    company: 'Larsen & Toubro',
    location: 'Bangalore, Karnataka',
    type: 'Full-time',
    salary: '₹5,50,000 - ₹8,50,000 PA',
    description: 'L&T is looking for Electrical Engineers to join our power distribution projects team.',
    requirements: [
      'B.Tech/B.E. in Electrical Engineering',
      '3+ years experience in power systems',
      'Knowledge of electrical safety standards',
      'Experience with AutoCAD Electrical',
      'Strong project management skills'
    ],
    postedDate: '1 week ago',
    logo: 'https://images.pexels.com/photos/2467558/pexels-photo-2467558.jpeg'
  },
  {
    id: '3',
    title: 'Mechanical Engineer',
    company: 'Tata Motors',
    location: 'Pune, Maharashtra',
    type: 'Full-time',
    salary: '₹5,00,000 - ₹8,00,000 PA',
    description: 'Join our automotive design team to work on next-generation vehicle development projects.',
    requirements: [
      'B.Tech/B.E. in Mechanical Engineering',
      'Experience with CAD/CAM software',
      'Knowledge of automotive systems',
      'Good understanding of manufacturing processes',
      'Team player with excellent communication skills'
    ],
    postedDate: '3 days ago',
    logo: 'https://images.pexels.com/photos/3862130/pexels-photo-3862130.jpeg'
  },
  {
    id: '4',
    title: 'Production Supervisor',
    company: 'Hindustan Unilever',
    location: 'Chennai, Tamil Nadu',
    type: 'Full-time',
    salary: '₹4,50,000 - ₹7,00,000 PA',
    description: 'Looking for a Production Supervisor to oversee manufacturing operations and team management.',
    requirements: [
      'Diploma in Mechanical/Production Engineering',
      '2+ years supervisory experience',
      'Knowledge of lean manufacturing',
      'Strong leadership qualities',
      'Experience with ERP systems'
    ],
    postedDate: '5 days ago',
    logo: 'https://images.pexels.com/photos/3862132/pexels-photo-3862132.jpeg'
  },
  {
    id: '5',
    title: 'Quality Control Engineer',
    company: 'Maruti Suzuki',
    location: 'Gurugram, Haryana',
    type: 'Full-time',
    salary: '₹4,00,000 - ₹6,50,000 PA',
    description: 'Seeking Quality Control Engineer to maintain product quality standards and implement quality systems.',
    requirements: [
      'Diploma/B.Tech in Engineering',
      'Knowledge of ISO 9001 standards',
      'Experience with quality control tools',
      'Strong analytical skills',
      'Good communication abilities'
    ],
    postedDate: '1 week ago',
    logo: 'https://images.pexels.com/photos/3862135/pexels-photo-3862135.jpeg'
  },
  {
    id: '6',
    title: 'Maintenance Engineer',
    company: 'Asian Paints',
    location: 'Kolkata, West Bengal',
    type: 'Full-time',
    salary: '₹4,50,000 - ₹7,00,000 PA',
    description: 'Required Maintenance Engineer for managing plant equipment maintenance and repair activities.',
    requirements: [
      'Diploma in Mechanical/Electrical Engineering',
      '3+ years maintenance experience',
      'Knowledge of preventive maintenance',
      'Troubleshooting skills',
      'Available for shift work'
    ],
    postedDate: '4 days ago',
    logo: 'https://images.pexels.com/photos/3862138/pexels-photo-3862138.jpeg'
  },
  {
    id: '7',
    title: 'Process Engineer',
    company: 'Dr. Reddy\'s Laboratories',
    location: 'Hyderabad, Telangana',
    type: 'Full-time',
    salary: '₹5,50,000 - ₹8,50,000 PA',
    description: 'Looking for Process Engineers to optimize pharmaceutical manufacturing processes.',
    requirements: [
      'B.Tech in Chemical/Pharmaceutical Engineering',
      'Knowledge of GMP guidelines',
      'Experience in process optimization',
      'Analytical mindset',
      'Documentation skills'
    ],
    postedDate: '2 days ago',
    logo: 'https://images.pexels.com/photos/3862140/pexels-photo-3862140.jpeg'
  },
  {
    id: '8',
    title: 'Safety Engineer',
    company: 'ONGC',
    location: 'Dehradun, Uttarakhand',
    type: 'Full-time',
    salary: '₹6,00,000 - ₹9,00,000 PA',
    description: 'Required Safety Engineer to implement and maintain workplace safety protocols.',
    requirements: [
      'B.Tech with Diploma in Industrial Safety',
      'NEBOSH/IOSH certification preferred',
      'Knowledge of safety regulations',
      'Experience in risk assessment',
      'Emergency response planning'
    ],
    postedDate: '1 week ago',
    logo: 'https://images.pexels.com/photos/3862142/pexels-photo-3862142.jpeg'
  }
];