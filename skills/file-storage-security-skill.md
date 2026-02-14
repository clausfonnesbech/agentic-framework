# File Storage & Upload Security Skill

**Skill Type:** Security & Data Handling  
**Purpose:** Implement secure file upload, storage, and retrieval systems with proper validation and access control

## Overview

This skill covers secure file handling patterns including upload validation, malware scanning, cloud storage integration (Supabase Storage, Azure Blob), access control, and best practices for handling user-uploaded files safely.

## When to Use This Skill

- ✅ Implementing file upload functionality
- ✅ Integrating cloud storage services
- ✅ Securing document management systems
- ✅ Planning file access control
- ✅ Designing file storage architecture
- ✅ Implementing file download/sharing features

## Core Principles

### 1. Never Trust User Input
Validate everything: file type, size, name, content. Assume malicious intent.

### 2. Store Files Outside Web Root
Don't serve uploaded files directly. Use controlled access mechanisms.

### 3. Deny by Default
Whitelist allowed file types. Don't blacklist dangerous types (easy to bypass).

### 4. Scan for Malware
Integrate virus scanning, especially for documents users can download.

### 5. Separate Storage from Application
Use cloud storage (S3, Azure Blob, Supabase Storage) rather than local filesystem.

---

## File Upload Validation

### 1. File Type Validation

**❌ Bad: Trust client-provided MIME type**
```python
# Client can lie about content-type
file_type = request.headers.get('content-type')
```

**✅ Good: Validate by file extension AND content**

```python
import magic  # python-magic library

ALLOWED_EXTENSIONS = {
    'documents': {'.pdf', '.docx', '.xlsx', '.pptx'},
    'images': {'.jpg', '.jpeg', '.png', '.gif'},
    'archives': {'.zip', '.tar', '.gz'}
}

ALLOWED_MIME_TYPES = {
    'application/pdf',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    'image/jpeg',
    'image/png',
    'image/gif'
}

def validate_file(file):
    # 1. Check file extension
    filename = file.filename
    ext = os.path.splitext(filename)[1].lower()
    
    all_allowed_extensions = set()
    for exts in ALLOWED_EXTENSIONS.values():
        all_allowed_extensions.update(exts)
    
    if ext not in all_allowed_extensions:
        raise ValueError(f"File type {ext} not allowed")
    
    # 2. Check actual file content (magic bytes)
    mime = magic.from_buffer(file.read(2048), mime=True)
    file.seek(0)  # Reset file pointer
    
    if mime not in ALLOWED_MIME_TYPES:
        raise ValueError(f"File content type {mime} not allowed")
    
    return True
```

**Why both checks?**
- Extension: Fast, user-friendly errors
- Content: Prevents renamed malware (evil.exe → evil.pdf)

---

### 2. File Size Validation

```python
MAX_FILE_SIZE = 20 * 1024 * 1024  # 20 MB

def validate_file_size(file):
    # Get file size
    file.seek(0, os.SEEK_END)
    size = file.tell()
    file.seek(0)  # Reset to beginning
    
    if size > MAX_FILE_SIZE:
        raise ValueError(f"File too large. Max size: {MAX_FILE_SIZE / 1024 / 1024}MB")
    
    if size == 0:
        raise ValueError("File is empty")
    
    return size
```

**Set limits based on:**
- User role (admin = higher limits)
- File type (images = 5MB, documents = 20MB)
- Total storage quota per team

---

### 3. Filename Sanitization

**❌ Dangerous filenames:**
```
../../etc/passwd           # Path traversal
file<script>.pdf           # XSS in filename
file|rm -rf /.pdf          # Command injection
file name with spaces.pdf  # URL encoding issues
```

**✅ Sanitize filenames:**

```python
import re
import uuid
from pathlib import Path

def sanitize_filename(filename):
    # Get extension
    ext = Path(filename).suffix.lower()
    
    # Remove extension
    name = Path(filename).stem
    
    # Remove dangerous characters
    name = re.sub(r'[^\w\s-]', '', name)
    
    # Replace spaces with underscores
    name = re.sub(r'\s+', '_', name)
    
    # Limit length
    name = name[:100]
    
    # Add unique prefix to avoid collisions
    unique_name = f"{uuid.uuid4().hex[:8]}_{name}{ext}"
    
    return unique_name

# Example
sanitize_filename("my document (final) v2.docx")
# Returns: "a3b4c5d6_my_document_final_v2.docx"
```

