-- Japanese School Organizer - Supabase Database Schema
-- Run this in Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- School events table
CREATE TABLE school_events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    category VARCHAR(50) NOT NULL,
    event_date DATE NOT NULL,
    start_time TIME,
    end_time TIME,
    content TEXT,
    location VARCHAR(255),
    tags TEXT[],
    action_required BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Action items table
CREATE TABLE action_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    task VARCHAR(500) NOT NULL,
    due_date DATE NOT NULL,
    completed BOOLEAN DEFAULT FALSE,
    child_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Academic records table
CREATE TABLE academic_records (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    subject VARCHAR(100) NOT NULL,
    grade VARCHAR(10) NOT NULL,
    record_date DATE NOT NULL,
    record_type VARCHAR(50),
    child_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

-- File attachments table
CREATE TABLE file_attachments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    event_id UUID REFERENCES school_events(id) ON DELETE CASCADE,
    file_name VARCHAR(255) NOT NULL,
    file_size INTEGER NOT NULL,
    file_type VARCHAR(100),
    storage_url TEXT NOT NULL,
    extracted_text TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Enable Row Level Security (RLS)
ALTER TABLE school_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE action_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE academic_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE file_attachments ENABLE ROW LEVEL SECURITY;

-- Policies for school_events
CREATE POLICY "Users can view own events" ON school_events
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own events" ON school_events
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own events" ON school_events
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own events" ON school_events
    FOR DELETE USING (auth.uid() = user_id);

-- Policies for action_items
CREATE POLICY "Users can view own action items" ON action_items
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own action items" ON action_items
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own action items" ON action_items
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own action items" ON action_items
    FOR DELETE USING (auth.uid() = user_id);

-- Policies for academic_records
CREATE POLICY "Users can view own academic records" ON academic_records
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own academic records" ON academic_records
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own academic records" ON academic_records
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own academic records" ON academic_records
    FOR DELETE USING (auth.uid() = user_id);

-- Policies for file_attachments
CREATE POLICY "Users can view own file attachments" ON file_attachments
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own file attachments" ON file_attachments
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own file attachments" ON file_attachments
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own file attachments" ON file_attachments
    FOR DELETE USING (auth.uid() = user_id);
