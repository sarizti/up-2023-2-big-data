import sqlite3
con = sqlite3.connect("clase1.db")

cur = con.cursor()

articles_table = """
CREATE TABLE articles (
    id CHAR(32) PRIMARY KEY,
    title VARCHAR(255),
    sku VARCHAR(255),
    price DOUBLE,
    stock INT,
    created_at DATE,
    pic VARCHAR(128),
    manufacturer_id CHAR(32),
    relevance DOUBLE
)
"""

articles_categories_table = """
CREATE TABLE articles_categories (
    id CHAR(32) PRIMARY KEY,
    article_id CHAR(32),
    category_id CHAR(32)
)
"""

categories_table = """
CREATE TABLE categories (
    id CHAR(32) PRIMARY KEY,
    title VARCHAR(255),
    parent_id CHAR(32),
    icon VARCHAR(128)
)
"""

manufacturers_table = """
CREATE TABLE manufacturers (
    id CHAR(32) PRIMARY KEY,
    title VARCHAR(255),
    icon VARCHAR(128)
)
"""

# cur.execute(articles_table)

import json

# Insert Articles

articles_json = open("articles.json")
articles = json.load(articles_json)

articles_insert = """
INSERT INTO articles (id, title, sku, price, stock, created_at, pic, manufacturer_id, relevance)
VALUES(:id, :title, :sku, :price, :stock, :created_at, :pic, :manufacturer_id, :relevance)
"""
#cur.executemany(articles_insert, articles)
#con.commit()

# Insert Articles-Categories relationships

articles_categories_json = open("articles_categories.json")
articles_categories = json.load(articles_categories_json)

articles_categories_insert = """
INSERT INTO articles_categories (id, article_id, category_id)
VALUES(:id, :article_id, :category_id)
"""
cur.executemany(articles_categories_insert, articles_categories)
con.commit()

# Insert Categories

categories_json = open("categories.json")
categories = json.load(categories_json)

categories_insert = """
INSERT INTO categories (id, title, parent_id, icon)
VALUES (:id, :title, :parent_id, :icon)
"""
cur.executemany(categories_insert, categories)
con.commit()

# Insert Manufacturers

manufacturers_json = open("manufacturers.json")
manufacturers = json.load(manufacturers_json)

manufacturers_insert = """
INSERT INTO manufacturers (id, title, icon)
VALUES (:id, :title, :icon)
"""
cur.executemany(manufacturers_insert, manufacturers)
con.commit()