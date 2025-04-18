import React from 'react';
import { Link } from 'react-router-dom';
import { Calendar, MapPin, Briefcase, DollarSign } from 'lucide-react';
import { Job } from '../data/jobsData';

interface JobCardProps {
  job: Job;
}

const JobCard: React.FC<JobCardProps> = ({ job }) => {
  return (
    <div className="bg-white dark:bg-gray-800 rounded-lg shadow-md overflow-hidden border border-gray-100 dark:border-gray-700 hover:shadow-lg transition-all duration-300 transform hover:-translate-y-1">
      <div className="p-6">
        <div className="flex items-center justify-between mb-4">
          <div className="flex items-center">
            <div className="h-12 w-12 rounded-md overflow-hidden bg-gray-100 dark:bg-gray-700 flex items-center justify-center mr-4">
              {job.logo ? (
                <img src={job.logo} alt={`${job.company} logo`} className="h-full w-full object-cover" />
              ) : (
                <Briefcase className="h-6 w-6 text-gray-400" />
              )}
            </div>
            <div>
              <h3 className="text-lg font-semibold text-gray-900 dark:text-white">{job.title}</h3>
              <p className="text-sm text-gray-600 dark:text-gray-300">{job.company}</p>
            </div>
          </div>
          <span className="text-xs font-medium bg-blue-100 dark:bg-blue-900 text-blue-800 dark:text-blue-200 px-2.5 py-0.5 rounded-full">
            {job.type}
          </span>
        </div>
        
        <p className="text-gray-600 dark:text-gray-300 mb-4 line-clamp-2">{job.description}</p>
        
        <div className="flex flex-wrap items-center text-sm text-gray-500 dark:text-gray-400 mb-4 gap-y-2">
          <div className="flex items-center mr-4">
            <MapPin className="h-4 w-4 mr-1" />
            <span>{job.location}</span>
          </div>
          <div className="flex items-center mr-4">
            <DollarSign className="h-4 w-4 mr-1" />
            <span>{job.salary}</span>
          </div>
          <div className="flex items-center">
            <Calendar className="h-4 w-4 mr-1" />
            <span>Posted {job.postedDate}</span>
          </div>
        </div>
        
        <Link 
          to={`/apply/${job.id}`}
          className="block w-full text-center py-2.5 px-4 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-lg transition-colors duration-200"
        >
          Apply Now
        </Link>
      </div>
    </div>
  );
};

export default JobCard;