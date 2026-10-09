import { ShieldCheck, User, LogOut } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import { toast } from 'sonner';

export default function Settings() {
  const navigate = useNavigate();
  const adminUser = JSON.parse(localStorage.getItem('adminUser') || '{}');

  const handleLogout = () => {
    localStorage.removeItem('adminToken');
    localStorage.removeItem('adminUser');
    toast.success('Logged out successfully');
    navigate('/login');
  };

  return (
    <div className="animate-in fade-in duration-300 max-w-4xl mx-auto">
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-navy-900">Settings</h1>
        <p className="text-slate-500 mt-1">Manage your administrator account</p>
      </div>

      <div className="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden mb-8">
        <div className="px-6 py-5 border-b border-slate-100 bg-slate-50/50">
          <h3 className="font-bold text-navy-900">Admin Profile</h3>
        </div>
        <div className="p-6">
          <div className="flex items-center mb-6">
            <div className="w-16 h-16 rounded-full bg-brand-100 text-brand-600 flex items-center justify-center border-2 border-brand-200">
              <User className="w-8 h-8" />
            </div>
            <div className="ml-5">
              <h4 className="text-lg font-bold text-navy-900">System Administrator</h4>
              <p className="text-slate-500">{adminUser.email || 'admin@quczo.com'}</p>
            </div>
          </div>
          
          <div className="space-y-4 max-w-md">
            <div>
              <label className="block text-sm font-semibold text-slate-700 mb-1">Email Address</label>
              <input type="email" readOnly value={adminUser.email || 'admin@quczo.com'} className="w-full px-4 py-2 border border-slate-200 rounded-lg bg-slate-50 text-slate-500 outline-none cursor-not-allowed" />
            </div>
            <div>
              <label className="block text-sm font-semibold text-slate-700 mb-1">Role</label>
              <input type="text" readOnly value="Superadmin" className="w-full px-4 py-2 border border-slate-200 rounded-lg bg-slate-50 text-slate-500 outline-none cursor-not-allowed" />
            </div>
          </div>
        </div>
      </div>

      <div className="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden mb-8">
        <div className="px-6 py-5 border-b border-slate-100 bg-slate-50/50">
          <h3 className="font-bold text-navy-900 flex items-center">
            <ShieldCheck className="w-5 h-5 mr-2 text-brand-600" /> Security
          </h3>
        </div>
        <div className="p-6">
          <p className="text-slate-600 mb-4">You are currently logged in securely. Password changes must be performed through the master database or infrastructure provider.</p>
          <button onClick={handleLogout} className="flex items-center px-4 py-2.5 bg-red-50 text-red-600 hover:bg-red-100 font-semibold rounded-lg transition-colors border border-red-100">
            <LogOut className="w-4 h-4 mr-2" />
            Sign Out of Admin Panel
          </button>
        </div>
      </div>
    </div>
  );
}
