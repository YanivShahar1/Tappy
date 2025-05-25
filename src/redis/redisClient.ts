import Redis from 'ioredis';
import config from '../config/redis';

const redisClient = new Redis({
  host: config.host,
  port: config.port,
  password: config.password,
});

redisClient.on('connect', () => {
  console.log('Connected to Redis');
});

redisClient.on('error', (err) => {
  console.error('Redis error:', err);
});

export default redisClient;
