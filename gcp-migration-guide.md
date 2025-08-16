# GCP Migration Guide

## Why This Path is Perfect for GCP Migration

### **Technology Alignment**
- ✅ **PostgreSQL**: Supabase uses PostgreSQL, GCP has Cloud SQL PostgreSQL
- ✅ **Node.js**: Both support Node.js applications
- ✅ **REST APIs**: Same API patterns work on both
- ✅ **Authentication**: Google OAuth works seamlessly on GCP

### **Data Migration Path**
```
Supabase PostgreSQL → Cloud SQL PostgreSQL
Supabase Auth → Firebase Auth (or keep Google OAuth)
Supabase Storage → Cloud Storage
Supabase Edge Functions → Cloud Run
```

## Phase 1: GCP Setup (When Ready to Migrate)

### **Step 1: Create GCP Project**
```bash
# Install Google Cloud CLI
curl https://sdk.cloud.google.com | bash
gcloud init
gcloud auth login
```

### **Step 2: Enable Required APIs**
```bash
gcloud services enable \
  cloudbuild.googleapis.com \
  run.googleapis.com \
  sqladmin.googleapis.com \
  storage.googleapis.com \
  firebase.googleapis.com
```

### **Step 3: Create Cloud SQL Database**
```bash
# Create PostgreSQL instance
gcloud sql instances create school-organizer-db \
  --database-version=POSTGRES_14 \
  --tier=db-f1-micro \
  --region=us-central1 \
  --root-password=YOUR_PASSWORD

# Create database
gcloud sql databases create school_organizer \
  --instance=school-organizer-db
```

### **Step 4: Deploy Backend to Cloud Run**
```bash
# Create Dockerfile
cat > Dockerfile << EOF
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8080
CMD ["npm", "start"]
EOF

# Deploy to Cloud Run
gcloud run deploy school-organizer-api \
  --source . \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

## Phase 2: Data Migration

### **Step 1: Export from Supabase**
```sql
-- Export data from Supabase
pg_dump $SUPABASE_DB_URL > supabase_backup.sql
```

### **Step 2: Import to Cloud SQL**
```bash
# Import to GCP
gcloud sql import sql school-organizer-db \
  gs://your-bucket/supabase_backup.sql \
  --database=school_organizer
```

### **Step 3: Update Connection Strings**
```javascript
// Old Supabase connection
const supabase = createClient(url, key)

// New GCP connection
const { Pool } = require('pg')
const pool = new Pool({
  host: '/cloudsql/PROJECT_ID:REGION:INSTANCE_NAME',
  database: 'school_organizer',
  user: 'postgres',
  password: process.env.DB_PASSWORD
})
```

## Phase 3: Frontend Migration

### **Option A: Keep GitHub Pages (Free)**
- ✅ **No changes needed**
- ✅ **Still free**
- ✅ **Just update API endpoints**

### **Option B: Move to Cloud Run (Pay per use)**
```bash
# Deploy static site to Cloud Run
gcloud run deploy school-organizer-frontend \
  --source . \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

## Cost Comparison

### **Current (Zero Cost)**
- GitHub Pages: $0/month
- Supabase: $0/month
- **Total: $0/month**

### **GCP Migration (Pay per use)**
- Cloud SQL: ~$7/month (db-f1-micro)
- Cloud Run: ~$5/month (low traffic)
- Cloud Storage: ~$1/month
- **Total: ~$13/month**

### **GCP Production (Scaling)**
- Cloud SQL: ~$25/month (db-g1-small)
- Cloud Run: ~$20/month (medium traffic)
- Cloud Storage: ~$5/month
- **Total: ~$50/month**

## Migration Checklist

### **Pre-Migration**
- [ ] Backup all Supabase data
- [ ] Test GCP setup locally
- [ ] Update environment variables
- [ ] Test authentication flow

### **Migration Day**
- [ ] Deploy GCP backend
- [ ] Migrate database
- [ ] Update frontend API endpoints
- [ ] Test all functionality
- [ ] Update DNS if using custom domain

### **Post-Migration**
- [ ] Monitor performance
- [ ] Set up alerts
- [ ] Configure backups
- [ ] Document new setup

## Benefits of This Migration Path

### **Immediate Benefits**
- ✅ **Zero cost to start**
- ✅ **No vendor lock-in**
- ✅ **Easy to test and develop**

### **Future Benefits**
- ✅ **Seamless GCP migration**
- ✅ **Enterprise-grade security**
- ✅ **Global scalability**
- ✅ **Advanced analytics**
- ✅ **AI/ML integration**

## Timeline Recommendation

### **Month 1-6: Zero-Cost Phase**
- Use GitHub Pages + Supabase
- Build user base
- Validate product-market fit

### **Month 7-12: Migration Phase**
- Set up GCP infrastructure
- Migrate data gradually
- Test thoroughly

### **Month 13+: GCP Production**
- Full GCP deployment
- Advanced features
- Enterprise scaling
