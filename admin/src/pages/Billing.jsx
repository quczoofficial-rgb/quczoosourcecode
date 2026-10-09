import { useState, useEffect } from 'react';
import api from '../api';
import { IndianRupee, TrendingUp, CreditCard } from 'lucide-react';

export default function Billing() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  const fetchBilling = () => {
    setLoading(true);
    setError(null);
    api.get('/admin/billing')
      .then((res) => {
        setData(res.data.data || []);
      })
      .catch((err) => {
        setError(err.response?.data?.message || err.message || 'Unable to load billing data');
      })
      .finally(() => {
        setLoading(false);
      });
  };

  useEffect(() => {
    fetchBilling();
  }, []);

  const totalRevenue = data.reduce((sum, item) => sum + (item.total_amount || 0), 0);

  return (
    <div className="animate-in fade-in duration-300">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between mb-8">
        <div>
          <h1 className="text-2xl font-bold text-navy-900">Billing & Sales</h1>
          <p className="text-slate-500 mt-1">Platform revenue and transactions</p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div className="bg-white rounded-2xl shadow-sm border border-slate-200 p-6 flex items-center relative overflow-hidden">
          <div className="absolute top-0 right-0 w-32 h-32 bg-brand-50 rounded-full -mr-16 -mt-16 pointer-events-none"></div>
          <div className="p-4 bg-brand-100 text-brand-600 rounded-xl mr-5 z-10">
            <IndianRupee className="w-8 h-8" />
          </div>
          <div className="z-10">
            <p className="text-sm font-semibold text-slate-500 mb-1">Total Sales</p>
            <h3 className="text-3xl font-bold text-navy-900">₹{loading ? '-' : totalRevenue}</h3>
          </div>
        </div>
        
        <div className="bg-white rounded-2xl shadow-sm border border-slate-200 p-6 flex items-center">
          <div className="p-4 bg-blue-100 text-blue-600 rounded-xl mr-5">
            <CreditCard className="w-8 h-8" />
          </div>
          <div>
            <p className="text-sm font-semibold text-slate-500 mb-1">Total Transactions</p>
            <h3 className="text-3xl font-bold text-navy-900">{loading ? '-' : data.length}</h3>
          </div>
        </div>

        <div className="bg-white rounded-2xl shadow-sm border border-slate-200 p-6 flex items-center">
          <div className="p-4 bg-purple-100 text-purple-600 rounded-xl mr-5">
            <TrendingUp className="w-8 h-8" />
          </div>
          <div>
            <p className="text-sm font-semibold text-slate-500 mb-1">Average Order Value</p>
            <h3 className="text-3xl font-bold text-navy-900">
              ₹{loading || data.length === 0 ? '-' : Math.round(totalRevenue / data.length)}
            </h3>
          </div>
        </div>
      </div>

      <div className="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
        <div className="px-6 py-5 border-b border-slate-100 bg-slate-50/50">
          <h3 className="font-bold text-navy-900">Recent Transactions</h3>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead className="bg-slate-50 border-b border-slate-200">
              <tr>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Transaction ID</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Customer</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Shop</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Amount</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Date</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {loading ? (
                Array(5).fill(0).map((_, i) => (
                  <tr key={i}>
                    <td className="px-6 py-4"><div className="h-6 w-24 shimmer rounded"></div></td>
                    <td className="px-6 py-4"><div className="h-6 w-32 shimmer rounded"></div></td>
                    <td className="px-6 py-4"><div className="h-6 w-32 shimmer rounded"></div></td>
                    <td className="px-6 py-4"><div className="h-6 w-16 shimmer rounded"></div></td>
                    <td className="px-6 py-4"><div className="h-6 w-24 shimmer rounded"></div></td>
                  </tr>
                ))
              ) : error ? (
                <tr>
                  <td colSpan="5" className="px-6 py-16 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-12 h-12 bg-red-100 text-red-500 rounded-full flex items-center justify-center mb-3">
                        <span className="text-xl font-bold">!</span>
                      </div>
                      <p className="text-navy-900 font-semibold mb-1">Unable to load transactions</p>
                      <p className="text-slate-500 text-sm mb-4">{error}</p>
                      <button 
                        onClick={fetchBilling}
                        className="px-4 py-2 bg-slate-100 hover:bg-slate-200 text-slate-700 font-semibold rounded-lg transition-colors text-sm"
                      >
                        Retry
                      </button>
                    </div>
                  </td>
                </tr>
              ) : data.length === 0 ? (
                <tr>
                  <td colSpan="5" className="px-6 py-16 text-center">
                    <div className="flex flex-col items-center">
                      <CreditCard className="w-12 h-12 text-slate-300 mb-3" />
                      <p className="text-navy-900 font-semibold">No transactions found</p>
                    </div>
                  </td>
                </tr>
              ) : data.map((txn) => (
                  <tr key={txn.id} className="hover:bg-slate-50/80 transition-colors">
                    <td className="px-6 py-4 font-mono text-sm text-slate-600">
                      {txn.id.substring(0, 12)}...
                    </td>
                    <td className="px-6 py-4 font-medium text-navy-900">
                      {txn.customer?.name || txn.customer?.phone || 'Guest'}
                    </td>
                    <td className="px-6 py-4 text-slate-600">
                      {txn.shop?.name || 'Unknown'}
                    </td>
                    <td className="px-6 py-4 font-bold text-brand-600">
                      ₹{txn.total_amount}
                    </td>
                    <td className="px-6 py-4 text-sm text-slate-500">
                      {new Date(txn.created_at).toLocaleString()}
                    </td>
                  </tr>
                ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
