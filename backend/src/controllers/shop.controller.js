const supabase = require("../config/supabase");

const getNearbyShops = async (req, res) => {
	try {
		const { data, error } = await supabase
			.from("shops")
			.select("*")
			.order("created_at", { ascending: false });

		if (error) throw error;

		const shops = data.map((shop) => ({
			id: shop.id,
			name: shop.business_name || "",
			category: shop.business_category || "",
			city: shop.city || "",
			imageUrl: shop.image_url || shop.logo_url || shop.logo || null,
		}));

		return res.json({ success: true, count: shops.length, data: shops });
	} catch (error) {
		return res.status(500).json({ success: false, message: error.message });
	}
};

module.exports = { getNearbyShops };