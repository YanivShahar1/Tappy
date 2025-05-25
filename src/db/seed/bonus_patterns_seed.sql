-- seed.sql

-- Clean existing patterns (optional if you want to reset)
DELETE FROM bonus_patterns;

-- Insert bonus patterns
INSERT INTO bonus_patterns (pattern_name, description, points)
VALUES
('Row', 'A full horizontal line of active cells', 10),
('Column', 'A full vertical line of active cells', 10),
('Diagonal', 'A diagonal line of active cells', 15),
('Square', 'A 2x2 block of active cells', 20),
('Circle', 'A circular shape of active cells', 25),
('Triangle', 'A triangle shape of active cells', 25);

-- Verify insert
SELECT * FROM bonus_patterns;
