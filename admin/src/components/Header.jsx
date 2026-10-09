import { LogOut, Bell, Search, ShieldCheck } from 'lucide-react';
import { useNavigate, useLocation } from 'react-router-dom';
import { toast } from 'sonner';

export default function Header() {
  const navigate = useNavigate();
  const location = useLocation();

  const handleLogout = () => {
    localStorage.removeItem('adminToken');
    localStorage.removeItem('adminUser');
    toast.success('Logged out successfully');
    navigate('/login');
  };

  const getPageTitle = () => {
    switch (location.pathname) {
      case '/': return 'Overview';
      case '/customers': return 'Customers';
      case '/shop-owners': return 'Shop Owners';
      case '/shops': return 'Shops';
      case '/products': return 'Products';
      case '/reservations': return 'Reservations';
      case '/inventory': return 'Inventory';
      case '/billing': return 'Billing & Sales';
      case '/settings': return 'Settings';
      default: return 'Dashboard';
    }
  };

  return (
    <header className="bg-white border-b border-slate-200 h-20 flex items-center justify-between px-8 z-10 sticky top-0 shadow-sm">
      <div className="flex items-center space-x-4">
        <h2 className="text-xl font-bold text-navy-900">{getPageTitle()}</h2>
      </div>

      <div className="flex items-center space-x-6">
        <div className="relative hidden md:block">
          <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" />
          <input 
            type="text" 
            placeholder="Search..." 
            className="pl-10 pr-4 py-2 bg-slate-100 border-transparent rounded-lg text-sm focus:bg-white focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 outline-none transition-all w-64"
          />
        </div>

        <button className="text-slate-400 hover:text-slate-600 relative">
          <Bell className="w-5 h-5" />
          <span className="absolute 1 top-0 right-0 w-2 h-2 bg-red-500 rounded-full border-2 border-white"></span>
        </button>

        <div className="h-8 w-px bg-slate-200"></div>

        <div className="flex items-center space-x-3">
          <div className="flex items-center justify-center w-9 h-9 rounded-full bg-brand-100 text-brand-600">
            <ShieldCheck className="w-5 h-5" />
          </div>
          <div className="hidden sm:block text-sm">
            <p className="font-semibold text-navy-900 leading-none">Admin User</p>
            <p className="text-slate-500 text-xs mt-1">Superadmin</p>
          </div>
        </div>

        <button onClick={handleLogout} className="text-slate-400 hover:text-red-500 transition-colors ml-2" title="Logout">
          <LogOut className="w-5 h-5" />
        </button>
      </div>
    </header>
  );
}
