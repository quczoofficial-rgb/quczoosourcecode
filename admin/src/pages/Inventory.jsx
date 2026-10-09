import { useState, useEffect } from 'react';
import api from '../api';
import { AlertTriangle, Package, TrendingDown } from 'lucide-react';

export default function Inventory() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  const fetchInventory = () => {
    setLoading(true);
    setError(null);
    api.get('/admin/inventory')
      .then((res) => {
        setData(res.data.data || []);
      })
      .catch((err) => {
        setError(err.response?.data?.message || err.message || 'Unable to load inventory');
      })
      .finally(() => {
        setLoading(false);
      });
  };

  useEffect(() => {
    fetchInventory();
  }, []);

  const lowStockCount = data.filter(i => i.stock < 10).length;

  return (
    <div className="animate-in fade-in duration-300">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between mb-8">
        <div>
          <h1 className="text-2xl font-bold text-navy-900">Inventory Management</h1>
          <p className="text-slate-500 mt-1">Monitor product stock levels across all shops</p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
        <div className="bg-white rounded-2xl shadow-sm border border-slate-200 p-6 flex items-center">
          <div className="p-4 bg-brand-100 text-brand-600 rounded-xl mr-5">
            <Package className="w-8 h-8" />
          </div>
          <div>
            <p className="text-sm font-semibold text-slate-500 mb-1">Total Tracked Items</p>
            <h3 className="text-3xl font-bold text-navy-900">{loading ? '-' : data.length}</h3>
          </div>
        </div>
        <div className="bg-white rounded-2xl shadow-sm border border-red-100 p-6 flex items-center relative overflow-hidden">
          <div className="absolute top-0 right-0 w-32 h-32 bg-red-50 rounded-full -mr-16 -mt-16 pointer-events-none"></div>
          <div className="p-4 bg-red-100 text-red-600 rounded-xl mr-5 z-10">
            <AlertTriangle className="w-8 h-8" />
          </div>
          <div className="z-10">
            <p className="text-sm font-semibold text-slate-500 mb-1">Low Stock Alerts</p>
            <h3 className="text-3xl font-bold text-red-600">{loading ? '-' : lowStockCount}</h3>
          </div>
        </div>
      </div>

      <div className="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
        <div className="px-6 py-5 border-b border-slate-100 bg-slate-50/50">
          <h3 className="font-bold text-navy-900">Stock Levels</h3>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead className="bg-slate-50 border-b border-slate-200">
              <tr>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Product Name</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Available Stock</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Reserved Stock</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Status</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {loading ? (
                Array(5).fill(0).map((_, i) => (
                  <tr key={i}>
                    <td className="px-6 py-4"><div className="h-6 w-48 shimmer rounded"></div></td>
                    <td className="px-6 py-4"><div className="h-6 w-16 shimmer rounded"></div></td>
                    <td className="px-6 py-4"><div className="h-6 w-16 shimmer rounded"></div></td>
                    <td className="px-6 py-4"><div className="h-6 w-20 shimmer rounded-full"></div></td>
                  </tr>
                ))
              ) : error ? (
                <tr>
                  <td colSpan="4" className="px-6 py-16 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-12 h-12 bg-red-100 text-red-500 rounded-full flex items-center justify-center mb-3">
                        <span className="text-xl font-bold">!</span>
                      </div>
                      <p className="text-navy-900 font-semibold mb-1">Unable to load inventory</p>
                      <p className="text-slate-500 text-sm mb-4">{error}</p>
                      <button 
                        onClick={fetchInventory}
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
                      <Package className="w-12 h-12 text-slate-300 mb-3" />
                      <p className="text-navy-900 font-semibold">No inventory found</p>
                    </div>
                  </td>
                </tr>
              ) : data.map((item) => (
                  <tr key={item.id} className="hover:bg-slate-50/80 transition-colors">
                    <td className="px-6 py-4">
                      <div className="font-semibold text-navy-900">{item.name}</div>
                      <div className="text-xs text-slate-400 mt-1">ID: {item.id}</div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="font-bold text-lg text-slate-700">{item.stock}</div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="font-medium text-slate-500">{item.reserved_stock || 0}</div>
                    </td>
                    <td className="px-6 py-4">
                      {item.stock < 10 ? (
                        <span className="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold bg-red-100 text-red-700 border border-red-200">
                          <TrendingDown className="w-3.5 h-3.5 mr-1" /> Low Stock
                        </span>
                      ) : (
                        <span className="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold bg-green-100 text-green-700 border border-green-200">
                          In Stock
                        </span>
                      )}
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
