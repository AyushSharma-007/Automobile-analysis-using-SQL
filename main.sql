-- Convert all the ‘?’ values to NaN. Clean the data as per further requirement. 
UPDATE auto SET make = 'Nan',fuel-type='Nan',aspiration = 'Nan',[num-of-cylinders] = 'Nan'
[num-of-doors] = 'Nan', [body-style] = 'Nan' , [drive-wheels] = 'Nan',[engine-location] = 'Nan',[wheel-base] = 'Nan',[length] = 'Nan',width = 'Nan',height = 'Nan'
[curb-weight] = 'Nan',price = 'Nan','highway-mpg' = 'Nan',city-mpg = 'Nan',peak-rpm = 'Nan',horsepower = 'Nan',[compression-ratio] = 'Nan'
stroke = 'Nan',bore = 'Nan',[fuel-system] = 'Nan'
where [normalized-losses] = '?';

-- Which company manufactured the most expensive car and at what price?
ALTER TABLE auto ADD [price-int] INT;
UPDATE auto SET price = 0 where price = 'Nan';
SELECT CAST(price AS INT)
FROM auto;
ALTER TABLE auto DROP COLUMN price;
UPDATE auto SET [price-int] = CAST(price AS INT);
select * from auto WHERE [price-int] = (select max([price-int]) from auto);

-- Calculate the maximum horsepower for each company
SELECT make, MAX(horsepower) AS max_horsepower FROM auto GROUP BY make;

--  What is the total count of cars manufactured by each company?
select make,count(make) as countmake from auto group by make;

-- Sort the dataframe according to car and price combined.
select * from auto order by make,[price-int];

-- Create a new column which stores the number of doors in a car as integers
ALTER TABLE auto ADD [nums-of-doors-int] INT;
update  auto set [num-of-doors] = 0 where [num-of-doors] = '?';
ALTER TABLE auto ADD [num-of-doors-int] INT;
UPDATE auto SET [num-of-doors-int] = 2 where [num-of-doors]= 'two';
UPDATE auto SET [num-of-doors-int] = 4 where [num-of-doors]= 'four';

-- Based on new regulations, companies decided to change the prices of the car. 
-- The new update price is calculated as - if the engine is in front, price will be same else 
-- if the engine is in rear, price will be doubled. Add a new column with the updated prices
ALTER TABLE auto ADD [prices] INT;
UPDATE auto SET price = 0 where price = 'Nan';
SELECT CAST(price-int AS INT)
FROM auto;
UPDATE auto SET [prices] = 2*[prices-int] where [engine]  = 'rear';
