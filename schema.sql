/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
	id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR NOT NULL,
	date_of_birth DATE NOT NULL,
	escape_attempts INT NOT NULL,
	neutered BOOLEAN NOT NULL,
	weight_kg DECIMAL NOT NULL,
	PRIMARY KEY(id)
);

ALTER TABLE animals ADD species varchar;
ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species (species_id);

ALTER TABLE animals ADD owners_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owners_id) REFERENCES owners (owners_id);


CREATE TABLE owners(
	owners_id INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR NOT NULL,
	age INT NOT NULL,
	PRIMARY KEY(owners_id)
);

CREATE TABLE species(
	species_id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR NOT NULL,
	PRIMARY KEY(species_id)
);

CREATE TABLE vets(
	vet_id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR NOT NULL,
	age INT NOT NULL,
	date_of_graduation DATE NOT NULL,
	PRIMARY KEY(vet_id)
);

CREATE TABLE specializations(
	species_id INT REFERENCES species (species_id),
	vet_id INT REFERENCES vets (vet_id)
);

CREATE TABLE visits(
	animal_id INT REFERENCES animals (id),
	vet_id INT REFERENCES vets (vet_id),
	date_of_visits DATE
);