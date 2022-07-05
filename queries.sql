/*Queries that provide answers to the questions from all projects.*/

/* Find all animals whose name ends in "mon". */
Select * FROM animals Where name LIKE '%mon%';

/* List the name of all animals born between 2016 and 2019. */
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/* List the name of all animals that are neutered and have less than 3 escape attempts. */
SELECT * FROM animals WHERE neutered = 't' AND escape_attempts < '3';

/* List the date of birth of all animals named either "Agumon" or "Pikachu". */
SELECT name, date_of_birth FROM animals WHERE name LIKE '%Agumon%' OR name LIKE '%Pikachu%';

/* List name and escape attempts of animals that weigh more than 10.5kg */
SELECT name, escape_attempts FROM animals WHERE weight_kg > '10.5';

/* Find all animals that are neutered */
SELECT * FROM animals WHERE neutered = 't';

/* Find all animals not named Gabumon. */
SELECT * FROM animals WHERE name NOT LIKE '%Gabumon%';

/* Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg) */
SELECT * FROM animals WHERE weight_kg >= '10.4' AND weight_kg <= '17.3';

/* species to unspecified and rolling back*/
BEGIN;
UPDATE animals set species = 'unspecified';
ROLLBACK;

/* Update animals table column species in transaction and cpmmit */
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemom' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;

/* Delete all records in transaction and rollback */
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;

/* Final transaction */
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SAVEPOINT_NAME;

UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT_NAME;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0
COMMIT;


/*How many animals exist*/
SELECT COUNT(*) as count_animals FROM animals;

/*How many animals have never tried to escape*/
SELECT COUNT(*) as count_animals FROM animals WHERE escape_attempts = '0';

/*Average weight of all animals*/
SELECT AVG(weight_kg) FROM animals;

/* Which escapes most between neutered and non neutered animals */
SELECT neutered, SUM(escape_attempts) AS TOTAL_ESCAPE FROM animals GROUP BY neutered;

/* Minimum and maximum weight of each time of animal*/
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

/*Average escape attempts*/
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth < '2000-12-31' GROUP BY species;