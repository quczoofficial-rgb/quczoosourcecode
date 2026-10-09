import { NavLink } from 'react-router-dom';
import { LayoutDashboard, Users, Store, Package, ShoppingCart, Boxes, ReceiptText, Settings, ShoppingBag } from 'lucide-react';

export default function Sidebar() {
  const links = [
    { to: '/', label: 'Dashboard', icon: LayoutDashboard },
    { to: '/customers', label: 'Customers', icon: Users },
    { to: '/shop-owners', label: 'Shop Owners', icon: Users },
    { to: '/shops', label: 'Shops', icon: Store },
    { to: '/products', label: 'Products', icon: Package },
    { to: '/reservations', label: 'Reservations', icon: ShoppingCart },
    { to: '/inventory', label: 'Inventory', icon: Boxes },
    { to: '/billing', label: 'Billing / Sales', icon: ReceiptText },
    { to: '/settings', label: 'Settings', icon: Settings },
  ];

  return (
    <aside className="w-64 bg-navy-900 text-white min-h-screen flex flex-col shadow-2xl z-20 shrink-0">
      <div className="h-20 flex items-center px-6 border-b border-white/10">
        <div className="bg-brand-500 p-2 rounded-lg mr-3">
          <ShoppingBag className="w-5 h-5 text-white" />
        </div>
        <h1 className="text-2xl font-bold tracking-tight">QUCZO</h1>
      </div>
      
      <div className="p-4 flex-1 overflow-y-auto custom-scrollbar">
        <div className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-4 px-3 mt-4">Management</div>
        <nav className="space-y-1">
          {links.map((link) => (
            <NavLink
              key={link.to}
              to={link.to}
              className={({ isActive }) => 
                `flex items-center px-3 py-2.5 rounded-lg text-sm font-medium transition-all ${
                  isActive 
                    ? 'bg-brand-600/15 text-brand-500 shadow-sm' 
                    : 'text-slate-300 hover:bg-white/5 hover:text-white'
                }`
              }
            >
              <link.icon className="w-5 h-5 mr-3" strokeWidth={2} />
              {link.label}
            </NavLink>
          ))}
        </nav>
      </div>
    </aside>
  );
}
