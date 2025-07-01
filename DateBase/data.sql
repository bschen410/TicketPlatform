DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS users;

-- 建立使用者 users 資料表
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,                              
    username VARCHAR(50) UNIQUE NOT NULL,               -- 使用者名稱 UNIQUE -> 不重複
    password TEXT NOT NULL,                             -- 密碼
    id_number VARCHAR(50) UNIQUE NOT NULL,              -- 身分證
    email VARCHAR(100) UNIQUE NOT NULL,                 -- email
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP      -- 註冊時間
);


-- 建立演唱會 events 資料表
CREATE TABLE IF NOT EXISTS events (
    id SERIAL PRIMARY KEY,                              
    name TEXT NOT NULL,
    location TEXT NOT NULL,
    date DATE,
    time TIME,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 建立 tickets 表格
CREATE TABLE IF NOT EXISTS tickets (
    id SERIAL PRIMARY KEY,    
    event_id INT NOT NULL,    
    ticket_type VARCHAR(50) NOT NULL,  
    price INT NOT NULL,     
    total_quantity INT NOT NULL, 
    remaining_quantity INT NOT NULL,  
    FOREIGN KEY (event_id) REFERENCES events(id)  -- 關聯到 events 表
);


-- 測試 users
INSERT INTO users (username, password, id_number, email) VALUES
('alice', '1234', 'F795070020', 'alice@mail.com'),
('bob', '5678', 'V939300621', 'bob@mail.com');

-- 測試 events
INSERT INTO events (name, location, date, time, description)
VALUES ('五月天演唱會', '台北小巨蛋', '2025-12-01', '19:30', '亞洲巡演台北站');

-- 測試 tickets
-- 對第 1 場活動（五月天演唱會）新增兩種票
INSERT INTO tickets (event_id, ticket_type, price, total_quantity, remaining_quantity) VALUES
(1, 'VIP', 3600, 500, 500),
(1, '一般票', 1800, 2000, 2000);

SELECT * FROM users;
SELECT * FROM events;
SELECT e.name AS event_name, t.ticket_type, t.price, t.remaining_quantity
FROM tickets t
JOIN events e ON t.event_id = e.id;