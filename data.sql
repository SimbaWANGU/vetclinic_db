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

/* Add vet data */
INSERT INTO vets (name, age, date_of_graduation)
  VALUES  ('William Tatcher', '45', '2000-04-23');

INSERT INTO vets (name, age, date_of_graduation)
  VALUES  ('Maisy Smith', '26', '2019-01-17');

INSERT INTO vets (name, age, date_of_graduation)
  VALUES  ('Stephanie Mendez', '64', '1981-05-04');

INSERT INTO vets (name, age, date_of_graduation)
  VALUES  ('Jack Harkness', '38', '2008-06-08');

/* Add specialities*/
INSERT INTO specializations (vet_id, species_id)
  VALUES  ((SELECT vet_id FROM vets WHERE name LIKE '%William%'), (SELECT species_id FROM species WHERE name LIKE '%Pokemon%'));

INSERT INTO specializations (vet_id, species_id)
  VALUES  ((SELECT vet_id FROM vets WHERE name LIKE '%Stephanie%'), (SELECT species_id FROM species WHERE name LIKE '%Digimon%'));

INSERT INTO specializations (vet_id, species_id)
  VALUES  ((SELECT vet_id FROM vets WHERE name LIKE '%Stephanie%'), (SELECT species_id FROM species WHERE name LIKE '%Pokemon%'));

INSERT INTO specializations (vet_id, species_id)
  VALUES  ((SELECT vet_id FROM vets WHERE name LIKE '%Harkness%'), (SELECT species_id FROM species WHERE name LIKE '%Digimon%'));


/* Insert visits data*/
INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Agumon%'), (SELECT vet_id FROM vets WHERE name LIKE '%William%'), '2020-05-24');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Agumon%'), (SELECT vet_id FROM vets WHERE name LIKE '%Stephanie%'), '2020-07-22');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Gabumon%'), (SELECT vet_id FROM vets WHERE name LIKE '%Jack%'), '2021-02-02');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Pikachu%'), (SELECT vet_id FROM vets WHERE name LIKE '%Smith%'), '2020-01-05');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Pikachu%'), (SELECT vet_id FROM vets WHERE name LIKE '%Smith%'), '2020-03-08');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Pikachu%'), (SELECT vet_id FROM vets WHERE name LIKE '%Smith%'), '2020-05-14');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Devimon%'), (SELECT vet_id FROM vets WHERE name LIKE '%Stephanie%'), '2021-05-04');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Charmander%'), (SELECT vet_id FROM vets WHERE name LIKE '%Jack%'), '2021-02-24');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Plantmon%'), (SELECT vet_id FROM vets WHERE name LIKE '%Smith%'), '2019-12-21');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Plantmon%'), (SELECT vet_id FROM vets WHERE name LIKE '%William%'), '2020-08-10');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Plantmon%'), (SELECT vet_id FROM vets WHERE name LIKE '%Smith%'), '2021-04-07');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Squirtle%'), (SELECT vet_id FROM vets WHERE name LIKE '%Stephanie%'), '2019-09-29');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Angemon%'), (SELECT vet_id FROM vets WHERE name LIKE '%Jack%'), '2020-10-03');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Angemon%'), (SELECT vet_id FROM vets WHERE name LIKE '%Jack%'), '2020-11-04');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Boarmon%'), (SELECT vet_id FROM vets WHERE name LIKE '%Smith%'), '2019-01-24');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Boarmon%'), (SELECT vet_id FROM vets WHERE name LIKE '%Smith%'), '2019-05-15');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Boarmon%'), (SELECT vet_id FROM vets WHERE name LIKE '%Smith%'), '2020-02-27');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Boarmon%'), (SELECT vet_id FROM vets WHERE name LIKE '%Smith%'), '2020-08-03');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Blossom%'), (SELECT vet_id FROM vets WHERE name LIKE '%Stephanie%'), '2020-05-24');

INSERT INTO visits (animal_id, vet_id, date_of_visits)
  VALUES  ((SELECT id FROM animals WHERE name LIKE '%Blossom%'), (SELECT vet_id FROM vets WHERE name LIKE '%William%'), '2021-01-11');