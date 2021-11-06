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

-- tabel bahan baku
CREATE TABLE material(
    id_material INT NOT NULL AUTO_INCREMENT,
    material_name TEXT NOT NULL,
    material_stock INT NOT NULL,
    PRIMARY KEY ( id_material )
);

INSERT INTO material(material_name, material_stock)
VALUES ("Flour", 1000);

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

-- tabel request

-- tabel log request

CREATE USER 'dorayaki_admin'@'localhost' IDENTIFIED BY 'dorayaki';
GRANT ALL PRIVILEGES ON dorayaki_factory. * TO 'dorayaki_admin'@'localhost';


mysql -u dorayaki_admin -p dorayaki_factory
mysqldump -u dorayaki_admin –p dorayaki dorayaki_factory > db/dorayaki_factory.sql
sudo mysqldump dorayaki_factory > db/dorayaki_factory.sql