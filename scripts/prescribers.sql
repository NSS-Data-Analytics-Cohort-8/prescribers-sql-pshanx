--REFERENCE

SELECT *
FROM prescription
WHERE drug_name = 'ESBRIET';




-- 1. 
--     a. Which prescriber had the highest total number of claims (totaled over all drugs)? Report the npi and the total number of claims.

SELECT npi,
	total_claim_count
FROM prescription
ORDER BY total_claim_count DESC
LIMIT 10;



--     b. Repeat the above, but this time report the nppes_provider_first_name, nppes_provider_last_org_name,  specialty_description, and the total number of claims.

SELECT nppes_provider_last_org_name,
	nppes_provider_first_name,
	specialty_description,
	total_claim_count
FROM prescriber as scrib
	INNER JOIN prescription as scrip
		ON scrib.npi = scrip.npi
ORDER BY total_claim_count DESC
LIMIT 10;



-- 2. 
--     a. Which specialty had the most total number of claims (totaled over all drugs)?

SELECT specialty_description,
	COUNT(total_claim_count)
FROM prescription
	INNER JOIN prescriber
		ON prescription.npi = prescriber.npi
GROUP by specialty_description
ORDER BY COUNT(total_claim_count) DESC;



--     b. Which specialty had the most total number of claims for opioids?

SELECT 
	specialty_description,
	COUNT(total_claim_count)
FROM prescription as scrip
	INNER JOIN prescriber as scrib
	ON scrip.npi = scrib.npi
WHERE drug_name IN 
		(SELECT drug_name 
		 FROM drug 
		 WHERE opioid_drug_flag ='Y')
GROUP BY specialty_description
ORDER BY COUNT(total_claim_count) DESC;
		 
	


--     c. **Challenge Question:** Are there any specialties that appear in the prescriber table that have no associated prescriptions in the prescription table?

SELECT 
	specialty_description,
	COUNT(drug_name)
FROM prescriber as scrib
	LEFT JOIN prescription as scrip
	ON scrip.npi = scrib.npi
GROUP BY specialty_description
ORDER BY count(drug_name) ASC;



--     d. **Difficult Bonus:** *Do not attempt until you have solved all other problems!* For each specialty, report the percentage of total claims by that specialty which are for opioids. Which specialties have a high percentage of opioids?

-- 3. 
--     a. Which drug (generic_name) had the highest total drug cost?

SELECT 
	generic_name,
	total_drug_cost
FROM prescription as p 
	LEFT JOIN drug as d
	ON d.drug_name = p.drug_name
ORDER BY total_drug_cost DESC
LIMIT 1;



--     b. Which drug (generic_name) has the hightest total cost per day? **Bonus: Round your cost per day column to 2 decimal places. Google ROUND to see how this works.**

SELECT

-- 4. 
--     a. For each drug in the drug table, return the drug name and then a column named 'drug_type' which says 'opioid' for drugs which have opioid_drug_flag = 'Y', says 'antibiotic' for those drugs which have antibiotic_drug_flag = 'Y', and says 'neither' for all other drugs.

--     b. Building off of the query you wrote for part a, determine whether more was spent (total_drug_cost) on opioids or on antibiotics. Hint: Format the total costs as MONEY for easier comparision.

-- 5. 
--     a. How many CBSAs are in Tennessee? **Warning:** The cbsa table contains information for all states, not just Tennessee.

--     b. Which cbsa has the largest combined population? Which has the smallest? Report the CBSA name and total population.

--     c. What is the largest (in terms of population) county which is not included in a CBSA? Report the county name and population.

-- 6. 
--     a. Find all rows in the prescription table where total_claims is at least 3000. Report the drug_name and the total_claim_count.

--     b. For each instance that you found in part a, add a column that indicates whether the drug is an opioid.

--     c. Add another column to you answer from the previous part which gives the prescriber first and last name associated with each row.

-- 7. The goal of this exercise is to generate a full list of all pain management specialists in Nashville and the number of claims they had for each opioid. **Hint:** The results from all 3 parts will have 637 rows.

--     a. First, create a list of all npi/drug_name combinations for pain management specialists (specialty_description = 'Pain Managment') in the city of Nashville (nppes_provider_city = 'NASHVILLE'), where the drug is an opioid (opiod_drug_flag = 'Y'). **Warning:** Double-check your query before running it. You will only need to use the prescriber and drug tables since you don't need the claims numbers yet.

--     b. Next, report the number of claims per drug per prescriber. Be sure to include all combinations, whether or not the prescriber had any claims. You should report the npi, the drug name, and the number of claims (total_claim_count).
    
--     c. Finally, if you have not done so already, fill in any missing values for total_claim_count with 0. Hint - Google the COALESCE function.