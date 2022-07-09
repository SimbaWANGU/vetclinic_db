/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES  ('Agumon', '2020-02-03', '0', True, '10.23');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES  ('Gabumon', '2018-10-15', '2', True, '8.00');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES  ('Pikachu', '2021-01-07', '1', False, '15.04');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES  ('Devimon', '2017-05-12', '5', True, '11.00');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES  ('Charmander', '2020-02-08', '0', False, '-11.00');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES  ('Plantmon', '1021-11-15', '2', True, '-5.7');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES  ('Squirtle', '1993-04-02', '3', False, '-12.13');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES  ('Angemon', '2005-06-12', '1', True, '-45');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES  ('Boarmon', '2005-06-07', '7', True, '20.40');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES  ('Blossom', '1998-10-13', '3', True, '17.00');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES  ('Ditto', '2022-05-14', '4', True, '22.00');

/* Populate owners table */
INSERT INTO owners (full_name, age)
  VALUES  ('Sam Smith', '34');

INSERT INTO owners (full_name, age)
  VALUES  ('Jennifer Orwell', '19');

INSERT INTO owners (full_name, age)
  VALUES  ('Bob', '45');

INSERT INTO owners (full_name, age)
  VALUES  ('Melody Pond', '77');

INSERT INTO owners (full_name, age)
  VALUES  ('Dean Winchester', '14');

INSERT INTO owners (full_name, age)
  VALUES  ('Jodie Whittaker', '38');


/* Populate species table */
INSERT INTO species (name)
  VALUES  ('Pokemon');

INSERT INTO species (name)
  VALUES  ('Digimon');

/* Add species to animals table */
UPDATE animals SET species_id = (SELECT species_id FROM species WHERE name LIKE '%Digimon%') WHERE name LIKE '%mon';

UPDATE animals SET species_id = (SELECT species_id FROM species WHERE name LIKE '%Pokemon%') WHERE name NOT LIKE '%mon';

/* Add ownsers to animals table*/
UPDATE animals SET owners_id = (SELECT owners_id FROM owners WHERE full_name LIKE '%Smith%') WHERE name LIKE '%Agumon%';

UPDATE animals SET owners_id = (SELECT owners_id FROM owners WHERE full_name LIKE '%Jennifer Orwell%') WHERE name LIKE '%Gabumon%' OR name LIKE '%Pikachu%';

UPDATE animals SET owners_id = (SELECT owners_id FROM owners WHERE full_name LIKE '%Bob%') WHERE name LIKE '%Devimon%' OR name LIKE '%Plantmon%';

UPDATE animals SET owners_id = (SELECT owners_id FROM owners WHERE full_name LIKE '%Melody Pond%') WHERE name LIKE '%Charmander%' OR name LIKE '%Squirtle%' OR name LIKE '%Blossom%';

UPDATE animals SET owners_id = (SELECT owners_id FROM owners WHERE full_name LIKE '%Dean Winchester%') WHERE name LIKE '%Angemon%' OR name LIKE '%Boarmon%';

/**/