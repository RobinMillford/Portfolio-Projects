use portfolioprojects;
select * from cleaned_iot_telemetry_data;

-- the average temperature recorded for each device.
select device, AVG(temp) as average_temperature
from cleaned_iot_telemetry_data
group by device;

-- the top 5 devices with the highest average carbon monoxide levels:
select device,avg(co) as average_carbon_monoxide
from cleaned_iot_telemetry_data
group by device
order by average_carbon_monoxide desc
limit 5;

-- the average temperature recorded
select avg(temp) as average_temperature
from cleaned_iot_telemetry_data;

-- the timestamp and temperature of the highest recorded temperature for each device
-- select device,date,time,temp
-- from cleaned_iot_telemetry_data
-- where (device,temp) in (
-- select device,max(temp) as max_temp
-- from cleaned_iot_telemetry_data
-- group by device);
-- coming lost connection error

select c.date, c.time, c.device, temp
from cleaned_iot_telemetry_data c
join(
select device,max(temp) as max_temp
from cleaned_iot_telemetry_data
group by device
) t on c.device = t.device and c.temp = t.max_temp;

--  devices where the temperature has increased from the minimum recorded temperature to the maximum recorded temperature
select device
from cleaned_iot_telemetry_data
group by device
having min(temp) < max(temp);

-- the exponential moving average (EMA) of the temperature for each device and retrieve the device ID, timestamp, temperature, and EMA temperature for the first 10 devices from the table
-- select date,time,device,temp,avg(temp)
-- over (partition by device 
-- order by date 
-- rows between unbounded preceding and current row) as ema_temperature
-- from cleaned_iot_telemetry_data
-- where device in ( select distinct device
-- from cleaned_iot_telemetry_data limit 10);

select date,time,device,temp,ema_temperature
from(select c.date,c.time,c.device,c.temp,
avg(c.temp) over (partition by c.device order by c.date
rows between unbounded preceding and current row) as ema_temperature,
row_number() over (partition by c.device order by c.date) as rn
from cleaned_iot_telemetry_data c )
subquery
where rn<=10;

-- the timestamps and devices where the carbon monoxide level exceeds the average carbon monoxide level across all devices
select date,time,device
from cleaned_iot_telemetry_data
where co > ( select avg(co) from cleaned_iot_telemetry_data);

-- the highest average temperature recorded
select device, avg(temp) as average_temperature
from cleaned_iot_telemetry_data
group by device
having avg(temp) = (
select max(avg_temp)
from(
select avg(temp) as avg_temp
from cleaned_iot_telemetry_data
group by device
) as temp_avg 
);

-- the average temperature for each hour of the day across all devices
select hour(time) as hour_of_day, avg(temp) as average_temperature
from cleaned_iot_telemetry_data
group by hour_of_day
order by hour_of_day;

--  a single distinct temperature value
select device
from cleaned_iot_telemetry_data
group by device
having count(distinct temp) = 1 and count(*) = 1;

-- the devices with the highest humidity levels
select device, max(humidity) as highest_humidity
from cleaned_iot_telemetry_data
group by device;

-- the average temperature for each device, excluding outliers (temperatures beyond 3 standard deviations)
select device, avg(temp) as average_temperature
from (
select device,temp,
stddev(temp) over (partition by device) as stddev,
avg(temp) over (partition by device) as avg_temp
from cleaned_iot_telemetry_data
) subquery
where temp between (avg_temp -3*stddev) and (avg_temp +3* stddev)
group by device;

-- the devices that have experienced a sudden change in humidity (greater than 50% difference) within a 30-minute window based on the given column names
SELECT DISTINCT main.device
FROM cleaned_iot_telemetry_data AS main
JOIN (
    SELECT device, CONCAT(date, ' ', time) AS datetime, 
           LAG(CONCAT(date, ' ', time)) OVER (PARTITION BY device ORDER BY date, time) AS prev_datetime,
           humidity
    FROM cleaned_iot_telemetry_data
) AS subquery ON main.device = subquery.device AND CONCAT(main.date, ' ', main.time) = subquery.datetime
WHERE ABS(main.humidity - subquery.humidity) > 0.5 * subquery.humidity
  AND TIMESTAMPDIFF(MINUTE, subquery.prev_datetime, subquery.datetime) <= 30;

--  the average temperature for each device during weekdays and weekends separately
select device,
case when weekday(date) < 5 then 'Weekday' else 'Weekend' end as day_type,
avg(temp) as average_temperature
from cleaned_iot_telemetry_data
group by device, day_type;

-- the cumulative sum of temperature for each device, ordered by timestamp and limited to 10 records
-- creating a temporary table
CREATE TEMPORARY TABLE temp_cumulative_temperature AS
SELECT device, CONCAT(date, ' ', time) AS Timestamp, temp,
       @sum := IF(@prev_device = device, @sum + temp, temp) AS cumulative_temperature,
       @prev_device := device
FROM cleaned_iot_telemetry_data
CROSS JOIN (SELECT @sum := 0, @prev_device := '') AS vars
ORDER BY device, CONCAT(date, ' ', time);

SELECT device, Timestamp, temp, cumulative_temperature
FROM (
  SELECT device, Timestamp, temp, cumulative_temperature,
         ROW_NUMBER() OVER (PARTITION BY device ORDER BY Timestamp) AS rn
  FROM temp_cumulative_temperature
) subquery
WHERE rn <= 10
ORDER BY device, Timestamp;