CREATE DATABASE dorayaki_factory;


-- tabel resep,bahan baku, request dari toko, dan log request dari toko.
-- tabel resep
CREATE TABLE recipe(
    id_recipe INT NOT NULL AUTO_INCREMENT,
    recipe_name TEXT NOT NULL,
    recipe_desc TEXT,
    PRIMARY KEY ( id_recipe )
);

INSERT INTO recipe(recipe_name, recipe_desc)
VALUES ("Apple", "Steve Jobs's secret recipe.");

INSERT INTO recipe(recipe_name, recipe_desc)
VALUES ("Generic", "They say the best dorayaki is without any flavoring at all.");

-- tabel bahan baku
CREATE TABLE material(
    id_material INT NOT NULL AUTO_INCREMENT,
    material_name TEXT NOT NULL,
    material_stock INT NOT NULL,
    PRIMARY KEY ( id_material )
);

INSERT INTO material(material_name, material_stock)
VALUES ("Flour", 1000);

INSERT INTO material(material_name, material_stock)
VALUES ("Apple", 20);

-- tabel resep-bahan baku
CREATE TABLE recipe_material(
    id_recipe INT NOT NULL,
    id_material INT NOT NULL,
    amount INT NOT NULL,
    PRIMARY KEY ( id_recipe, id_material ),
    FOREIGN KEY (id_recipe) REFERENCES recipe(id_recipe),
    FOREIGN KEY (id_material) REFERENCES material(id_material)
);

INSERT INTO recipe_material(id_recipe, id_material, amount)
VALUES (1, 1, 50);

INSERT INTO recipe_material(id_recipe, id_material, amount)
VALUES (1, 2, 1);

INSERT INTO recipe_material(id_recipe, id_material, amount)
VALUES (2, 1, 1000);

-- tabel request
CREATE TABLE request(
    id_request INT NOT NULL AUTO_INCREMENT,
    ip_store TEXT NOT NULL,
    status_request TEXT NOT NULL,
    id_recipe INT NOT NULL,
    count_request INT NOT NULL,
    PRIMARY KEY ( id_request ),
    FOREIGN KEY (id_recipe) REFERENCES recipe(id_recipe)
);

-- tabel log request
CREATE TABLE log_request(
    id_log_request INT NOT NULL AUTO_INCREMENT,
    ip_store TEXT NOT NULL,
    endpoint_request TEXT NOT NULL,
    time_request TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ( id_log_request )
);

INSERT INTO log_request(ip_store, endpoint_request)
VALUES ("1.2.3.4.5", "somewhere");

-- tabel user
CREATE TABLE user(
    id_user INT NOT NULL AUTO_INCREMENT,
    email TEXT NOT NULL,
    username TEXT NOT NULL,
    password TEXT NOT NULL,
    PRIMARY KEY ( id_user )
);

INSERT INTO user(email,username, password)
VALUES ("pisangjerukanjing@gmail.com","pisangjerukanjing","$2b$10$K1/CWIK.BOGRGP6MlSlz7.qWuFP/7m/1fjoPRp28EwrZnWVHXO1de");

ALTER TABLE request ADD created_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

CREATE USER 'dorayaki_admin'@'localhost' IDENTIFIED BY 'dorayaki';
GRANT ALL PRIVILEGES ON dorayaki_factory. * TO 'dorayaki_admin'@'localhost';



sudo /etc/init.d/mysql start
mysql -u dorayaki_admin -p dorayaki_factory
mysqldump -u dorayaki_admin –p dorayaki dorayaki_factory > db/dorayaki_factory.sql
sudo mysqldump dorayaki_factory > db/dorayaki_factory.sql