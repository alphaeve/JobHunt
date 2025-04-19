import React from 'react';
import JobList from '../components/JobList';


const JobListPage: React.FC = () => {
  return (
    <div className="container mx-auto px-4 py-12">
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">
          Available Positions
        </h1>
        <p className="text-gray-600 dark:text-gray-400">
          Find your next career opportunity
        </p>
      </div>
      <JobList />
    </div>
  );
};

export default JobListPage;