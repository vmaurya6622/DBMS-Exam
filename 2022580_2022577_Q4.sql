-- -X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
-- Answer to Question Number 4
-- ====================================================
-- ========= Vishal Kumar Maurya (2022580) ============
-- =========    Vipul Verma (2022577)      ============
-- ====================================================

USE MCM_Sangeet_Company;

-- (1)

SELECT * FROM MusicAlbum
WHERE genre_type = 'Audio' AND YEAR(date_of_release) IN (2020, 2021);


-- (2)

SELECT m.member_ID, m.Show_ID, m.role, GROUP_CONCAT(mm.group_id ORDER BY mm.group_id) AS group_numbers
FROM Member m
JOIN MusicGroup_Members mm ON m.member_ID = mm.member_id
GROUP BY m.member_ID
HAVING COUNT(mm.group_id) > 1;

-- (3)

SELECT m.member_ID, m.Show_ID, m.role
FROM Member m
JOIN MusicGroup_Members mm ON m.member_ID = mm.member_id
JOIN Music_Group mg ON mm.group_id = mg.group_id
WHERE mg.group_name = 'Pop Stars' -- for the pop music we used pop stars
AND m.member_ID NOT IN (
    SELECT member_id FROM MusicGroup_Members WHERE group_id != mg.group_id
);

-- (4)

SELECT c.candidate_id,c.name, c.email 
FROM Candidate c
WHERE EXISTS (
    SELECT *
    FROM MusicFile mf
    WHERE mf.candidate_id = c.candidate_id
    AND mf.file_type = 'audio'
) AND EXISTS (
    SELECT *
    FROM MusicFile mf
    WHERE mf.candidate_id = c.candidate_id
    AND mf.file_type = 'video'
);

-- (5)

select * from advertisement;

--  ___________________________________
--  grouping on the basis of total views
SELECT Media, SUM(views) AS total_views 
FROM Advertisement
GROUP BY Media
ORDER BY total_views DESC;  -- this gives the best platform for advertisement
  
SELECT    -- this gives the best company or website for advertisement
	adv.Company_id,
    adv.website_name,
    adv.Media, 
    SUM(adv.views) AS total_views
FROM 
    Advertisement AS adv
JOIN (
    SELECT 
        Media, 
        MAX(views) AS max_views
    FROM 
        Advertisement
    GROUP BY 
        Media
) AS a ON adv.Media = a.Media AND adv.views = a.max_views
GROUP BY 
    adv.Media, adv.Company_id, adv.website_name
ORDER BY 
    total_views DESC;


--  ___________________________________


--  ___________________________________
-- grouping on the basis of total likes

SELECT Media, SUM(likes) AS total_likes
FROM Advertisement
GROUP BY Media
ORDER BY total_likes DESC; -- this gives the best platform for advertisement


SELECT  -- this gives the best company or website for advertisement
	adv.Company_id,
    adv.website_name,
    adv.Media, 
    SUM(adv.likes) AS total_likes
FROM 
    Advertisement AS adv
JOIN (
    SELECT 
        Media, 
        MAX(likes) AS max_likes
    FROM 
        Advertisement
    GROUP BY 
        Media
) AS a ON adv.Media = a.Media AND adv.likes = a.max_likes
GROUP BY 
    adv.Media, adv.Company_id, adv.website_name
ORDER BY 
    total_likes DESC;

--  ___________________________________

--  ___________________________________
-- grouping on the basis of total likes and views

SELECT Media,
    SUM(views) AS total_views,
    SUM(likes) AS total_likes,
    (SUM(views) + SUM(likes)) AS combined_score
FROM Advertisement
GROUP BY Media
ORDER BY combined_score DESC;

--  ___________________________________

-- X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
-- X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
-- X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X
