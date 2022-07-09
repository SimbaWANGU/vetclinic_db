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

/* Belong to Melody*/
SELECT owners.full_name, animals.name FROM animals INNER JOIN owners ON animals.owners_id = owners.owners_id WHERE owners.full_name LIKE '%Melody%';

/* animals that are pokemon species */
SELECT animals.name, species.name AS species FROM animals INNER JOIN species ON animals.species_id = species.species_id WHERE species.name LIKE '%Pokemon%';

/* list all owners and their animals */
SELECT owners.full_name, animals.name AS animal_name FROM animals RIGHT JOIN owners ON animals.owners_id = owners.owners_id;

/* how many animals are there per species*/
SELECT species.name, COUNT(animals.name) FROM animals INNER JOIN species ON animals.species_id = species.species_id GROUP BY species.name;

/* Digimon owned by Jennifer */
SELECT owners.full_name, animals.name, animals.species_id FROM animals INNER JOIN owners ON owners.owners_id = animals.owners_id WHERE owners.full_name LIKE '%Jennifer%' AND animals.species_id = (SELECT species_id FROM species WHERE name LIKE '%Digimon%');

/* Owned by Dean Winchester not escaped */
SELECT owners.full_name, animals.name, animals.escape_attempts FROM animals INNER JOIN owners ON owners.owners_id = animals.owners_id WHERE owners.full_name LIKE '%Dean%' AND animals.escape_attempts = '0';

/* Who owns the most animals */
SELECT owners.full_name, COUNT(animals.name) FROM owners LEFT JOIN animals ON owners.owners_id = animals.owners_id GROUP BY owners.full_name ORDER BY COUNT(animals.name) DESC LIMIT 1;

/* Last animal seen by William */
SELECT vets.name, animals.name, visits.date_of_visits FROM vets INNER JOIN visits ON vets.vet_id = visits.vet_id INNER JOIN ANIMALS ON animals.id = visits.animal_id WHERE vets.name LIKE '%William%' ORDER BY visits.date_of_visits DESC LIMIT 1;

/* Different animals seen by Stephanie */
SELECT vets.name, COUNT(visits.animal_id) FROM vets INNER JOIN visits ON vets.vet_id = visits.vet_id WHERE vets.name LIKE '%Stephanie%' GROUP BY vets.name;

/* List all vets and their specialties, including vets with no specialties */
SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vets.vet_id = specializations.vet_id LEFT JOIN species ON specializations.species_id = species.species_id;

/* animals that visited Stephanie Mendez between April 1st and August 30th, 2020 */
SELECT vets.name, animals.name AS animal_name, visits.date_of_visits FROM vets INNER JOIN visits ON vets.vet_id = visits.vet_id INNER JOIN animals ON visits.animal_id = animals.id WHERE vets.name LIKE '%Stephanie%' AND visits.date_of_visits BETWEEN '2020-04-01' AND '2020-08-30';

/* What animal has the most visits to vets */
SELECT animals.name, COUNT(animals.id) AS visits FROM visits INNER JOIN animals ON visits.animal_id = animals.id GROUP BY animals.name ORDER BY COUNT(animals.id) DESC LIMIT 1;

/* Maisy Smith's first visit */
SELECT vets.name, visits.date_of_visits FROM vets INNER JOIN visits ON vets.vet_id = visits.vet_id WHERE vets.name LIKE '%Maisy%' ORDER BY visits.date_of_visits LIMIT 1;

/* Details for most recent visit: animal information, vet information, and date of visit */
SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, species.name AS species, vets.name AS vet, vets.age AS vet_age, vets.date_of_graduation AS vet_graduation, visits.date_of_visits FROM visits  INNER JOIN animals ON visits.animal_id = animals.id INNER JOIN species ON animals.species_id = species.species_id INNER JOIN vets ON visits.vet_id = vets.vet_id ORDER BY visits.date_of_visits DESC LIMIT 1;

/* visits were with a vet that did not specialize in that animal's species */
SELECT vets.name, COUNT(visits.animal_id) AS number_of_visits, COUNT(specializations.species_id) AS specialities FROM visits JOIN animals ON animals.id = visits.animal_id FULL JOIN specializations ON visits.vet_id = specializations.vet_id JOIN vets ON visits.vet_id = vets.vet_id GROUP BY visits.animal_id, visits.vet_id, animals.name, specializations.species_id, vets.name ORDER BY COUNT(visits.animal_id) DESC LIMIT 1;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most */
SELECT vets.name, species.name AS species, COUNT(visits.animal_id) AS visits FROM visits INNER JOIN vets ON visits.vet_id = vets.vet_id INNER JOIN animals ON visits.animal_id = animals.id INNER JOIN species ON animals.species_id = species.species_id WHERE vets.name LIKE '%Maisy%' GROUP BY vets.name, animals.species_id, species.name ORDER BY animals.species_id DESC LIMIT 1;