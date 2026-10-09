import { useState, useEffect } from 'react';
import api from '../api';
import { Users, Store, Package, ShoppingCart, TrendingUp, AlertTriangle } from 'lucide-react';
import { toast } from 'sonner';

export default function Dashboard() {
  const [stats, setStats] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  const loadDashboard = () => {
    setLoading(true);
    setError(null);
    api.get('/admin/dashboard')
      .then((res) => {
        setStats(res.data.data);
      })
      .catch((err) => {
        setError(err.response?.data?.message || err.message || 'Failed to load dashboard data');
      })
      .finally(() => {
        setLoading(false);
      });
  };

  useEffect(() => {
    loadDashboard();
  }, []);

  const cards = [
    { title: 'Total Customers', value: stats?.totalCustomers, icon: Users, color: 'text-blue-600', bg: 'bg-blue-50', border: 'border-blue-100' },
    { title: 'Shop Owners', value: stats?.totalShopOwners, icon: Store, color: 'text-purple-600', bg: 'bg-purple-50', border: 'border-purple-100' },
    { title: 'Total Shops', value: stats?.totalShops, icon: Store, color: 'text-orange-600', bg: 'bg-orange-50', border: 'border-orange-100' },
    { title: 'Total Products', value: stats?.totalProducts, icon: Package, color: 'text-brand-600', bg: 'bg-brand-50', border: 'border-brand-100' },
    { title: 'Total Reservations', value: stats?.totalReservations, icon: ShoppingCart, color: 'text-indigo-600', bg: 'bg-indigo-50', border: 'border-indigo-100' },
  ];

  return (
    <div className="space-y-6 animate-in fade-in duration-300">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between mb-8">
        <div>
          <h1 className="text-2xl font-bold text-navy-900">Dashboard</h1>
          <p className="text-slate-500 mt-1">Overview of your QUCZO platform</p>
        </div>
        <div className="mt-4 sm:mt-0 flex items-center space-x-3 text-sm font-medium text-slate-600 bg-white px-4 py-2 rounded-lg border border-slate-200 shadow-sm">
          <TrendingUp className="w-4 h-4 text-brand-500" />
          <span>System running smoothly</span>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-6">
        {loading ? (
          Array(5).fill(0).map((_, i) => (
            <div key={i} className="bg-white rounded-2xl p-6 border border-slate-100 shadow-sm h-32 shimmer"></div>
          ))
        ) : error ? (
          <div className="col-span-1 md:col-span-2 lg:col-span-3 xl:col-span-5 bg-white rounded-2xl border border-red-200 p-8 flex flex-col items-center justify-center text-center shadow-sm">
            <div className="w-12 h-12 bg-red-100 text-red-500 rounded-full flex items-center justify-center mb-3">
              <span className="text-xl font-bold">!</span>
            </div>
            <p className="text-navy-900 font-semibold mb-1">Unable to load dashboard</p>
            <p className="text-slate-500 text-sm mb-4">{error}</p>
            <button 
              onClick={loadDashboard}
              className="px-4 py-2 bg-slate-100 hover:bg-slate-200 text-slate-700 font-semibold rounded-lg transition-colors text-sm"
            >
              Retry
            </button>
          </div>
        ) : (
          cards.map((card, i) => (
            <div key={i} className={`bg-white rounded-2xl shadow-sm border ${card.border} p-6 flex flex-col justify-between hover:shadow-md transition-shadow relative overflow-hidden group`}>
              <div className="flex items-start justify-between">
                <div>
                  <p className="text-sm font-semibold text-slate-500 mb-1">{card.title}</p>
                  <h3 className="text-3xl font-extrabold text-navy-900">{card.value}</h3>
                </div>
                <div className={`p-3 rounded-xl ${card.bg} ${card.color}`}>
                  <card.icon className="w-6 h-6" />
                </div>
              </div>
            </div>
          ))
        )}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 mt-8">
        <div className="lg:col-span-2 bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
          <div className="px-6 py-5 border-b border-slate-100 flex justify-between items-center">
            <h3 className="font-bold text-navy-900">Recent Reservations</h3>
            <button className="text-sm text-brand-600 font-semibold hover:text-brand-700">View All</button>
          </div>
          <div className="p-6 flex flex-col items-center justify-center text-slate-500 min-h-[300px]">
            <ShoppingCart className="w-12 h-12 mb-3 text-slate-300" />
            <p>Recent reservations will appear here.</p>
          </div>
        </div>

        <div className="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
          <div className="px-6 py-5 border-b border-slate-100 flex justify-between items-center">
            <h3 className="font-bold text-navy-900 flex items-center">
              <AlertTriangle className="w-4 h-4 text-orange-500 mr-2" />
              Low Stock Alerts
            </h3>
          </div>
          <div className="p-6 flex flex-col items-center justify-center text-slate-500 min-h-[300px]">
             <Package className="w-12 h-12 mb-3 text-slate-300" />
             <p>All stock levels are optimal.</p>
          </div>
        </div>
      </div>
    </div>
  );
}
