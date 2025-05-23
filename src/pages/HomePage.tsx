import React from 'react';
import { useNavigate } from 'react-router-dom';
import Hero from '../components/Hero';

const HomePage: React.FC = () => {
  const navigate = useNavigate();

  const handleSearch = () => {
    navigate('/jobs');
  };

  return (
    <div>
      <Hero onSearch={handleSearch} />

      {/* Highlight Stats */}
      <section className="bg-gradient-to-r from-blue-600 to-indigo-700 py-10">
        <div className="container mx-auto px-4 text-center">
          <h2 className="text-3xl md:text-4xl font-extrabold text-white mb-2 animate-pulse">
            2500+ Jobs Provided
          </h2>
          <p className="text-white text-lg md:text-xl opacity-90">
            Empowering thousands of job seekers with genuine opportunities across Gujarat
          </p>
        </div>
      </section>

      {/* Fake Job Listings */}
      <section className="bg-gray-50 dark:bg-gray-900 py-12">
        <div className="container mx-auto px-4">
          <h2 className="text-2xl font-bold text-center text-gray-800 dark:text-white mb-6">Latest Job Openings</h2>
          <div className="grid md:grid-cols-3 gap-6">
            {[1, 2, 3].map((job) => (
              <div key={job} className="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-md">
                <h3 className="text-xl font-semibold text-gray-900 dark:text-white">Front Desk Receptionist</h3>
                <p className="text-gray-600 dark:text-gray-400">Location: Ahmedabad</p>
                <p className="text-gray-600 dark:text-gray-400">Salary: ₹18,000/month</p>
                <p className="text-gray-600 dark:text-gray-400">HospitalCare Pvt. Ltd.</p>
                <button 
                  onClick={handleSearch} 
                  className="mt-4 bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded"
                >
                  View Job
                </button>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Why Job Seekers Love Us */}
      <section className="py-12 bg-white dark:bg-gray-900">
        <div className="container mx-auto px-4">
          <div className="max-w-3xl mx-auto text-center mb-10">
            <h2 className="text-2xl font-bold text-gray-900 dark:text-white mb-4">
              Why Job Seekers Love Us
            </h2>
            <p className="text-gray-600 dark:text-gray-400">
              We've helped thousands of job seekers find their dream careers
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {/* Features already included */}
          </div>
        </div>
      </section>

      {/* Footer Links */}
      <footer className="bg-gray-100 dark:bg-gray-800 py-6 mt-12">
        <div className="container mx-auto px-4 text-center">
          <ul className="flex justify-center gap-6 text-sm text-gray-700 dark:text-gray-300">
            <li><a href="/about">About Us</a></li>
            <li><a href="/contact">Contact</a></li>
            <li><a href="/privacy-policy">Privacy Policy</a></li>
            <li><a href="/terms">Terms of Service</a></li>
          </ul>
        </div>
      </footer>
    </div>
  );
};

export default HomePage;





// import React from 'react';
// import { useNavigate } from 'react-router-dom';
// import Hero from '../components/Hero';

// const HomePage: React.FC = () => {
//   const navigate = useNavigate();

//   const handleSearch = () => {
//     navigate('/jobs');
//   };

//   return (
//     <div>
//       <Hero onSearch={handleSearch} />
      
//       <section className="bg-gray-50 dark:bg-gray-900 py-12">
//         <div className="container mx-auto px-4">
//           {/* 2500+ Jobs Provided Section */}
//           <section className="bg-gradient-to-r from-blue-600 to-indigo-700 py-10">
//             <div className="container mx-auto px-4 text-center">
//               <h2 className="text-3xl md:text-4xl font-extrabold text-white mb-2 animate-pulse">
//                 2500+ Jobs Provided
//               </h2>
//               <p className="text-white text-lg md:text-xl opacity-90">
//                 Empowering thousands of job seekers with genuine opportunities across Gujarat
//               </p>
//             </div>
//           </section>

//           {/* Why Job Seekers Love Us Section */}
//           <div className="max-w-3xl mx-auto text-center mb-10">
//             <h2 className="text-2xl font-bold text-gray-900 dark:text-white mb-4">
//               Why Job Seekers Love Us
//             </h2>
//             <p className="text-gray-600 dark:text-gray-400">
//               We've helped thousands of job seekers find their dream careers
//             </p>
//           </div>
          
//           <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
//             <div className="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-md text-center">
//               <div className="bg-blue-100 dark:bg-blue-900 w-12 h-12 rounded-full flex items-center justify-center mx-auto mb-4">
//                 <svg className="h-6 w-6 text-blue-600 dark:text-blue-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
//                   <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
//                 </svg>
//               </div>
//               <h3 className="text-xl font-semibold text-gray-900 dark:text-white mb-2">
//                 Curated Job Listings
//               </h3>
//               <p className="text-gray-600 dark:text-gray-400">
//                 We hand-pick the best opportunities from top companies to save you time.
//               </p>
//             </div>
            
//             <div className="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-md text-center">
//               <div className="bg-blue-100 dark:bg-blue-900 w-12 h-12 rounded-full flex items-center justify-center mx-auto mb-4">
//                 <svg className="h-6 w-6 text-blue-600 dark:text-blue-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
//                   <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
//                 </svg>
//               </div>
//               <h3 className="text-xl font-semibold text-gray-900 dark:text-white mb-2">
//                 Verified Employers
//               </h3>
//               <p className="text-gray-600 dark:text-gray-400">
//                 All companies are verified to ensure you're applying to legitimate opportunities.
//               </p>
//             </div>
            
//             <div className="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-md text-center">
//               <div className="bg-blue-100 dark:bg-blue-900 w-12 h-12 rounded-full flex items-center justify-center mx-auto mb-4">
//                 <svg className="h-6 w-6 text-blue-600 dark:text-blue-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
//                   <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 10V3L4 14h7v7l9-11h-7z" />
//                 </svg>
//               </div>
//               <h3 className="text-xl font-semibold text-gray-900 dark:text-white mb-2">
//                 Easy Application
//               </h3>
//               <p className="text-gray-600 dark:text-gray-400">
//                 Apply to multiple jobs with just a few clicks, no lengthy processes.
//               </p>
//             </div>
//           </div>
//         </div>
//       </section>
//     </div>
//   );
// };

// export default HomePage;