**Best Practice: Store original filename separately**
```python
# Database record
{
    "id": "uuid",
    "original_filename": "Team Sweden Roster.docx",
    "stored_filename": "a3b4c5d6_team_sweden_roster.docx",
    "file_path": "teams/sweden/documents/a3b4c5d6_team_sweden_roster.docx"
}
```

---

### 4. Content Validation

**For images: Re-encode to strip metadata**

```python
from PIL import Image
from io import BytesIO

def sanitize_image(file):
    try:
        # Open image
        img = Image.open(file)
        
        # Verify it's a valid image (will raise exception if corrupted)
        img.verify()
        
        # Re-open (verify closes the file)
        file.seek(0)
        img = Image.open(file)
        
        # Re-encode to strip EXIF and malicious payloadsoutput = BytesIO()
        img.save(output, format=img.format)
        output.seek(0)
        
        return output
    except Exception as e:
        raise ValueError("Invalid or corrupted image file")
```

**For documents: Use libraries to parse and validate**

```python
from PyPDF2 import PdfReader

def validate_pdf(file):
    try:
        pdf = PdfReader(file)
        
        # Check if PDF is encrypted
        if pdf.is_encrypted:
            raise ValueError("Encrypted PDFs not allowed")
        
        # Check page count
        if len(pdf.pages) > 500:
            raise ValueError("PDF too large (max 500 pages)")
        
        # Optionally: Extract text to ensure it's readable
        text = pdf.pages[0].extract_text()
        
        return True
    except Exception as e:
        raise ValueError(f"Invalid PDF: {str(e)}")
```

---

## Cloud Storage Integration

### Supabase Storage (Recommended for IIHF Portal)

**Setup:**

```python
from supabase import create_client
import os

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")

supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

# Create storage bucket (do once)
supabase.storage.create_bucket("team-documents", {
    "public": False,  # Private bucket
    "file_size_limit": 20 * 1024 * 1024,  # 20MB
    "allowed_mime_types": [
        "application/pdf",
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        "image/jpeg",
        "image/png"
    ]
})
```

---

**Upload File:**

```python
async def upload_document(file, team_id, user_id):
    # 1. Validate file
    validate_file(file)
    file_size = validate_file_size(file)
    
    # 2. Sanitize filename
    original_filename = file.filename
    safe_filename = sanitize_filename(original_filename)
    
    # 3. Construct storage path
    file_path = f"teams/{team_id}/{safe_filename}"
    
    # 4. Upload to Supabase Storage
    file_bytes = await file.read()
    
    response = supabase.storage.from_("team-documents").upload(
        path=file_path,
        file=file_bytes,
        file_options={
            "content-type": file.content_type,
            "cache-control": "3600",
            "upsert": False  # Don't overwrite existing files
        }
    )
    
    # 5. Create database record
    document = {
        "id": str(uuid.uuid4()),
        "original_filename": original_filename,
        "stored_filename": safe_filename,
        "file_path": file_path,
        "file_size": file_size,
        "mime_type": file.content_type,
        "team_id": team_id,
        "uploaded_by": user_id,
        "uploaded_at": datetime.utcnow(),
        "storage_bucket": "team-documents"
    }
    
    supabase.table("documents").insert(document).execute()
    
    return document
```

---

**Download File (Secure):**

```python
@app.get("/documents/{document_id}")
async def download_document(document_id: str, user = Depends(get_current_user)):
    # 1. Get document record
    result = supabase.table("documents").select("*").eq("id", document_id).execute()
    document = result.data[0] if result.data else None
    
    if not document:
        raise HTTPException(404, "Document not found")
    
    # 2. Authorization check
    if user.role != "admin" and document["team_id"] != user.team_id:
        raise HTTPException(403, "Access denied")
    
    # 3. Generate signed URL (expires in 1 hour)
    signed_url = supabase.storage.from_("team-documents").create_signed_url(
        path=document["file_path"],
        expires_in=3600  # 1 hour
    )
    
    # 4. Return signed URL or redirect
    return {
        "download_url": signed_url["signedURL"],
        "filename": document["original_filename"],
        "expires_in": 3600
    }
    
    # Or redirect directly
    # return RedirectResponse(signed_url["signedURL"])
```

**Why signed URLs?**
- ✅ Temporary access (expires after X seconds)
- ✅ No need to proxy file through application
- ✅ Bandwidth handled by storage service
- ✅ Authorization checked before URL generated

---

### Azure Blob Storage (Alternative)

