import React, { useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { ArrowLeft } from 'lucide-react';
import { jobs } from '../data/jobsData';
import { ref, push } from 'firebase/database';
import { database } from '../firebase'; 

type Qualification = '10th' | '12th' | 'diploma' | 'engineering';

const ApplicationForm: React.FC = () => {
  const { jobId } = useParams<{ jobId: string }>();
  const navigate = useNavigate();
  const job = jobs.find(j => j.id === jobId);
  
  const [formData, setFormData] = useState({
    fullName: '',
    email: '',
    phone: '',
    qualification: '' as Qualification,
    address: {
      street: '',
      city: '',
      state: '',
      zipCode: ''
    }
  });
  
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [isSubmitting, setIsSubmitting] = useState(false);
  
  if (!job) {
    return (
      <div className="container mx-auto px-4 py-12 text-center">
        <h2 className="text-2xl font-bold text-gray-900 dark:text-white mb-4">Job Not Found</h2>
        <p className="text-gray-600 dark:text-gray-400 mb-6">
          Sorry, the job you're looking for doesn't exist or has been removed.
        </p>
        <button
          onClick={() => navigate('/jobs')}
          className="inline-flex items-center text-blue-600 dark:text-blue-400 hover:underline"
        >
          <ArrowLeft className="h-4 w-4 mr-1" />
          Back to all jobs
        </button>
      </div>
    );
  }
  
  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    const { name, value } = e.target;
    if (name.includes('.')) {
      const [parent, child] = name.split('.');
      setFormData(prev => ({
        ...prev,
        [parent]: {
          ...prev[parent as keyof typeof prev],
          [child]: value
        }
      }));
    } else {
      setFormData(prev => ({
        ...prev,
        [name]: value
      }));
    }
    
    if (errors[name]) {
      setErrors(prev => {
        const newErrors = { ...prev };
        delete newErrors[name];
        return newErrors;
      });
    }
  };
  
  const validate = () => {
    const newErrors: Record<string, string> = {};
    if (!formData.fullName.trim()) newErrors.fullName = 'Name is required';
    if (!formData.email.trim()) {
      newErrors.email = 'Email is required';
    } else if (!/\S+@\S+\.\S+/.test(formData.email)) {
      newErrors.email = 'Email is invalid';
    }
    if (!formData.phone.trim()) {
      newErrors.phone = 'Phone number is required';
    } else if (!/^\d{10,15}$/.test(formData.phone.replace(/[^\d]/g, ''))) {
      newErrors.phone = 'Phone number is invalid';
    }
    if (!formData.qualification) newErrors.qualification = 'Qualification is required';
    if (!formData.address.street.trim()) newErrors['address.street'] = 'Street address is required';
    if (!formData.address.city.trim()) newErrors['address.city'] = 'City is required';
    if (!formData.address.state.trim()) newErrors['address.state'] = 'State is required';
    if (!formData.address.zipCode.trim()) newErrors['address.zipCode'] = 'ZIP code is required';
    
    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };
  
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
  
    if (validate()) {
      setIsSubmitting(true);
      try {
        const formRef = ref(database, 'applications');
        await push(formRef, {
          ...formData,
          jobId,
          jobTitle: job.title,
          company: job.company,
          submittedAt: new Date().toISOString(),
        });
        navigate('/thank-you', {
          state: { jobTitle: job.title, company: job.company },
        });
      } catch (error) {
        console.error('Error submitting to Firebase:', error);
        alert('Something went wrong. Please try again later.');
      } finally {
        setIsSubmitting(false);
      }
    }
  };
  
  
  return (
    <div className="container mx-auto px-4 py-8 max-w-3xl">
      <button
        onClick={() => navigate('/jobs')}
        className="inline-flex items-center text-blue-600 dark:text-blue-400 mb-6 hover:underline"
      >
        <ArrowLeft className="h-4 w-4 mr-1" />
        Back to all jobs
      </button>
      
      <div className="bg-white dark:bg-gray-800 rounded-lg shadow-md p-6 md:p-8">
        <h1 className="text-2xl font-bold text-gray-900 dark:text-white mb-2">
          Apply for {job.title}
        </h1>
        <p className="text-gray-600 dark:text-gray-400 mb-6">
          at {job.company} • {job.location}
        </p>
        
        <form onSubmit={handleSubmit}>
          <div className="grid grid-cols-1 gap-6 mb-6">
            <div>
              <label htmlFor="fullName" className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                Full Name <span className="text-red-500">*</span>
              </label>
              <input
                type="text"
                id="fullName"
                name="fullName"
                value={formData.fullName}
                onChange={handleChange}
                className={`w-full px-4 py-2 border ${
                  errors.fullName ? 'border-red-500' : 'border-gray-300 dark:border-gray-600'
                } rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white`}
                placeholder="John Doe"
              />
              {errors.fullName && (
                <p className="mt-1 text-sm text-red-500">{errors.fullName}</p>
              )}
            </div>
            
            <div>
              <label htmlFor="email" className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                Email <span className="text-red-500">*</span>
              </label>
              <input
                type="email"
                id="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                className={`w-full px-4 py-2 border ${
                  errors.email ? 'border-red-500' : 'border-gray-300 dark:border-gray-600'
                } rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white`}
                placeholder="john.doe@example.com"
              />
              {errors.email && (
                <p className="mt-1 text-sm text-red-500">{errors.email}</p>
              )}
            </div>
            
            <div>
              <label htmlFor="phone" className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                Phone Number <span className="text-red-500">*</span>
              </label>
              <input
                type="tel"
                id="phone"
                name="phone"
                value={formData.phone}
                onChange={handleChange}
                className={`w-full px-4 py-2 border ${
                  errors.phone ? 'border-red-500' : 'border-gray-300 dark:border-gray-600'
                } rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white`}
                placeholder="(123) 456-7890"
              />
              {errors.phone && (
                <p className="mt-1 text-sm text-red-500">{errors.phone}</p>
              )}
            </div>
            
            <div>
              <label htmlFor="qualification" className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                Qualification <span className="text-red-500">*</span>
              </label>
              <select
                id="qualification"
                name="qualification"
                value={formData.qualification}
                onChange={handleChange}
                className={`w-full px-4 py-2 border ${
                  errors.qualification ? 'border-red-500' : 'border-gray-300 dark:border-gray-600'
                } rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white`}
              >
                <option value="">Select qualification</option>
                <option value="10th">10th Pass</option>
                <option value="12th">12th Pass</option>
                <option value="diploma">Diploma</option>
                <option value="engineering">Engineering</option>
              </select>
              {errors.qualification && (
                <p className="mt-1 text-sm text-red-500">{errors.qualification}</p>
              )}
            </div>
            
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label htmlFor="address.street" className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Street Address <span className="text-red-500">*</span>
                </label>
                <input
                  type="text"
                  id="address.street"
                  name="address.street"
                  value={formData.address.street}
                  onChange={handleChange}
                  className={`w-full px-4 py-2 border ${
                    errors['address.street'] ? 'border-red-500' : 'border-gray-300 dark:border-gray-600'
                  } rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white`}
                  placeholder="123 Main St"
                />
                {errors['address.street'] && (
                  <p className="mt-1 text-sm text-red-500">{errors['address.street']}</p>
                )}
              </div>
              
              <div>
                <label htmlFor="address.city" className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  City <span className="text-red-500">*</span>
                </label>
                <input
                  type="text"
                  id="address.city"
                  name="address.city"
                  value={formData.address.city}
                  onChange={handleChange}
                  className={`w-full px-4 py-2 border ${
                    errors['address.city'] ? 'border-red-500' : 'border-gray-300 dark:border-gray-600'
                  } rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white`}
                  placeholder="San Francisco"
                />
                {errors['address.city'] && (
                  <p className="mt-1 text-sm text-red-500">{errors['address.city']}</p>
                )}
              </div>
              
              <div>
                <label htmlFor="address.state" className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  State <span className="text-red-500">*</span>
                </label>
                <input
                  type="text"
                  id="address.state"
                  name="address.state"
                  value={formData.address.state}
                  onChange={handleChange}
                  className={`w-full px-4 py-2 border ${
                    errors['address.state'] ? 'border-red-500' : 'border-gray-300 dark:border-gray-600'
                  } rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white`}
                  placeholder="CA"
                />
                {errors['address.state'] && (
                  <p className="mt-1 text-sm text-red-500">{errors['address.state']}</p>
                )}
              </div>
              
              <div>
                <label htmlFor="address.zipCode" className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  ZIP Code <span className="text-red-500">*</span>
                </label>
                <input
                  type="text"
                  id="address.zipCode"
                  name="address.zipCode"
                  value={formData.address.zipCode}
                  onChange={handleChange}
                  className={`w-full px-4 py-2 border ${
                    errors['address.zipCode'] ? 'border-red-500' : 'border-gray-300 dark:border-gray-600'
                  } rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white`}
                  placeholder="94105"
                />
                {errors['address.zipCode'] && (
                  <p className="mt-1 text-sm text-red-500">{errors['address.zipCode']}</p>
                )}
              </div>
            </div>
          </div>
          
          <button
            type="submit"
            disabled={isSubmitting}
            className={`w-full py-3 px-4 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-lg transition-colors duration-200 ${
              isSubmitting ? 'opacity-70 cursor-not-allowed' : ''
            }`}
          >
            {isSubmitting ? 'Submitting...' : 'Submit Application'}
          </button>
        </form>
      </div>
    </div>
  );
};

export default ApplicationForm;