// Supabase Configuration
// Replace these with your actual Supabase credentials

const SUPABASE_CONFIG = {
    // Get these from your Supabase project settings
    url: 'YOUR_SUPABASE_URL_HERE', // e.g., https://your-project-id.supabase.co
    anonKey: 'YOUR_SUPABASE_ANON_KEY_HERE', // e.g., eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
    
    // Authorized email addresses
    authorizedEmails: ['rupesh.agrawal@gmail.com', 'smita.vishwa@gmail.com']
};

// How to get these values:
// 1. Go to your Supabase dashboard
// 2. Click Settings (gear icon)
// 3. Click API
// 4. Copy the Project URL and anon public key
// 5. Replace the values above

export default SUPABASE_CONFIG;
