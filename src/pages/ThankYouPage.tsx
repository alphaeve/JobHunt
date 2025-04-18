import React from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { CheckCircle, Home } from 'lucide-react';

interface LocationState {
  jobTitle?: string;
  company?: string;
}

const ThankYouPage: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const state = location.state as LocationState || {};
  const { jobTitle = 'the position', company = 'the company' } = state;
  
  return (
    <div className="container mx-auto px-4 py-16 max-w-md text-center">
      <div className="bg-white dark:bg-gray-800 rounded-lg shadow-md p-8">
        <div className="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-green-100 dark:bg-green-900 mb-6">
          <CheckCircle className="h-10 w-10 text-green-600 dark:text-green-300" />
        </div>
        
        <h1 className="text-2xl font-bold text-gray-900 dark:text-white mb-4">
          Application Submitted!
        </h1>
        
        <p className="text-gray-600 dark:text-gray-400 mb-8">
          Thank you for applying to <span className="font-semibold">{jobTitle}</span> at <span className="font-semibold">{company}</span>. We've received your application and will review it shortly.
        </p>
        
        <div className="bg-blue-50 dark:bg-blue-900/30 rounded-md p-4 mb-8">
          <p className="text-sm text-blue-800 dark:text-blue-200">
            We will contact you via email with updates on your application status. Please make sure to check your inbox regularly.
          </p>
        </div>
        
        <button
          onClick={() => navigate('/')}
          className="inline-flex items-center justify-center py-2.5 px-4 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-lg transition-colors duration-200"
        >
          <Home className="h-4 w-4 mr-2" />
          Back to Home
        </button>
      </div>
      
      <div className="mt-8">
        <h2 className="text-xl font-semibold text-gray-900 dark:text-white mb-4">
          What happens next?
        </h2>
        
        <div className="flex flex-col space-y-4 text-left">
          <div className="flex items-start">
            <div className="flex-shrink-0 h-8 w-8 rounded-full bg-blue-100 dark:bg-blue-900 flex items-center justify-center mr-3">
              <span className="text-blue-600 dark:text-blue-300 font-medium">1</span>
            </div>
            <div>
              <h3 className="font-medium text-gray-900 dark:text-white">Application Review</h3>
              <p className="text-sm text-gray-600 dark:text-gray-400">
                Our hiring team will review your application within 1-3 business days.
              </p>
            </div>
          </div>
          
          <div className="flex items-start">
            <div className="flex-shrink-0 h-8 w-8 rounded-full bg-blue-100 dark:bg-blue-900 flex items-center justify-center mr-3">
              <span className="text-blue-600 dark:text-blue-300 font-medium">2</span>
            </div>
            <div>
              <h3 className="font-medium text-gray-900 dark:text-white">Initial Screening</h3>
              <p className="text-sm text-gray-600 dark:text-gray-400">
                If your profile matches our requirements, we'll contact you for an initial screening.
              </p>
            </div>
          </div>
          
          <div className="flex items-start">
            <div className="flex-shrink-0 h-8 w-8 rounded-full bg-blue-100 dark:bg-blue-900 flex items-center justify-center mr-3">
              <span className="text-blue-600 dark:text-blue-300 font-medium">3</span>
            </div>
            <div>
              <h3 className="font-medium text-gray-900 dark:text-white">Interview Process</h3>
              <p className="text-sm text-gray-600 dark:text-gray-400">
                Selected candidates will proceed to the interview stage with the hiring team.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ThankYouPage;