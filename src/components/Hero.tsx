import React from 'react';
import { Search, MapPin } from 'lucide-react';

interface HeroProps {
  onSearch: () => void;
}

const Hero: React.FC<HeroProps> = ({ onSearch }) => {
  return (
    <div className="relative bg-gradient-to-r from-blue-600 to-blue-800 dark:from-blue-900 dark:to-blue-700">
      <div className="absolute inset-0 opacity-10">
        <svg className="h-full w-full" viewBox="0 0 100 100" preserveAspectRatio="none">
          <path d="M0,0 L100,0 L100,100 L0,100 Z" fill="url(#grid-pattern)" />
        </svg>
        <defs>
          <pattern id="grid-pattern" width="10" height="10" patternUnits="userSpaceOnUse">
            <path d="M 10 0 L 0 0 0 10" fill="none" stroke="white" strokeWidth="0.5" />
          </pattern>
        </defs>
      </div>
      
      <div className="container mx-auto px-4 py-16 md:py-24 relative z-10">
        <div className="text-center max-w-3xl mx-auto mb-10">
          <h1 className="text-3xl md:text-4xl lg:text-5xl font-bold text-white mb-4 leading-tight">
            Find Your Dream Job Today
          </h1>
          <p className="text-lg text-blue-100 mb-8">
            Discover thousands of job opportunities with all the information you need.
          </p>
          
          <div className="bg-white dark:bg-gray-800 p-2 md:p-3 rounded-lg shadow-lg flex flex-col md:flex-row">
            <div className="flex-1 flex items-center p-2 border-b md:border-b-0 md:border-r border-gray-200 dark:border-gray-700">
              <Search className="h-5 w-5 text-gray-400 mr-2" />
              <input 
                type="text" 
                placeholder="Job title or keyword" 
                className="w-full bg-transparent focus:outline-none text-gray-700 dark:text-gray-200"
              />
            </div>
            <div className="flex-1 flex items-center p-2">
              <MapPin className="h-5 w-5 text-gray-400 mr-2" />
              <input 
                type="text" 
                placeholder="Location" 
                className="w-full bg-transparent focus:outline-none text-gray-700 dark:text-gray-200"
              />
            </div>
            <button 
              onClick={onSearch}
              className="bg-blue-600 hover:bg-blue-700 text-white font-medium px-6 py-3 rounded-md transition-colors duration-200 mt-3 md:mt-0 md:ml-2"
            >
              Search Jobs
            </button>
          </div>
        </div>
        
        <div className="flex flex-wrap justify-center gap-4 text-blue-100">
          <span className="text-sm bg-blue-700/30 px-3 py-1 rounded-full">Popular: </span>
          <span className="text-sm bg-blue-700/30 px-3 py-1 rounded-full hover:bg-blue-700/50 cursor-pointer transition-colors">
            Web Developer
          </span>
          <span className="text-sm bg-blue-700/30 px-3 py-1 rounded-full hover:bg-blue-700/50 cursor-pointer transition-colors">
            UX Designer
          </span>
          <span className="text-sm bg-blue-700/30 px-3 py-1 rounded-full hover:bg-blue-700/50 cursor-pointer transition-colors">
            Data Scientist
          </span>
          <span className="text-sm bg-blue-700/30 px-3 py-1 rounded-full hover:bg-blue-700/50 cursor-pointer transition-colors">
            Product Manager
          </span>
        </div>
      </div>
    </div>
  );
};

export default Hero;