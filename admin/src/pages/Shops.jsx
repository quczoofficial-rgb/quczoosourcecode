import { useState, useEffect } from 'react';
import api from '../api';
import { Search, MoreVertical, Store, CheckCircle2, MapPin } from 'lucide-react';

export default function Shops() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  const fetchShops = () => {
    setLoading(true);
    setError(null);
    api.get('/admin/shops')
      .then((res) => {
        setData(res.data.data || []);
      })
      .catch((err) => {
        setError(err.response?.data?.message || err.message || 'Unable to load shops');
      })
      .finally(() => {
        setLoading(false);
      });
  };

  useEffect(() => {
    fetchShops();
  }, []);

  return (
    <div className="animate-in fade-in duration-300">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between mb-8">
        <div>
          <h1 className="text-2xl font-bold text-navy-900">Shops</h1>
          <p className="text-slate-500 mt-1">Manage registered QUCZO shops</p>
        </div>
      </div>

      <div className="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead className="bg-slate-50 border-b border-slate-200">
              <tr>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Shop Details</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Owner Contact</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Status</th>
                <th className="px-6 py-4 text-right text-xs font-semibold text-slate-500 uppercase tracking-wider">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {loading ? (
                Array(5).fill(0).map((_, i) => (
                  <tr key={i}>
                    <td className="px-6 py-4"><div className="h-10 w-48 shimmer rounded"></div></td>
                    <td className="px-6 py-4"><div className="h-6 w-32 shimmer rounded"></div></td>
                    <td className="px-6 py-4"><div className="h-6 w-16 shimmer rounded-full"></div></td>
                    <td className="px-6 py-4 text-right"><div className="h-6 w-8 shimmer rounded ml-auto"></div></td>
                  </tr>
                ))
              ) : error ? (
                <tr>
                  <td colSpan="4" className="px-6 py-16 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-12 h-12 bg-red-100 text-red-500 rounded-full flex items-center justify-center mb-3">
                        <span className="text-xl font-bold">!</span>
                      </div>
                      <p className="text-navy-900 font-semibold mb-1">Unable to load shops</p>
                      <p className="text-slate-500 text-sm mb-4">{error}</p>
                      <button 
                        onClick={fetchShops}
                        className="px-4 py-2 bg-slate-100 hover:bg-slate-200 text-slate-700 font-semibold rounded-lg transition-colors text-sm"
                      >
                        Retry
                      </button>
                    </div>
                  </td>
                </tr>
              ) : data.length === 0 ? (
                <tr>
                  <td colSpan="4" className="px-6 py-16 text-center">
                    <div className="flex flex-col items-center">
                      <Store className="w-12 h-12 text-slate-300 mb-3" />
                      <p className="text-navy-900 font-semibold">No shops found</p>
                    </div>
                  </td>
                </tr>
              ) : data.map((shop) => (
                  <tr key={shop.id} className="hover:bg-slate-50/80 transition-colors">
                    <td className="px-6 py-4">
                      <div className="flex items-center">
                        <div className="h-10 w-10 rounded-xl bg-orange-100 flex items-center justify-center text-orange-600 font-bold mr-3 border border-orange-200">
                          <Store className="w-5 h-5" />
                        </div>
                        <div>
                          <div className="font-bold text-navy-900">{shop.business_name || 'Unnamed Shop'}</div>
                          <div className="text-xs text-slate-500 flex items-center mt-0.5">
                            <MapPin className="w-3 h-3 mr-1" />
                            {shop.city || 'Location pending'}
                          </div>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="text-sm font-medium text-navy-900">{shop.owner_name || 'Owner'}</div>
                      <div className="text-xs text-slate-500">{shop.mobile || 'No phone'}</div>
                    </td>
                    <td className="px-6 py-4">
                      <span className="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold bg-green-100 text-green-700 border border-green-200">
                        <CheckCircle2 className="w-3.5 h-3.5 mr-1" /> Active
                      </span>
                    </td>
                    <td className="px-6 py-4 text-right">
                      <button className="text-slate-400 hover:text-brand-600 transition-colors p-2 rounded-lg hover:bg-brand-50">
                        <MoreVertical className="w-5 h-5" />
                      </button>
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
