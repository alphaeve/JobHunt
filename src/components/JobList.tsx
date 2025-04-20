import React, { useState, useEffect } from 'react';
import JobCard from './JobCard';
import { jobs } from '../data/jobsData';

interface JobListProps {
  selectedCity: string;
}

const JobList: React.FC<JobListProps> = ({ selectedCity }) => {
  const [currentPage, setCurrentPage] = useState(1);
  const jobsPerPage = 8;

  // Filter jobs by selected city
  const filteredJobs = selectedCity
    ? jobs.filter((job) =>
        job.location.toLowerCase().includes(selectedCity.toLowerCase())
      )
    : jobs;

  const totalPages = Math.ceil(filteredJobs.length / jobsPerPage);

  const indexOfLastJob = currentPage * jobsPerPage;
  const indexOfFirstJob = indexOfLastJob - jobsPerPage;
  const currentJobs = filteredJobs.slice(indexOfFirstJob, indexOfLastJob);

  // Reset to page 1 if selectedCity changes
  useEffect(() => {
    setCurrentPage(1);
  }, [selectedCity]);

  return (
    <div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
        {currentJobs.length > 0 ? (
          currentJobs.map((job) => (
            <JobCard key={job.id} job={job} />
          ))
        ) : (
          <p className="text-gray-600 dark:text-gray-300 col-span-full text-center">
            No jobs found for this city.
          </p>
        )}
      </div>

      {totalPages > 1 && (
        <div className="flex justify-center mt-8">
          <nav className="flex items-center space-x-2">
            <button
              onClick={() => setCurrentPage((p) => Math.max(1, p - 1))}
              disabled={currentPage === 1}
              className="px-3 py-1 rounded-md bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-200 disabled:opacity-50"
            >
              Previous
            </button>
            {[...Array(totalPages)].map((_, i) => (
              <button
                key={i}
                onClick={() => setCurrentPage(i + 1)}
                className={`px-3 py-1 rounded-md ${
                  currentPage === i + 1
                    ? 'bg-blue-600 text-white'
                    : 'bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-200'
                }`}
              >
                {i + 1}
              </button>
            ))}
            <button
              onClick={() => setCurrentPage((p) => Math.min(totalPages, p + 1))}
              disabled={currentPage === totalPages}
              className="px-3 py-1 rounded-md bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-200 disabled:opacity-50"
            >
              Next
            </button>
          </nav>
        </div>
      )}
    </div>
  );
};

export default JobList;
