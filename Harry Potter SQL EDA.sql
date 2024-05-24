# Load harrypotter data for convenience
USE harrypotter;

# Update names and data types of columns for consistency across schema
ALTER TABLE harrypotter.character
CHANGE `index` `character_id` INT,
CHANGE `name` `character_name` VARCHAR(75),
CHANGE `house` `character_house` VARCHAR(15),
CHANGE `gender` `gender` VARCHAR(25),
CHANGE `blood_status` `blood_status` VARCHAR(250);

ALTER TABLE harrypotter.potions_data
CHANGE `index` `potion_id` INT,
CHANGE `name` `potion_name` VARCHAR(75),
CHANGE `effect` `potion_effect` VARCHAR(100);

ALTER TABLE harrypotter.spells_data
CHANGE `index` `spell_id` INT,
CHANGE `name` `spell_name` VARCHAR(75),
CHANGE `effect` `spell_effect` VARCHAR(200);


### Update Primary Keys for all tables
ALTER TABLE harrypotter.character
ADD PRIMARY KEY (character_id);

ALTER TABLE spells_data
ADD PRIMARY KEY (spell_id);

ALTER TABLE potions_data
ADD PRIMARY KEY (potion_id);


#EDA - Blood-status House Concentration
# Looks at blood status as a percentage of all known house members
SELECT a.house, a.blood_status, a.house_blood_status_count, b.total_students, round(house_blood_status_count/total_students *100,2) as `percent of house`
FROM (
    SELECT house, blood_status, COUNT(*) as house_blood_status_count
    FROM harrypotter.character
    GROUP BY house, blood_status
) a
JOIN (
    SELECT house, COUNT(*) as total_students
    FROM harrypotter.character
    GROUP BY house
) b ON a.house = b.house;


# Looks at blood status as a percentage of all known house members WITH a known blood status
SELECT a.house, a.blood_status, a.house_blood_status_count, b.total_students, round(house_blood_status_count/total_students *100,2) as `percent of house`
FROM (
    SELECT house, blood_status, COUNT(*) as house_blood_status_count
    FROM harrypotter.character
    WHERE blood_status IS NOT null
    GROUP BY house, blood_status
) a
JOIN (
    SELECT house, COUNT(*) as total_students
    FROM harrypotter.character
    WHERE blood_status IS NOT null
    GROUP BY house
) b ON a.house = b.house;


# Looks at muggle-born blood status as a percentage of all known house members WITH a known blood status
SELECT a.house, a.blood_status, a.house_blood_status_count, b.total_students, round(house_blood_status_count/total_students *100,2) as `percent of house`
FROM (
    SELECT house, blood_status, COUNT(*) as house_blood_status_count
    FROM harrypotter.character
    WHERE blood_status = 'Muggle-born'
    GROUP BY house, blood_status
) a
JOIN (
    SELECT house, COUNT(*) as total_students
    FROM harrypotter.character
    WHERE blood_status IS NOT null
    GROUP BY house
) b ON a.house = b.house;

# Looks at Mixed-blood blood status as a percentage of all known house members WITH a known blood status
# It needs to be remembered that Mixed-blood includes both those who are confirmed to have mixed blood as well as those who are NOT confirmed to have pure blood.
SELECT a.house, a.blood_status, a.house_blood_status_count, b.total_students, round(house_blood_status_count/total_students *100,2) as `percent of house`
FROM (
    SELECT house, blood_status, COUNT(*) as house_blood_status_count
    FROM harrypotter.character
    WHERE blood_status = 'Mixed-blood'
    GROUP BY house, blood_status
) a
JOIN (
    SELECT house, COUNT(*) as total_students
    FROM harrypotter.character
    WHERE blood_status IS NOT null
    GROUP BY house
) b ON a.house = b.house;

# Looks at half-blood status as a percentage of all known house members WITH a known blood status
SELECT a.house, a.blood_status, a.house_blood_status_count, b.total_students, round(house_blood_status_count/total_students *100,2) as `percent of house`
FROM (
    SELECT house, blood_status, COUNT(*) as house_blood_status_count
    FROM harrypotter.character
    WHERE blood_status = 'Half-blood'
    GROUP BY house, blood_status
) a
JOIN (
    SELECT house, COUNT(*) as total_students
    FROM harrypotter.character
    WHERE blood_status IS NOT null
    GROUP BY house
) b ON a.house = b.house;


# Looks at half-blood status as a percentage of all known house members WITH a known blood status
SELECT a.house, a.blood_status, a.house_blood_status_count, b.total_students, round(house_blood_status_count/total_students *100,2) as `percent of house`
FROM (
    SELECT house, blood_status, COUNT(*) as house_blood_status_count
    FROM harrypotter.character
    WHERE blood_status = 'Pure-blood'
    GROUP BY house, blood_status
) a
JOIN (
    SELECT house, COUNT(*) as total_students
    FROM harrypotter.character
    WHERE blood_status IS NOT null
    GROUP BY house
) b ON a.house = b.house;


