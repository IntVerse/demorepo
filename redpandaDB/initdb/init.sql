CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE my_table (
    user_id INTEGER,
    email VARCHAR(255),
    product_url TEXT,
    price VARCHAR(100),
    timestamp TIMESTAMP,
    index INTEGER,
    topic VARCHAR(255),
    embedding VECTOR(3)
);