```python
from azure.storage.blob import BlobServiceClient, generate_blob_sas, BlobSasPermissions
from datetime import datetime, timedelta

blob_service = BlobServiceClient.from_connection_string(AZURE_CONNECTION_STRING)
container_name = "team-documents"

# Upload
def upload_to_azure(file, team_id, filename):
    blob_client = blob_service.get_blob_client(
        container=container_name,
        blob=f"teams/{team_id}/{filename}"
    )
    
    blob_client.upload_blob(
        file,
        overwrite=False,
        content_settings={
            "content_type": file.content_type
        }
    )
    
    return blob_client.url

# Download (signed URL)
def get_download_url(file_path):
    sas_token = generate_blob_sas(
        account_name=blob_service.account_name,
        container_name=container_name,
        blob_name=file_path,
        account_key=AZURE_ACCOUNT_KEY,
        permission=BlobSasPermissions(read=True),
        expiry=datetime.utcnow() + timedelta(hours=1)
    )
    
    return f"https://{blob_service.account_name}.blob.core.windows.net/{container_name}/{file_path}?{sas_token}"
```

---

## Access Control Patterns

### 1. Public vs Private Files

**Public Files** (no auth required):
- Images in CMS content
- Public information page attachments
- Marketing materials

**Private Files** (auth required):
- Team documents (rosters, medical forms)
- Task attachments
- Admin-only documents

**Implementation:**

```python
# Separate storage buckets
PUBLIC_BUCKET = "public-files"
PRIVATE_BUCKET = "team-documents"

# Public files: Generate public URL
public_url = supabase.storage.from_(PUBLIC_BUCKET).get_public_url(file_path)

# Private files: Generate signed URL with expiration
signed_url = supabase.storage.from_(PRIVATE_BUCKET).create_signed_url(
    file_path, 
    expires_in=3600
)
```

---

### 2. Team Isolation

**Folder structure:**
```
team-documents/
  teams/
    sweden/
      a3b4c5d6_roster.docx
      b7c8d9e0_roominglist.xlsx
    denmark/
      c8d9e0f1_roster.docx
  admin/
    global_document.pdf
```

**Authorization check:**

```python
def can_access_file(user, document):
    # Admin can access all
    if user.role == "admin":
        return True
    
    # Contributors can access own team's files
    if user.role == "contributor" and document["team_id"] == user.team_id:
        return True
    
    # Readers have no document access
    return False
```

---

### 3. Row Level Security (Database)

```sql
-- Enable RLS on documents table
ALTER TABLE documents ENABLE ROW LEVEL SECURITY;

-- Admin: Full access
CREATE POLICY admin_all_documents ON documents
FOR ALL
TO authenticated
USING (auth.jwt() ->> 'role' = 'admin');

-- Contributors: Own team only
CREATE POLICY contributor_team_documents ON documents
FOR SELECT
TO authenticated
USING (
    team_id::text = auth.jwt() ->> 'team_id'
    AND auth.jwt() ->> 'role' = 'contributor'
);

-- Upload: Own team only
CREATE POLICY contributor_upload ON documents
FOR INSERT
TO authenticated
WITH CHECK (
    team_id::text = auth.jwt() ->> 'team_id'
    AND auth.jwt() ->> 'role' IN ('contributor', 'admin')
);
```

**Benefits:**
- Authorization enforced at database level
- Can't bypass with application bugs
- Consistent across all queries

---

## Malware Scanning

### Integration with ClamAV (Open Source)

```python
import clamd

# Connect to ClamAV daemon
clam = clamd.ClamdUnixSocket()

async def scan_file(file):
    # Read file bytes
    file_bytes = await file.read()
    file.seek(0)  # Reset for later processing
    
    # Scan with ClamAV
    result = clam.instream(file_bytes)
    
    # Check result
    status = result['stream'][0]
    if status == 'FOUND':
        virus_name = result['stream'][1]
        raise ValueError(f"Malware detected: {virus_name}")
    
    return True

# In upload handler
async def upload_document(file, team_id, user_id):
    # 1. Validate file type and size
    validate_file(file)
    
    # 2. Scan for malware
    await scan_file(file)
    
    # 3. Continue with upload
    ...
```

**ClamAV Setup (Docker):**
```yaml
# docker-compose.yml
services:
  clamav:
    image: clamav/clamav:latest
    ports:
      - "3310:3310"
    volumes:
      - clamav-data:/var/lib/clamav
```

---

### Cloud Scanning Services

**Azure Blob Storage + Defender:**
- Automatic malware scanning
- Integrates with Azure Security Center
- Scan results written to blob metadata

