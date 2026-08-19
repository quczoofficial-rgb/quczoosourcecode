const path = require("path");
const dotenv = require("dotenv");
const { createClient } = require("@supabase/supabase-js");

// Load backend/.env
dotenv.config({
  path: path.resolve(__dirname, "../../.env"),
});

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseSecretKey = process.env.SUPABASE_SECRET_KEY;

if (!supabaseUrl || !supabaseSecretKey) {
  throw new Error("Supabase environment variables are missing");
}

const supabase = createClient(
  supabaseUrl,
  supabaseSecretKey,
  {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
      detectSessionInUrl: false,
    },
  }
);

module.exports = supabase;