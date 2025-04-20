import React, { useState } from 'react';
import JobList from '../components/JobList';

const JobListPage: React.FC = () => {
  const [selectedCity, setSelectedCity] = useState('');

  const cities = [
  'Ahmedabad',
  'Surat',
  'Vadodara',
  'Bharuch',
  'Rajkot',
  ];

  return (
    <div className="container mx-auto px-4 py-12">
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">
          Available Positions
        </h1>
        <p className="text-gray-600 dark:text-gray-400 mb-4">
          Find your next career opportunity
        </p>

        {/* City Filter Buttons */}
        <div className="flex flex-wrap gap-2 mb-6">
          {cities.map((city) => (
            <button
              key={city}
              onClick={() => setSelectedCity(city)}
              className={`px-4 py-2 rounded-full border ${
                selectedCity === city
                  ? 'bg-blue-600 text-white border-blue-600'
                  : 'bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-200 border-gray-300 dark:border-gray-600'
              } hover:shadow-md transition duration-200`}
            >
              {city}
            </button>
          ))}
          <button
            onClick={() => setSelectedCity('')}
            className="px-4 py-2 rounded-full bg-red-100 text-red-600 border border-red-300 hover:bg-red-200 transition"
          >
            Clear Filter
          </button>
        </div>
      </div>

      {/* Job List with Filtered City */}
      <JobList selectedCity={selectedCity} />
    </div>
  );
};

export default JobListPage;



// import React from 'react';
// import JobList from '../components/JobList';


// const JobListPage: React.FC = () => {
//   return (
//     <div className="container mx-auto px-4 py-12">
//       <div className="mb-8">
//         <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">
//           Available Positions
//         </h1>
//         <p className="text-gray-600 dark:text-gray-400">
//           Find your next career opportunity
//         </p>
//       </div>
//       <JobList />
//     </div>
//   );
// };

// export default JobListPage;