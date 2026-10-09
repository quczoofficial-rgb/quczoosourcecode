import { useState, useEffect } from 'react';
import api from '../api';
import { Search, MapPin, Clock, CheckCircle, Package } from 'lucide-react';

export default function Reservations() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  const loadReservations = () => {
    setLoading(true);
    setError(null);
    api.get('/admin/reservations')
      .then((res) => {
        setData(res.data.data || []);
      })
      .catch((err) => {
        setError(err.response?.data?.message || err.message || 'Unable to load reservations');
      })
      .finally(() => {
        setLoading(false);
      });
  };

  useEffect(() => {
    loadReservations();
  }, []);

  return (
    <div className="animate-in fade-in duration-300">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between mb-8">
        <div>
          <h1 className="text-2xl font-bold text-navy-900">Reservations</h1>
          <p className="text-slate-500 mt-1">Track customer pickup reservations</p>
        </div>
      </div>

      <div className="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead className="bg-slate-50 border-b border-slate-200">
              <tr>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Order ID</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Customer</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Amount</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Status</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Date</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {loading ? (
                Array(5).fill(0).map((_, i) => (
                  <tr key={i}>
                    <td className="px-6 py-4"><div className="h-6 w-24 shimmer rounded"></div></td>
                    <td className="px-6 py-4"><div className="h-10 w-32 shimmer rounded"></div></td>
                    <td className="px-6 py-4"><div className="h-6 w-16 shimmer rounded"></div></td>
                    <td className="px-6 py-4"><div className="h-6 w-20 shimmer rounded-full"></div></td>
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
                      <p className="text-navy-900 font-semibold mb-1">Unable to load reservations</p>
                      <p className="text-slate-500 text-sm mb-4">{error}</p>
                      <button 
                        onClick={loadReservations}
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
                      <Package className="w-12 h-12 text-slate-300 mb-3" />
                      <p className="text-navy-900 font-semibold">No reservations found</p>
                    </div>
                  </td>
                </tr>
              ) : data.map((r) => (
                  <tr key={r.id} className="hover:bg-slate-50/80 transition-colors">
                    <td className="px-6 py-4">
                      <div className="font-mono font-medium text-slate-600">#{r.id.substring(0,8).toUpperCase()}</div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="font-semibold text-navy-900">{r.customer?.name || r.customer?.phone || 'Guest'}</div>
                      <div className="text-xs text-slate-500 mt-0.5 flex items-center">
                        <MapPin className="w-3 h-3 mr-1" /> {r.shop?.name || 'Unknown Shop'}
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="font-bold text-brand-600">₹{r.total_amount}</div>
                    </td>
                    <td className="px-6 py-4">
                      <span className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold border ${
                        r.status === 'completed' ? 'bg-green-100 text-green-700 border-green-200' :
                        r.status === 'cancelled' ? 'bg-red-100 text-red-700 border-red-200' :
                        'bg-blue-100 text-blue-700 border-blue-200'
                      }`}>
                        {r.status === 'completed' ? <CheckCircle className="w-3 h-3 mr-1" /> : <Clock className="w-3 h-3 mr-1" />}
                        <span className="capitalize">{r.status}</span>
                      </span>
                    </td>
                    <td className="px-6 py-4 text-sm text-slate-600">
                      {new Date(r.created_at).toLocaleString()}
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
