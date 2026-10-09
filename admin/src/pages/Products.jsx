import { useState, useEffect } from 'react';
import api from '../api';
import { Search, MoreVertical, Plus, Image as ImageIcon, Edit, Trash2, Package, XCircle } from 'lucide-react';
import { toast } from 'sonner';

export default function Products() {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [isModalOpen, setIsModalOpen] = useState(false);
  
  const [newProduct, setNewProduct] = useState({
    name: '',
    category: '',
    price: '',
    stock: '',
    description: '',
    image_url: ''
  });

  const loadProducts = () => {
    setLoading(true);
    setError(null);
    api.get('/admin/products')
      .then((res) => {
        setData(res.data.data || []);
      })
      .catch((err) => {
        setError(err.response?.data?.message || err.message || 'Unable to load products');
      })
      .finally(() => {
        setLoading(false);
      });
  };

  useEffect(() => {
    loadProducts();
  }, []);

  const handleSaveProduct = async (e) => {
    e.preventDefault();
    try {
      await api.post('/admin/products', newProduct);
      toast.success('Product created successfully');
      setIsModalOpen(false);
      setNewProduct({ name: '', category: '', price: '', stock: '', description: '', image_url: '' });
      loadProducts();
    } catch (err) {
      toast.error('Failed to create product');
    }
  };

  const handleDelete = async (id) => {
    if (confirm('Are you sure you want to delete this product?')) {
      try {
        await api.delete(`/admin/products/${id}`);
        toast.success('Product deleted');
        loadProducts();
      } catch (err) {
        toast.error('Failed to delete product');
      }
    }
  };

  return (
    <div className="animate-in fade-in duration-300">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between mb-8">
        <div>
          <h1 className="text-2xl font-bold text-navy-900">Products</h1>
          <p className="text-slate-500 mt-1">Manage your QUCZO product catalog</p>
        </div>
        <div className="mt-4 sm:mt-0 flex items-center space-x-4">
          <div className="relative hidden sm:block">
            <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" />
            <input 
              type="text" 
              placeholder="Search products..." 
              className="pl-10 pr-4 py-2 border border-slate-200 rounded-lg text-sm focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 outline-none w-64"
            />
          </div>
          <button 
            onClick={() => setIsModalOpen(true)}
            className="bg-brand-600 hover:bg-brand-700 text-white px-4 py-2.5 rounded-lg text-sm font-semibold flex items-center transition-colors shadow-sm"
          >
            <Plus className="w-4 h-4 mr-2" />
            Add Product
          </button>
        </div>
      </div>

      <div className="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead className="bg-slate-50 border-b border-slate-200">
              <tr>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Product</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Category</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Price</th>
                <th className="px-6 py-4 text-xs font-semibold text-slate-500 uppercase tracking-wider">Stock</th>
                <th className="px-6 py-4 text-right text-xs font-semibold text-slate-500 uppercase tracking-wider">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {loading ? (
                Array(5).fill(0).map((_, i) => (
                  <tr key={i}>
                    <td className="px-6 py-4"><div className="h-10 w-48 shimmer rounded"></div></td>
                    <td className="px-6 py-4"><div className="h-6 w-32 shimmer rounded"></div></td>
                    <td className="px-6 py-4"><div className="h-6 w-24 shimmer rounded"></div></td>
                    <td className="px-6 py-4"><div className="h-6 w-16 shimmer rounded-full"></div></td>
                    <td className="px-6 py-4 text-right"><div className="h-6 w-8 shimmer rounded ml-auto"></div></td>
                  </tr>
                ))
              ) : error ? (
                <tr>
                  <td colSpan="5" className="px-6 py-16 text-center">
                    <div className="flex flex-col items-center">
                      <div className="w-12 h-12 bg-red-100 text-red-500 rounded-full flex items-center justify-center mb-3">
                        <span className="text-xl font-bold">!</span>
                      </div>
                      <p className="text-navy-900 font-semibold mb-1">Unable to load products</p>
                      <p className="text-slate-500 text-sm mb-4">{error}</p>
                      <button 
                        onClick={loadProducts}
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
                      <p className="text-navy-900 font-semibold">No products found</p>
                    </div>
                  </td>
                </tr>
              ) : data.map((p) => (
                  <tr key={p.id} className="hover:bg-slate-50/80 transition-colors group">
                    <td className="px-6 py-4">
                      <div className="flex items-center">
                        <div className="h-12 w-12 rounded-lg bg-slate-100 border border-slate-200 flex items-center justify-center overflow-hidden mr-4 shrink-0">
                          {p.image_url ? (
                            <img src={p.image_url} alt={p.name} className="w-full h-full object-cover" />
                          ) : (
                            <ImageIcon className="w-5 h-5 text-slate-400" />
                          )}
                        </div>
                        <div>
                          <div className="font-bold text-navy-900 line-clamp-1">{p.name}</div>
                          <div className="text-xs text-slate-500 line-clamp-1 mt-0.5">{p.description || 'No description'}</div>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <span className="inline-flex items-center px-2.5 py-1 rounded-md text-xs font-medium bg-slate-100 text-slate-700">
                        {p.category || 'General'}
                      </span>
                    </td>
                    <td className="px-6 py-4 font-semibold text-navy-900">₹{p.price}</td>
                    <td className="px-6 py-4 text-sm">
                      <span className={`font-semibold ${p.stock < 10 ? 'text-red-600' : 'text-slate-700'}`}>
                        {p.stock} units
                      </span>
                    </td>
                    <td className="px-6 py-4 text-right">
                      <div className="flex justify-end space-x-2 opacity-0 group-hover:opacity-100 transition-opacity">
                        <button className="p-1.5 text-slate-400 hover:text-blue-600 hover:bg-blue-50 rounded"><Edit className="w-4 h-4" /></button>
                        <button onClick={() => handleDelete(p.id)} className="p-1.5 text-slate-400 hover:text-red-600 hover:bg-red-50 rounded"><Trash2 className="w-4 h-4" /></button>
                      </div>
                    </td>
                  </tr>
                ))}
            </tbody>
          </table>
        </div>
      </div>

      {isModalOpen && (
        <div className="fixed inset-0 bg-navy-900/40 backdrop-blur-sm z-50 flex items-center justify-center p-4 animate-in fade-in duration-200">
          <div className="bg-white rounded-2xl shadow-2xl w-full max-w-lg overflow-hidden border border-slate-200">
            <div className="px-6 py-4 border-b border-slate-100 flex justify-between items-center bg-slate-50/50">
              <h2 className="text-lg font-bold text-navy-900">Add New Product</h2>
              <button onClick={() => setIsModalOpen(false)} className="text-slate-400 hover:text-slate-600">
                <XCircle className="w-5 h-5" />
              </button>
            </div>
            <form onSubmit={handleSaveProduct} className="p-6 space-y-4">
              <div>
                <label className="block text-sm font-semibold text-slate-700 mb-1">Product Name</label>
                <input required type="text" value={newProduct.name} onChange={e => setNewProduct({...newProduct, name: e.target.value})} className="w-full px-3 py-2 border border-slate-200 rounded-lg focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 outline-none" placeholder="e.g. Sona Masoori Rice 5kg" />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-semibold text-slate-700 mb-1">Category</label>
                  <input required type="text" value={newProduct.category} onChange={e => setNewProduct({...newProduct, category: e.target.value})} className="w-full px-3 py-2 border border-slate-200 rounded-lg focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 outline-none" placeholder="Grocery" />
                </div>
                <div>
                  <label className="block text-sm font-semibold text-slate-700 mb-1">Price (₹)</label>
                  <input required type="number" value={newProduct.price} onChange={e => setNewProduct({...newProduct, price: e.target.value})} className="w-full px-3 py-2 border border-slate-200 rounded-lg focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 outline-none" placeholder="299" />
                </div>
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-semibold text-slate-700 mb-1">Initial Stock</label>
                  <input required type="number" value={newProduct.stock} onChange={e => setNewProduct({...newProduct, stock: e.target.value})} className="w-full px-3 py-2 border border-slate-200 rounded-lg focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 outline-none" placeholder="50" />
                </div>
                <div>
                  <label className="block text-sm font-semibold text-slate-700 mb-1">Image URL</label>
                  <input type="url" value={newProduct.image_url} onChange={e => setNewProduct({...newProduct, image_url: e.target.value})} className="w-full px-3 py-2 border border-slate-200 rounded-lg focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 outline-none" placeholder="https://..." />
                </div>
              </div>
              <div>
                <label className="block text-sm font-semibold text-slate-700 mb-1">Description</label>
                <textarea rows="3" value={newProduct.description} onChange={e => setNewProduct({...newProduct, description: e.target.value})} className="w-full px-3 py-2 border border-slate-200 rounded-lg focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 outline-none resize-none" placeholder="Enter product description..."></textarea>
              </div>
              <div className="pt-4 flex justify-end space-x-3">
                <button type="button" onClick={() => setIsModalOpen(false)} className="px-4 py-2 font-semibold text-slate-600 bg-slate-100 hover:bg-slate-200 rounded-lg transition-colors">Cancel</button>
                <button type="submit" className="px-4 py-2 font-semibold text-white bg-brand-600 hover:bg-brand-700 rounded-lg transition-colors">Save Product</button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
