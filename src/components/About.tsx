import { ArrowLeft } from 'lucide-react';
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

const About: React.FC = () => {
  const navigate = useNavigate();
  
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    message: '',
  });

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setFormData({
      ...formData,
      [name]: value,
    });
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log('Form Submitted:', formData);
    // Add form submission logic here (e.g., sending data to an API)
    alert('Message sent successfully!');
  };

  return (
    <div>
      {/* Back Button */}
      <button
        onClick={() => navigate(-1)}
        className="inline-flex items-center text-blue-600 dark:text-blue-400 mb-6 hover:underline"
      >
        <ArrowLeft className="h-4 w-4 mr-1" />
        Back
      </button>
      
      {/* Hero Section */}
      <section className="bg-gradient-to-r from-blue-600 to-indigo-700 py-16 text-center">
        <h1 className="text-4xl md:text-5xl font-bold text-white mb-4">
          About Us
        </h1>
        <p className="text-white text-lg md:text-xl opacity-90">
          Your Trusted Partner in Finding the Right Job
        </p>
      </section>

      {/* About Us Section */}
      <section className="py-12 bg-gray-50 dark:bg-gray-900">
        <div className="container mx-auto px-4 text-center">
          <div className="max-w-4xl mx-auto">
            <h2 className="text-3xl font-extrabold text-gray-900 dark:text-white mb-6">
              Our Mission
            </h2>
            <p className="text-lg text-gray-600 dark:text-gray-400 mb-6">
              At [Your Company Name], we aim to connect job seekers with employers in Gujarat, providing a seamless platform for finding great opportunities.
            </p>
            <p className="text-lg text-gray-600 dark:text-gray-400 mb-6">
              Whether you are looking for a career in sales, tech, customer service, or more, we are here to help you take the next step in your career journey.
            </p>

            <h3 className="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
              Why Choose Us?
            </h3>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
              <div className="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-md">
                <h4 className="text-xl font-semibold text-gray-900 dark:text-white mb-2">Curated Job Listings</h4>
                <p className="text-gray-600 dark:text-gray-400">
                  We carefully select the best job opportunities to ensure you have access to only the most relevant positions.
                </p>
              </div>
              <div className="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-md">
                <h4 className="text-xl font-semibold text-gray-900 dark:text-white mb-2">Verified Employers</h4>
                <p className="text-gray-600 dark:text-gray-400">
                  All companies listed on our platform are verified to ensure you are applying to legitimate and trustworthy employers.
                </p>
              </div>
              <div className="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-md">
                <h4 className="text-xl font-semibold text-gray-900 dark:text-white mb-2">Easy Application Process</h4>
                <p className="text-gray-600 dark:text-gray-400">
                  We make it easy to apply for jobs with a simplified, user-friendly application process that saves you time.
                </p>
              </div>
              <div className="bg-white dark:bg-gray-800 p-6 rounded-lg shadow-md">
                <h4 className="text-xl font-semibold text-gray-900 dark:text-white mb-2">24/7 Support</h4>
                <p className="text-gray-600 dark:text-gray-400">
                  Our support team is always available to assist you with any questions or issues you may encounter along the way.
                </p>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Contact Us Section */}
      <section className="py-12 bg-gray-50 dark:bg-gray-900">
        <div className="container mx-auto px-4 text-center">
          <h2 className="text-3xl font-extrabold text-gray-900 dark:text-white mb-6">
            Contact Us
          </h2>
          <p className="text-lg text-gray-600 dark:text-gray-400 mb-6">
            If you have any questions or need further assistance, feel free to contact us.
          </p>
          <form onSubmit={handleSubmit} className="max-w-xl mx-auto bg-white dark:bg-gray-800 p-8 rounded-lg shadow-md">
            <div className="mb-4">
              <label htmlFor="name" className="block text-gray-700 dark:text-gray-300 font-semibold mb-2">Name</label>
              <input
                type="text"
                id="name"
                name="name"
                value={formData.name}
                onChange={handleInputChange}
                className="w-full p-3 border border-gray-300 dark:border-gray-700 rounded-lg dark:bg-gray-900 dark:text-gray-200 focus:ring-2 focus:ring-blue-600"
                required
              />
            </div>
            <div className="mb-4">
              <label htmlFor="email" className="block text-gray-700 dark:text-gray-300 font-semibold mb-2">Email</label>
              <input
                type="email"
                id="email"
                name="email"
                value={formData.email}
                onChange={handleInputChange}
                className="w-full p-3 border border-gray-300 dark:border-gray-700 rounded-lg dark:bg-gray-900 dark:text-gray-200 focus:ring-2 focus:ring-blue-600"
                required
              />
            </div>
            <div className="mb-4">
              <label htmlFor="message" className="block text-gray-700 dark:text-gray-300 font-semibold mb-2">Message</label>
              <textarea
                id="message"
                name="message"
                value={formData.message}
                onChange={handleInputChange}
                className="w-full p-3 border border-gray-300 dark:border-gray-700 rounded-lg dark:bg-gray-900 dark:text-gray-200 focus:ring-2 focus:ring-blue-600"
                rows={4}
                required
              />
            </div>
            <button
              type="submit"
              className="w-full bg-blue-600 dark:bg-blue-700 text-white p-3 rounded-lg hover:bg-blue-700 dark:hover:bg-blue-600 focus:ring-2 focus:ring-blue-500"
            >
              Send Message
            </button>
          </form>
        </div>
      </section>

      {/* Footer Section */}
      <footer className="bg-gray-800 py-6">
        <div className="container mx-auto px-4 text-center">
          <p className="text-white">
            &copy; {new Date().getFullYear()} JobHunt. All Rights Reserved.
          </p>
        </div>
      </footer>
    </div>
  );
};

export default About;
