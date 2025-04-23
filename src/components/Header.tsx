import React from 'react';
import { Link } from 'react-router-dom';
import { Sun, Moon, Briefcase, FileText } from 'lucide-react';
import { useTheme } from '../context/ThemeContext';

const Header: React.FC = () => {
  const { darkMode, toggleDarkMode } = useTheme();

  return (
    <header className="sticky top-0 z-50 bg-white dark:bg-gray-900 shadow-sm transition-colors duration-200">
      <div className="container mx-auto px-6 py-4 flex items-center justify-between">
        <Link
          to="/"
          className="flex items-center space-x-2 text-blue-600 dark:text-blue-400 transition-colors duration-200 hover:text-blue-700"
        >
          <Briefcase className="h-6 w-6" />
          <span className="text-2xl font-semibold">JobSetu</span>
        </Link>

        <div className="flex items-center space-x-6">
          <Link
            to="/jobs"
            className="px-4 py-2 rounded-full text-gray-700 dark:text-gray-200 hover:bg-blue-600 hover:text-white dark:hover:bg-blue-400 transition-colors duration-300"
          >
            Jobs
          </Link>

          <Link
            to="/About"
            className="px-4 py-2 rounded-full text-gray-700 dark:text-gray-200 hover:bg-blue-600 hover:text-white dark:hover:bg-blue-400 transition-colors duration-300"
          >
            About
          </Link>

          <Link
            to="/Contact"
            className="px-4 py-2 rounded-full text-gray-700 dark:text-gray-200 hover:bg-blue-600 hover:text-white dark:hover:bg-blue-400 transition-colors duration-300"
          >
            Contact
          </Link>

          <Link
            to="/privacy-policy"
            className="px-4 py-2 rounded-full text-gray-700 dark:text-gray-200 hover:bg-blue-600 hover:text-white dark:hover:bg-blue-400 transition-colors duration-300"
          >
            Privacy Policy
          </Link>

          <Link
            to="/terms"
            className="px-4 py-2 rounded-full text-gray-700 dark:text-gray-200 hover:bg-blue-600 hover:text-white dark:hover:bg-blue-400 transition-colors duration-300"
          >
            Terms
          </Link>

          <button
            onClick={toggleDarkMode}
            className="p-3 rounded-full bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-200 hover:bg-gray-200 dark:hover:bg-gray-700 transition-all duration-300"
            aria-label={darkMode ? 'Switch to light mode' : 'Switch to dark mode'}
          >
            {darkMode ? <Sun className="h-5 w-5" /> : <Moon className="h-5 w-5" />}
          </button>
        </div>
      </div>
    </header>
  );
};

export default Header;
