# Real-Time Communication Patterns Skill

**Skill Type:** Technical Architecture  
**Purpose:** Design and implement real-time communication features including chat, notifications, and live updates

## Overview

This skill covers patterns for building real-time features in web applications using WebSockets, Server-Sent Events (SSE), and Supabase Realtime. It provides frameworks for implementing chat systems, live notifications, real-time dashboards, and collaborative features.

## When to Use This Skill

- ✅ Implementing chat or messaging systems
- ✅ Building real-time notifications
- ✅ Creating live dashboards with auto-updating data
- ✅ Implementing collaborative features (multiple users editing simultaneously)
- ✅ Designing presence indicators (who's online)
- ✅ Building live activity feeds

## Core Principles

### 1. Push Over Poll
Use real-time push (WebSocket) rather than polling when immediate updates are needed.

### 2. Scale Considerations
Real-time connections are persistent. Plan for connection management and scaling.

### 3. Graceful Degradation
Fall back to polling if WebSocket unavailable (corporate firewalls, old browsers).

### 4. Message Ordering
Ensure messages arrive in order, especially for chat.

### 5. Connection Recovery
Handle disconnections gracefully. Reconnect automatically and sync missed messages.

---

## Real-Time Technologies Comparison

### WebSocket (Full Duplex)

**How It Works:**
- Persistent bidirectional connection
- Server can push messages to client anytime
- Client can send messages to server anytime

**Pros:**
- ✅ True bidirectional communication
- ✅ Low latency
- ✅ Efficient (single connection, minimal overhead)

**Cons:**
- ⚠️ More complex to implement
- ⚠️ Requires WebSocket support (not all proxies/firewalls allow)
- ⚠️ Stateful (harder to scale)

**Use Cases:**
- Chat applications
- Collaborative editing
- Real-time gaming
- Live dashboards

---

### Server-Sent Events (SSE) (Server to Client Only)

**How It Works:**
- Server pushes messages to client
- Client uses standard HTTP GET request
- One-way: Server → Client

**Pros:**
- ✅ Simple to implement
- ✅ Works with standard HTTP (firewall-friendly)
- ✅ Automatic reconnection

**Cons:**
- ⚠️ One-way only (client can't send via same connection)
- ⚠️ Limited browser support (no IE)
- ⚠️ HTTP/1.1 connection limit (6 per domain)

**Use Cases:**
- Live notifications
- Real-time dashboards (read-only)
- News feeds, stock tickers

---

### Polling (Short/Long Polling)

**Short Polling:**
- Client requests updates every X seconds
- Server responds immediately

**Long Polling:**
- Client requests updates
- Server holds connection until data available or timeout
- Client immediately requests again

**Pros:**
- ✅ Simple to implement
- ✅ Works everywhere (HTTP)

**Cons:**
- ⚠️ High latency (short polling)
- ⚠️ Inefficient (constant requests)
- ⚠️ Scalability issues

**Use Cases:**
- Fallback when WebSocket/SSE unavailable
- Low-frequency updates

---

### Supabase Realtime (Recommended for IIHF Portal)

**How It Works:**
- Database-driven real-time updates
- Listen to table changes (INSERT, UPDATE, DELETE)
- Uses PostgreSQL's built-in pub/sub (LISTEN/NOTIFY)
- WebSocket connection under the hood

**Pros:**
- ✅ No custom WebSocket server needed
- ✅ Integrates with existing database
- ✅ Row Level Security applies automatically
- ✅ Easy to implement

**Cons:**
- ⚠️ Tied to Supabase
- ⚠️ Limited to database changes (not custom events)

**Use Cases:**
- Chat (messages table)
- Live notifications (listening to task updates)
- Dashboard updates (document uploads, task completions)

---

## Chat System Architecture

### Data Model

```sql
CREATE TABLE chat_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    sender_id UUID NOT NULL REFERENCES users(id),
    content TEXT NOT NULL CHECK (length(content) > 0 AND length(content) <= 5000),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    edited_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_chat_team_created ON chat_messages(team_id, created_at);
CREATE INDEX idx_chat_sender ON chat_messages(sender_id);

-- Optional: Read receipts
CREATE TABLE chat_read_receipts (
    message_id UUID REFERENCES chat_messages(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    read_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (message_id, user_id)
);
```

---

### Supabase Realtime Implementation

**Server-Side (Enable Realtime):**

```sql
-- Enable realtime for chat_messages table
ALTER PUBLICATION supabase_realtime ADD TABLE chat_messages;

-- RLS policies
CREATE POLICY chat_team_select ON chat_messages
FOR SELECT
TO authenticated
USING (
    team_id::text = auth.jwt() ->> 'team_id'
    OR auth.jwt() ->> 'role' = 'admin'
);

CREATE POLICY chat_team_insert ON chat_messages
FOR INSERT
TO authenticated
WITH CHECK (
    team_id::text = auth.jwt() ->> 'team_id'
    AND sender_id = auth.uid()
);
```

---

**Client-Side (React Example):**

```javascript
import { useState, useEffect } from 'react'
import { supabase } from './supabase'

function ChatComponent({ teamId, currentUser }) {
  const [messages, setMessages] = useState([])
  const [newMessage, setNewMessage] = useState('')

  // Load initial messages
  useEffect(() => {
    loadMessages()
    
    // Subscribe to new messages
    const subscription = supabase
      .channel(`team-${teamId}-chat`)
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'chat_messages',
          filter: `team_id=eq.${teamId}`
        },
        (payload) => {
          setMessages(prev => [...prev, payload.new])
        }
      )
      .subscribe()

    return () => {
      subscription.unsubscribe()
    }
  }, [teamId])

  async function loadMessages() {
    const { data } = await supabase
      .from('chat_messages')
      .select('*, sender:users(id, full_name)')
      .eq('team_id', teamId)
      .is('deleted_at', null)
      .order('created_at', { ascending: true })
      .limit(100)
    
    setMessages(data || [])
  }

  async function sendMessage() {
    if (!newMessage.trim()) return

    const { error } = await supabase
      .from('chat_messages')
      .insert({
        team_id: teamId,
        sender_id: currentUser.id,
        content: newMessage.trim()
      })

    if (!error) {
      setNewMessage('')
    }
  }

  return (
    <div className="chat-container">
      <div className="messages">
        {messages.map(msg => (
          <div key={msg.id} className="message">
            <strong>{msg.sender.full_name}:</strong> {msg.content}
            <span className="timestamp">
              {new Date(msg.created_at).toLocaleTimeString()}
            </span>
          </div>
        ))}
      </div>
      
      <div className="input-area">
        <input
          value={newMessage}
          onChange={(e) => setNewMessage(e.target.value)}
          onKeyPress={(e) => e.key === 'Enter' && sendMessage()}
          placeholder="Type a message..."
        />
        <button onClick={sendMessage}>Send</button>
      </div>
    </div>
  )
}
```

---

### Backend API for Chat (Optional, if not using Supabase direct)

```python
from fastapi import WebSocket, WebSocketDisconnect
from typing import Dict, List
import json

# Connection manager
class ConnectionManager:
    def __init__(self):
        self.active_connections: Dict[str, List[WebSocket]] = {}
    
    async def connect(self, team_id: str, websocket: WebSocket):
        await websocket.accept()
        if team_id not in self.active_connections:
            self.active_connections[team_id] = []
        self.active_connections[team_id].append(websocket)
    
    def disconnect(self, team_id: str, websocket: WebSocket):
        if team_id in self.active_connections:
            self.active_connections[team_id].remove(websocket)
    
    async def broadcast(self, team_id: str, message: dict):
        if team_id in self.active_connections:
            for connection in self.active_connections[team_id]:
                await connection.send_json(message)

manager = ConnectionManager()

@app.websocket("/ws/chat/{team_id}")
async def chat_endpoint(websocket: WebSocket, team_id: str, user = Depends(get_current_user_ws)):
    # Verify user has access to team
    if user.role != "admin" and user.team_id != team_id:
        await websocket.close(code=1008)  # Policy violation
        return
    
    await manager.connect(team_id, websocket)
    
    try:
        while True:
            # Receive message from client
            data = await websocket.receive_json()
            
            # Save to database
            message = {
                "id": str(uuid.uuid4()),
                "team_id": team_id,
                "sender_id": str(user.id),
                "sender_name": user.full_name,
                "content": data["content"],
                "created_at": datetime.utcnow().isoformat()
            }
            
            supabase.table("chat_messages").insert(message).execute()
            
            # Broadcast to all connected clients in team
            await manager.broadcast(team_id, message)
            
    except WebSocketDisconnect:
        manager.disconnect(team_id, websocket)
```

---

## Real-Time Notifications

### Notification Types

**System Notifications:**
- New task assigned
- Deadline approaching (X days before)
- Task completed by team
- New document uploaded
- New information page published

**User Notifications:**
- @mention in chat
- Comment on your task
- Assigned to new task

---

### Notification Data Model

```sql
CREATE TYPE notification_type AS ENUM (
    'task_assigned',
    'task_completed',
    'deadline_reminder',
    'document_uploaded',
    'page_published',
    'chat_mention'
);

CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type notification_type NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT,
    link VARCHAR(500),  -- URL to relevant resource
    read_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_notifications_user_unread ON notifications(user_id, created_at) 
WHERE read_at IS NULL;
```

---

### Real-Time Notification Delivery

**Option 1: Supabase Realtime (Database Changes)**

```javascript
// Client subscribes to notifications
useEffect(() => {
  const subscription = supabase
    .channel(`user-${currentUser.id}-notifications`)
    .on(
      'postgres_changes',
      {
        event: 'INSERT',
        schema: 'public',
        table: 'notifications',
        filter: `user_id=eq.${currentUser.id}`
      },
      (payload) => {
        // Show toast notification
        showNotification(payload.new)
        
        // Update notification count
        setUnreadCount(prev => prev + 1)
      }
    )
    .subscribe()

  return () => subscription.unsubscribe()
}, [currentUser.id])

function showNotification(notification) {
  // Browser notification API
  if (Notification.permission === 'granted') {
    new Notification(notification.title, {
      body: notification.message,
      icon: '/notification-icon.png'
    })
  }
  
  // In-app toast
  toast.info(notification.title)
}
```

---

**Option 2: Server-Sent Events (SSE)**

```python
from fastapi import Request
from sse_starlette.sse import EventSourceResponse
import asyncio

@app.get("/notifications/stream")
async def notification_stream(request: Request, user = Depends(get_current_user)):
    async def event_generator():
        while True:
            # Check if client disconnected
            if await request.is_disconnected():
                break
            
            # Query for new notifications
            new_notifications = supabase.table("notifications") \
                .select("*") \
                .eq("user_id", str(user.id)) \
                .is_("read_at", None) \
                .order("created_at", desc=True) \
                .execute()
            
            if new_notifications.data:
                yield {
                    "event": "notification",
                    "data": json.dumps(new_notifications.data)
                }
            
            await asyncio.sleep(5)  # Check every 5 seconds
    
    return EventSourceResponse(event_generator())
```

```javascript
// Client
const eventSource = new EventSource('/notifications/stream')

eventSource.addEventListener('notification', (event) => {
  const notifications = JSON.parse(event.data)
  notifications.forEach(showNotification)
})

eventSource.onerror = () => {
  console.error('SSE connection failed')
  eventSource.close()
}
```

---

### Notification Best Practices

✅ **Batch notifications:**
Instead of "Task A assigned", "Task B assigned", "Task C assigned"
→ "3 new tasks assigned"

✅ **Rate limit:**
Don't spam users. Max 1 notification per minute per type.

✅ **User preferences:**
Allow users to mute notification types.

✅ **Mark as read API:**
```python
@app.patch("/notifications/{notification_id}/read")
async def mark_notification_read(notification_id: str, user = Depends(get_current_user)):
    supabase.table("notifications") \
        .update({"read_at": datetime.utcnow().isoformat()}) \
        .eq("id", notification_id) \
        .eq("user_id", str(user.id)) \
        .execute()
    return {"status": "marked_read"}
```

✅ **Cleanup old notifications:**
Delete read notifications after 30 days:
```sql
DELETE FROM notifications 
WHERE read_at < NOW() - INTERVAL '30 days';
```

---

## Live Dashboard Updates

### Use Case: Admin Dashboard

**Metrics to Update in Real-Time:**
- Task completion count
- Documents uploaded today
- Active users
- Upcoming deadlines

**Implementation:**

```javascript
function AdminDashboard() {
  const [stats, setStats] = useState({
    tasksCompleted: 0,
    documentsUploaded: 0,
    activeUsers: 0
  })

  useEffect(() => {
    loadStats()
    
    // Subscribe to task updates
    const taskSub = supabase
      .channel('task-updates')
      .on(
        'postgres_changes',
        { event: 'UPDATE', schema: 'public', table: 'tasks' },
        (payload) => {
          if (payload.new.status === 'completed') {
            setStats(prev => ({
              ...prev,
              tasksCompleted: prev.tasksCompleted + 1
            }))
          }
        }
      )
      .subscribe()
    
    // Subscribe to document uploads
    const docSub = supabase
      .channel('document-uploads')
      .on(
        'postgres_changes',
        { event: 'INSERT', schema: 'public', table: 'documents' },
        () => {
          setStats(prev => ({
            ...prev,
            documentsUploaded: prev.documentsUploaded + 1
          }))
        }
      )
      .subscribe()

    return () => {
      taskSub.unsubscribe()
      docSub.unsubscribe()
    }
  }, [])

  async function loadStats() {
    // Load initial counts
    const { count: completedCount } = await supabase
      .from('tasks')
      .select('*', { count: 'exact', head: true })
      .eq('status', 'completed')
    
    const { count: docCount } = await supabase
      .from('documents')
      .select('*', { count: 'exact', head: true })
      .gte('uploaded_at', new Date().toISOString().split('T')[0])
    
    setStats({
      tasksCompleted: completedCount,
      documentsUploaded: docCount,
      activeUsers: 0  // Would need presence tracking
    })
  }

  return (
    <div className="dashboard">
      <StatCard title="Tasks Completed" value={stats.tasksCompleted} />
      <StatCard title="Documents Uploaded Today" value={stats.documentsUploaded} />
      <StatCard title="Active Users" value={stats.activeUsers} />
    </div>
  )
}
```

---

## Presence (Who's Online)

### Supabase Presence

```javascript
function TeamPresence({ teamId }) {
  const [onlineUsers, setOnlineUsers] = useState([])

  useEffect(() => {
    const channel = supabase.channel(`team-${teamId}-presence`)
    
    // Track my presence
    channel
      .on('presence', { event: 'sync' }, () => {
        const state = channel.presenceState()
        const users = Object.values(state).flat()
        setOnlineUsers(users)
      })
      .subscribe(async (status) => {
        if (status === 'SUBSCRIBED') {
          await channel.track({
            user_id: currentUser.id,
            username: currentUser.full_name,
            online_at: new Date().toISOString()
          })
        }
      })

    return () => {
      channel.unsubscribe()
    }
  }, [teamId])

  return (
    <div className="presence">
      <h3>Online Now ({onlineUsers.length})</h3>
      {onlineUsers.map(user => (
        <div key={user.user_id} className="online-user">
          <span className="status-dot"></span>
          {user.username}
        </div>
      ))}
    </div>
  )
}
```

---

## Connection Management

### Reconnection Strategy

```javascript
function useRealtimeConnection(channelName) {
  const [connected, setConnected] = useState(false)
  const [reconnectAttempts, setReconnectAttempts] = useState(0)
  const maxReconnectAttempts = 5

  useEffect(() => {
    let channel

    function connect() {
      channel = supabase.channel(channelName)
        .on('system', { event: 'connected' }, () => {
          console.log('Connected to', channelName)
          setConnected(true)
          setReconnectAttempts(0)
        })
        .on('system', { event: 'disconnected' }, () => {
          console.log('Disconnected from', channelName)
          setConnected(false)
          attemptReconnect()
        })
        .subscribe()
    }

    function attemptReconnect() {
      if (reconnectAttempts < maxReconnectAttempts) {
        const delay = Math.min(1000 * Math.pow(2, reconnectAttempts), 30000)
        console.log(`Reconnecting in ${delay}ms (attempt ${reconnectAttempts + 1})`)
        
        setTimeout(() => {
          setReconnectAttempts(prev => prev + 1)
          connect()
        }, delay)
      } else {
        console.error('Max reconnection attempts reached')
        // Fall back to polling or show error to user
      }
    }

    connect()

    return () => {
      channel?.unsubscribe()
    }
  }, [channelName, reconnectAttempts])

  return connected
}
```

---

## Performance Considerations

### Scaling WebSocket Connections

**Problem:** WebSocket connections are stateful. Horizontal scaling is complex.

**Solutions:**

**1. Sticky Sessions:**
Route user to same server instance
- ✅ Simple
- ⚠️ Uneven load distribution

**2. Redis Pub/Sub:**
Share messages across server instances
```python
import redis

redis_client = redis.Redis(host='localhost', port=6379)

# Server 1: Publish message
redis_client.publish('team-sweden-chat', json.dumps(message))

# Server 2: Subscribe and forward to connected clients
pubsub = redis_client.pubsub()
pubsub.subscribe('team-sweden-chat')

for message in pubsub.listen():
    await broadcast_to_local_clients(message)
```

**3. Managed Services:**
Use Supabase Realtime (handles scaling internally)

---

### Message Rate Limiting

```python
from collections import defaultdict
from datetime import datetime, timedelta

user_message_counts = defaultdict(list)

def can_send_message(user_id: str) -> bool:
    now = datetime.utcnow()
    minute_ago = now - timedelta(minutes=1)
    
    # Remove old timestamps
    user_message_counts[user_id] = [
        ts for ts in user_message_counts[user_id] if ts > minute_ago
    ]
    
    # Check if under limit
    if len(user_message_counts[user_id]) >= 30:  # Max 30 messages per minute
        return False
    
    user_message_counts[user_id].append(now)
    return True
```

---

## For IIHF Portal Project

### Real-Time Requirements

**Phase 7: Chat System**
- Team-to-admin chat
- Real-time message delivery
- Message history
- Simple, no threading

**Recommended Stack:**
- Supabase Realtime for simplicity
- WebSocket fallback if needed
- No presence indicators required
- No typing indicators needed (MVP)

---

### Implementation Plan

```sql
-- Enable realtime on chat_messages
ALTER PUBLICATION supabase_realtime ADD TABLE chat_messages;

-- RLS policies ensure team isolation
```

```javascript
// React chat component
// Subscribe to team-specific channel
// Display messages in real-time
// Send messages via Supabase client
```

**Estimated effort:** 45 hours (Phase 7)

---

**Skill Owner:** Research Agents, Frontend Developers, Backend Architects  
**Skill Version:** 1.0  
**Last Updated:** February 12, 2026
