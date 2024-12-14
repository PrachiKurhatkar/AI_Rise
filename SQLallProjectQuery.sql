---------------------------- Question With Query Answer --------------

                               ---------------------------- Easy Level----------------------

   -------- 1) Find all industries with adoption rates greater than 0.75 -------

   SELECT industry_name, adoption_rate 
   FROM Industry 
   WHERE adoption_rate > 0.75;


   -------- 2 )Find top 10 companys with highest AI Investment in desc order -----

                      SELECT TOP 10 COMPANY_NAME, AI_INVESTMENT FROM COMPANY 
                      ORDER BY AI_INVESTMENT DESC ;


  ------ 3) Get all companys that have made an Ai_investment greter than 10 million(10,000,000) in desc order----

     SELECT COMPANY_NAME, AI_INVESTMENT
     FROM COMPANY WHERE AI_INVESTMENT >10000000 ORDER BY AI_INVESTMENT DESC ;
 

   ------- 4) List all companies and their associated industries (Tables: Company, Industry) ------
            
	SELECT c.company_name, i.industry_name 
    FROM Company c
    INNER JOIN Industry i ON c.industry_id = i.industry_id;

-------- 5) Retrieve all training programs by a specific company (Table: AI_Training_Programs) -----

	   SELECT program_name 
       FROM AI_Training_Programs 
       WHERE company_id = 3; 

---------------------------------- Medium Level Query --------------------------------

 -------  6) Count the total number of companies in each industry (Tables: Company, Industry) -------

  SELECT i.industry_name, COUNT(c.company_id) AS Total_Companies 
  FROM Industry i
  LEFT JOIN Company c ON i.industry_id = c.industry_id
  GROUP BY i.industry_name;

------- 7) Find the average AI investment by industry (Table: Industry)------------

        SELECT industry_name, AVG(ai_investment) AS Avg_Investment 
        FROM Industry 
       GROUP BY industry_name;

------- 8) List training programs and the technologies they focus on (Tables: AI_Training_Programs, AI_Technologies) -------
     
	   SELECT t.program_name, tech.technology_name 
      FROM AI_Training_Programs t
      INNER JOIN AI_Technologies tech ON t.technology_focus = tech.technology_name;

------- 9)List patents related to technologies used in specific training programs (Tables: AI_Patents, AI_Training_Programs)--------

        SELECT p.patent_name, t.program_name 
        FROM AI_Patents p
        INNER JOIN AI_Training_Programs t ON p.technology_area = t.technology_focus ;

-------- 10) Find the number of patents filed per company (Tables: AI_Patents, Company) --------

        SELECT c.company_name, COUNT(p.patent_id) AS Total_Patents 
        FROM Company c
        LEFT JOIN AI_Patents p ON c.company_id = p.company_id
        GROUP BY c.company_name;

-------------------------------------------- Advance Level Query -----------------------------------------

 -------------- 11) Find the companies that have the highest AI investment in their respective industries: --------------

       
	   SELECT i.industry_name, c.company_name, c.ai_investment 
 FROM Company c
INNER JOIN Industry i ON c.industry_id = i.industry_id
WHERE c.ai_investment = (
    SELECT MAX(c2.ai_investment)
    FROM Company c2
    WHERE c2.industry_id = c.industry_id
)
 order ai_investment desc ;


 SELECT i.industry_name, c.company_name, c.ai_investment
FROM Company c
INNER JOIN Industry i ON c.industry_id = i.industry_id
WHERE c.ai_investment = (
    SELECT MAX(c2.ai_investment)
    FROM Company c2
    WHERE c2.industry_id = c.industry_id
)
ORDER BY c.ai_investment DESC;


12) Find the Top 5 companys by AI Investment in Real Estate industry-------------

                          SELECT TOP 5
                                co.company_name, 
                                ind.industry_name, 
                                co.ai_investment      
                         FROM 
                               Company as co
                         JOIN 
                              Industry AS ind ON co.industry_id = ind.industry_id
                         WHERE 
                              ind.industry_name = 'Real Estate' 
                         ORDER BY 
                                 co.ai_investment DESC

-------- 12) Find the Top 3 Companies with the Most Patents Related to AI Technologies ---------

SELECT 
    c.company_name, 
    COUNT(p.patent_id) AS Total_Patents
FROM 
    Company c
INNER JOIN 
    AI_Patent p ON c.company_id = p.company_id
GROUP BY 
    c.company_name
ORDER BY 
    Total_Patents DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

------------ 13) Count the number of company in each industry with a minimum AI investment >= 50,000 -------

                   SELECT 
                      ind.industry_name, 
                      COUNT(co.company_id) AS company_count
                   FROM 
                      Company AS co
                   JOIN 
                       Industry AS ind                                                                                                                                                                                                                            ON co.industry_id = ind.industry_id
                   WHERE 
                       co.ai_investment >= 500000 
                   GROUP BY 
                        ind.industry_name
                   ORDER BY 
                        company_count DESC;

--------- 14) Calculate the Average Duration of Training Programs by Region  -----------
 
         SELECT 
    a.technology_name, 
    COUNT(DISTINCT c.company_id) AS Total_Companies
FROM 
    AI_Technologies a
INNER JOIN 
    Company c ON c.ai_use_case = a.tech_id
GROUP BY 
    a.technology_name
ORDER BY 
    Total_Companies DESC;

--------------- 15) Find the Top 3 Companies with the Most Patents Related to AI Technologies ---------

SELECT c.company_name, i.industry_name, c.ai_investment
FROM Company c
INNER JOIN Industry i ON c.industry_id = i.industry_id
WHERE c.ai_investment > (
    SELECT AVG(c2.ai_investment)
    FROM Company c2
    WHERE c2.industry_id = c.industry_id
)
ORDER BY c.ai_investment DESC;
