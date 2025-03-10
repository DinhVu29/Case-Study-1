#Thêm cột năm vào các bảng
ALTER TABLE `2020`
ADD Year year

UPDATE `2020`
SET Year = '2020'

ALTER TABLE `2021`
ADD Year year

UPDATE `2021`
SET Year = '2021'

ALTER TABLE `2022`
ADD Year year

UPDATE `2022`
SET Year = '2022'

#Đối chiếu số liệu các năm với nhau (tên nước các năm có sự khác nhau)

#Năm 2020 và 2021
WITH year_2020 AS (
SELECT `2020`.Country AS Country_2020, `2021`.Country AS Country_2021
FROM `2021`
LEFT JOIN `2020`
USING(Country)), year_2021 AS(
SELECT `2020`.Country AS Country_2020, `2021`.Country AS Country_2021
FROM `2020`
LEFT JOIN `2021`
USING(Country))
SELECT * FROM year_2020
UNION ALL
SELECT * FROM year_2021
#Mục đích là để sang python tìm giá trị null và tìm hiểu tại sao có giá trị này

#Xuất file csv của kết quả truy vấn vừa rồi để import vào google.collab

=> Kết quả của 2 truy vấn này có những giá trị null do số nước trong báo cáo năm 2020
nhiều hơn 2021 và có 1 TH tên nước năm 2020 là Macedonia nhưng năm 2021 là 
North Macedonia

#Update lại tên nước năm 2021 giống 2020
UPDATE `2021`
SET Country = 'Macedonia'
Where Country = 'North Macedonia'

#Năm 2020 và 2022
WITH year_2020 AS(
SELECT `2020`.Country AS Country_2020, `2022`.Country AS Country_2022
FROM `2022`
LEFT JOIN `2020`
USING(Country)), year_2022 AS(
SELECT `2020`.Country AS Country_2020, `2022`.Country AS Country_2022
FROM `2020`
LEFT JOIN `2022`
USING(Country))
SELECT * FROM year_2020
UNION ALL
SELECT * FROM year_2022

=> Làm tương tự như năm 2020 và 2021, dựa trên output ở python ta thấy được nguyên nhân
có các giá trị null là do một số nước ở năm 2022 có thêm dấu *, và có 2 trường hợp tên
nước năm 2022 là Czechia và North Macedonia, năm 2020 tên của hai nước đó sẽ lần lượt
là Czech Republic và Macedonia

#Update lại tên nước năm 2022 giống 2020
UPDATE `2022`
SET Country = 'Macedonia'
Where Country = 'North Macedonia'

UPDATE `2022`
SET Country = 'Czech Republic'
Where Country = 'Czechia'

UPDATE `2022`
SET Country = 'Luxembourg'
Where Country = 'Luxembourg**'

UPDATE `2022`
SET Country = 'Guatemala'
Where Country = 'Guatemala*'

UPDATE `2022`
SET Country = 'Kuwait'
Where Country = 'Kuwait*'

UPDATE `2022`
SET Country = 'Belarus'
Where Country = 'Belarus*'

UPDATE `2022`
SET Country = 'Turkmenistan'
Where Country = 'Turkmenistan*'

UPDATE `2022`
SET Country = 'North Cyprus'
Where Country = 'North Cyprus*'

UPDATE `2022`
SET Country = 'Libya'
Where Country = 'Libya*'

UPDATE `2022`
SET Country = 'Azerbaijan'
Where Country = 'Azerbaijan*'

UPDATE `2022`
SET Country = 'Gambia'
Where Country = 'Gambia*'

UPDATE `2022`
SET Country = 'Liberia'
Where Country = 'Liberia*'

UPDATE `2022`
SET Country = 'Niger'
Where Country = 'Niger*'

UPDATE `2022`
SET Country = 'Comoros'
Where Country = 'Comoros*'

UPDATE `2022`
SET Country = 'Palestinian Territories'
Where Country = 'Palestinian Territories*'

UPDATE `2022`
SET Country = 'Eswatini, Kingdom of'
Where Country = 'Eswatini, Kingdom of*'

UPDATE `2022`
SET Country = 'Madagascar'
Where Country = 'Madagascar*'

UPDATE `2022`
SET Country = 'Chad'
Where Country = 'Chad*'

UPDATE `2022`
SET Country = 'Yemen'
Where Country = 'Yemen*'

UPDATE `2022`
SET Country = 'Mauritania'
Where Country = 'Mauritania*'

UPDATE `2022`
SET Country = 'Lesotho'
Where Country = 'Lesotho*'

UPDATE `2022`
SET Country = 'Botswana'
Where Country = 'Botswana*'

UPDATE `2022`
SET Country = 'Rwanda'
Where Country = 'Rwanda*'

#Thêm cột Region vào các năm thiếu
SELECT `2022`.Country, `2020`.Region, `2022`.`Happiness Rank`, `2022`.`Happiness Score`,
`2022`.`Economy (GDP per Capita)`, `2022`.`Social Support`, 
`2022`.`Health (Life Expectancy)`, `2022`.Freedom, `2022`.`Trust (Government Corruption)`,
`2022`.Generosity, `2022`.`Dystopia Residual`, `2022`.`Year`
FROM `2022`
LEFT JOIN `2020`
USING(Country)

Xếp rank cho những năm còn thiếu

# Năm 2020
SELECT Country, Region, ROW_NUMBER() OVER (
PARTITION BY Year ORDER BY `Happiness Score` DESC) AS `Happiness Rank`, 
`Happiness Score`, `Economy (GDP per Capita)`, `Social Support`, 
`Health (Life Expectancy)`, Freedom, `Trust (Government Corruption)`,
Generosity, `Dystopia Residual`, `Year`   
FROM `2020`

#Năm 2021
SELECT Country, Region, ROW_NUMBER() OVER (
PARTITION BY Year ORDER BY `Happiness Score` DESC) AS `Happiness Rank`, 
`Happiness Score`, `Economy (GDP per Capita)`, `Social Support`, 
`Health (Life Expectancy)`, Freedom, `Trust (Government Corruption)`,
Generosity, `Dystopia Residual`, `Year`   
FROM `2021`

#Gộp các bảng của mỗi năm lại
SELECT Country, Region, ROW_NUMBER() OVER (
PARTITION BY Year ORDER BY `Happiness Score` DESC) AS `Happiness Rank`, 
`Happiness Score`, `Economy (GDP per Capita)`, `Social Support`, 
`Health (Life Expectancy)`, Freedom, `Trust (Government Corruption)`,
Generosity, `Dystopia Residual`, `Year`   
FROM `2020`
UNION ALL 
SELECT Country, Region, ROW_NUMBER() OVER (
PARTITION BY Year ORDER BY `Happiness Score` DESC) AS `Happiness Rank`, 
`Happiness Score`, `Economy (GDP per Capita)`, `Social Support`, 
`Health (Life Expectancy)`, Freedom, `Trust (Government Corruption)`,
Generosity, `Dystopia Residual`, `Year`   
FROM `2021`
UNION ALL
SELECT `2022`.Country, `2020`.Region, `2022`.`Happiness Rank`, `2022`.`Happiness Score`,
`2022`.`Economy (GDP per Capita)`, `2022`.`Social Support`, 
`2022`.`Health (Life Expectancy)`, `2022`.Freedom, `2022`.`Trust (Government Corruption)`,
`2022`.Generosity, `2022`.`Dystopia Residual`, `2022`.`Year`
FROM `2022`
LEFT JOIN `2020`
USING(Country)


