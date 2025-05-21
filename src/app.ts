import express from 'express';
import http from 'http';
import { Server } from 'socket.io';
import dotenv from 'dotenv';
import cors from 'cors';
import { createClient } from 'redis';
import pg from 'pg';

dotenv.config();

const app = express();
const server = http.createServer(app);
const io = new Server(server, { cors: { origin: '*' } });

app.use(cors());
app.use(express.json());

// Redis Connection
export const redisClient = createClient({ url: process.env.REDIS_URL });
redisClient.connect().catch(console.error);

// PostgreSQL Connection
export const pgPool = new pg.Pool({ connectionString: process.env.POSTGRES_URL });

io.on('connection', (socket) => {
  console.log(`🔌 New client connected: ${socket.id}`);
});

const PORT = process.env.PORT || 4000;
server.listen(PORT, () => console.log(`Server running on port ${PORT}`));
