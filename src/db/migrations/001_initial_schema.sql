-- Drop old tables if they exist (clean reset)
DROP TABLE IF EXISTS game_history, highscores, matches, users, bonus_patterns CASCADE;
DROP TYPE IF EXISTS game_mode;

-- Create ENUM type for game modes
CREATE TYPE game_mode AS ENUM ('singleplayer', 'multiplayer');

-- USERS TABLE
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- MATCHES TABLE
CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    mode game_mode NOT NULL,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ended_at TIMESTAMP,
    num_players INTEGER NOT NULL,
    created_by INTEGER REFERENCES users(id) ON DELETE SET NULL,
    room_code VARCHAR(20)
);

-- GAME HISTORY TABLE (record per user per match)
CREATE TABLE game_history (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    match_id INTEGER REFERENCES matches(id) ON DELETE CASCADE,
    score INTEGER NOT NULL,
    played_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- HIGHSCORES TABLE
CREATE TABLE highscores (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    score INTEGER NOT NULL,
    mode game_mode NOT NULL,
    achieved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- -- BONUS PATTERNS TABLE (static reference data, optional)
-- CREATE TABLE bonus_patterns (
--     id SERIAL PRIMARY KEY,
--     pattern_name VARCHAR(50) UNIQUE NOT NULL,
--     description TEXT
-- );
