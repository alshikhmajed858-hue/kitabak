PRAGMA foreign_keys=ON;
CREATE TABLE IF NOT EXISTS users(id TEXT PRIMARY KEY,name TEXT NOT NULL,email TEXT NOT NULL UNIQUE,password_hash TEXT NOT NULL,password_salt TEXT NOT NULL,created_at TEXT DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE IF NOT EXISTS sessions(token_hash TEXT PRIMARY KEY,user_id TEXT NOT NULL,expires_at TEXT NOT NULL,created_at TEXT DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE);
CREATE TABLE IF NOT EXISTS books(id TEXT PRIMARY KEY,title TEXT NOT NULL,author TEXT,language TEXT NOT NULL,price_syp INTEGER NOT NULL DEFAULT 2000,description TEXT,file_path TEXT,active INTEGER NOT NULL DEFAULT 1,created_at TEXT DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE IF NOT EXISTS orders(id TEXT PRIMARY KEY,user_id TEXT NOT NULL,book_id TEXT NOT NULL,amount_syp INTEGER NOT NULL,shamcash_tx TEXT NOT NULL,proof_path TEXT,proof_name TEXT,status TEXT NOT NULL DEFAULT 'pending',created_at TEXT DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(user_id) REFERENCES users(id),FOREIGN KEY(book_id) REFERENCES books(id));
CREATE INDEX IF NOT EXISTS idx_sessions_user ON sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);
INSERT OR IGNORE INTO books(id,title,author,language,price_syp,description) VALUES
('demo-ar','كتاب عربي تجريبي','كتابك','العربية',2000,'استبدله بكتاب تملك حق بيعه.'),
('demo-en','English Book','Licensed Author','English',2000,'Replace with licensed content.'),
('demo-fr','Livre Français','Auteur','Français',2000,'Remplacez par un contenu sous licence.');