**AWS S3 + GuardDuty/Macie:**
- Detects malicious file uploads
- ML-based threat detection

---

## Large File Uploads

### Chunked Upload (for files >100MB)

```python
from fastapi import UploadFile, File
import hashlib

@app.post("/documents/upload-chunk")
async def upload_chunk(
    chunk: UploadFile = File(...),
    chunk_number: int = 0,
    total_chunks: int = 1,
    file_id: str = None,
    user = Depends(get_current_user)
):
    # Create unique file ID if first chunk
    if chunk_number == 0:
        file_id = str(uuid.uuid4())
    
    # Save chunk to temporary storage
    chunk_path = f"/tmp/{file_id}_chunk_{chunk_number}"
    with open(chunk_path, "wb") as f:
        f.write(await chunk.read())
    
    # If last chunk, combine all chunks
    if chunk_number == total_chunks - 1:
        # Combine chunks
        final_path = f"/tmp/{file_id}_complete"
        with open(final_path, "wb") as final_file:
            for i in range(total_chunks):
                chunk_file = f"/tmp/{file_id}_chunk_{i}"
                with open(chunk_file, "rb") as cf:
                    final_file.write(cf.read())
                os.remove(chunk_file)  # Cleanup
        
        # Upload complete file to Supabase Storage
        with open(final_path, "rb") as f:
            await upload_to_storage(f, user.team_id, file_id)
        
        os.remove(final_path)  # Cleanup
        
        return {"status": "complete", "file_id": file_id}
    
    return {"status": "processing", "chunk": chunk_number}
```

---

### Resumable Uploads (Supabase)

```javascript
// Client-side (JavaScript)
const { data, error } = await supabase.storage
  .from('team-documents')
  .upload('path/to/file.pdf', file, {
    cacheControl: '3600',
    upsert: false,
    // Resumable upload options
    onUploadProgress: (progress) => {
      console.log(`Uploaded ${progress.loaded} of ${progress.total}`)
    }
  })
```

---

## Security Best Practices Checklist

### Upload Security

- [x] Validate file type by extension AND content (magic bytes)
- [x] Limit file size (20MB for IIHF portal)
- [x] Sanitize filenames (remove special characters, add unique prefix)
- [x] Scan for malware (ClamAV or cloud service)
- [x] Store files outside web root (use cloud storage)
- [x] Use signed URLs with expiration for downloads
- [x] Implement rate limiting on upload endpoints
- [x] Log all upload/download activities

### Storage Security

- [x] Use private storage buckets (not public)
- [x] Enable encryption at rest (Azure/Supabase default)
- [x] Enable encryption in transit (HTTPS only)
- [x] Implement access control (RLS + application-level)
- [x] Separate file storage by team/user
- [x] Set bucket-level policies

### Access Control

- [x] Verify user authentication before allowing upload/download
- [x] Check user authorization (team membership, role)
- [x] Use Row Level Security policies
- [x] Generate time-limited signed URLs
- [x] Audit file access (who downloaded what, when)

### Data Management

- [x] Store original filename separately from storage filename
- [x] Track file metadata (size, type, uploader, timestamp)
- [x] Implement file deletion (soft delete for audit)
- [x] Set retention policies (delete after event completion)
- [x] Provide user data export (GDPR compliance)

---

## For IIHF Portal Project

### File Upload Requirements

**Allowed File Types:**
- Documents: .pdf, .docx, .xlsx, .pptx
- Images: .jpg, .png (for CMS content)

**Max File Size:** 20 MB

**Storage:** Supabase Storage (private bucket per team)

**Access Control:**
- Contributors upload to own team only
- Admins access all team documents
- Readers have no document access

---

### Implementation Checklist

- [x] Create "team-documents" private bucket in Supabase
- [x] Implement file validation (type, size, content)
- [x] Sanitize filenames before storage
- [x] Integrate ClamAV for malware scanning
- [x] Store file metadata in `documents` table
- [x] Enable RLS on `documents` table
- [x] Generate signed URLs for downloads (1-hour expiration)
- [x] Rate limit upload endpoint (max 10 files per minute per user)
- [x] Log all file operations (upload, download, delete)
- [x] Implement soft delete (mark as deleted, retain for 30 days)
- [ ] Future: Integrate Azure Blob Storage as backup/archive

---

**Skill Owner:** Research Agents, Backend Developers, Security Engineers  
**Skill Version:** 1.0  
**Last Updated:** February 12, 2026
