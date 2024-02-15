use education;
select * from wind_turbine;
## mean,mode,median,standard deviation,kurtosis,variance,skewness ##
#1) wind speed
select avg(wind_speed) as mean from wind_turbine;  #17.617818311874107
SELECT 
  AVG(wind_speed) as median
FROM (
  SELECT 
    wind_speed, 
    ROW_NUMBER() OVER (ORDER BY wind_speed) as row_num,
    COUNT(*) OVER () as total_rows
  FROM wind_turbine
) subquery
WHERE row_num = (total_rows + 1) / 2 
   OR row_num = (total_rows + 2) / 2;    # 16.64 

SELECT wind_speed, COUNT(wind_speed) as frequency
FROM wind_turbine
GROUP BY wind_speed
ORDER BY frequency DESC
LIMIT 1;   # mode is 3
select variance(wind_speed) from wind_turbine; #var=128.58149051920643
select stddev(wind_speed) from wind_turbine;  #stddev=11.339377871788487
SELECT
    (
        SUM(POWER(wind_speed - (SELECT AVG(wind_speed) FROM wind_turbine), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(wind_speed) FROM wind_turbine), 3))
    ) AS skewness
FROM wind_turbine;      #skewnesss=0.7128062379346347

select 
      (sum(power(wind_speed-(select avg(wind_speed) from wind_turbine),4))/
     (count(*)*power((select stddev(wind_speed) from wind_turbine),4))-3 
     )as kurtosis
	from wind_turbine;   #kurtosis=0.4470708550240001
select max(wind_speed)-min(wind_speed) from wind_turbine; #range=80.23

#2) Power
select avg(Power) as mean from wind_turbine; #mean=3.1312839771101593
SELECT 
  AVG(power) as median
FROM (
  SELECT 
    power, 
    ROW_NUMBER() OVER (ORDER BY power) as row_num,
    COUNT(*) OVER () as total_rows
  FROM wind_turbine
) subquery
WHERE row_num = (total_rows + 1) / 2 
   OR row_num = (total_rows + 2) / 2;    #median=2.79
SELECT power, COUNT(power) as frequency
FROM wind_turbine
GROUP BY power
ORDER BY frequency DESC
LIMIT 1;          #mode=3.5
select stddev(power) as standard_deviation from wind_turbine;  #stddev=1.9919936213387526
select variance(power) as variance from wind_turbine; #variance=3.9680385874542776
SELECT
    (
        SUM(POWER(power - (SELECT AVG(power) FROM wind_turbine), 3)) / 
        (COUNT(*) * POWER((SELECT STDDEV(power) FROM wind_turbine), 3))
    ) AS skewness
FROM wind_turbine;     #skewnes=2.404537662041732
select(sum(power(power-(select avg(power) from wind_turbine),4))/
(count(*) * power((select stddev(power) from wind_turbine),4))-3
) as kurtosis
from wind_turbine;   # kurtosis= 6.6330308961152245
select max(power)-min(power) from wind_turbine; #range=11.99

#3) nacelle_ambient_temperature
select * from wind_turbine;
select avg(nacelle_ambient_temperature) as mean from wind_turbine;  #mean=20.787389127324772
SELECT 
  AVG(nacelle_ambient_temperature) as median
FROM (
  SELECT 
    nacelle_ambient_temperature, 
    ROW_NUMBER() OVER (ORDER BY nacelle_ambient_temperature) as row_num,
    COUNT(*) OVER () as total_rows
  FROM wind_turbine
) subquery
WHERE row_num = (total_rows + 1) / 2 
   OR row_num = (total_rows + 2) / 2;   #median=22.8
SELECT nacelle_ambient_temperature, COUNT(power) as frequency
FROM wind_turbine
GROUP BY  nacelle_ambient_temperature
ORDER BY frequency DESC
LIMIT 1;            #mode=40
select stddev( nacelle_ambient_temperature) as standard_deviation from wind_turbine; #stddev=34.799782102551426
select variance(nacelle_ambient_temperature) as variance from wind_turbine;  #variance=1211.0248343850585
select (sum(power(nacelle_ambient_temperature-(select avg(nacelle_ambient_temperature) from wind_turbine),3))/
(count(*) * power ((select stddev(nacelle_ambient_temperature) from wind_turbine),3))
)as skewness 
from wind_turbine;   #skewness=0.6738969588067825
select (sum(power(nacelle_ambient_temperature-(select avg(nacelle_ambient_temperature) from wind_turbine),4))/
(count(*) * power((select stddev(nacelle_ambient_temperature) from wind_turbine),4))-3
)as kurtosis
from wind_turbine;   #kurtosis=7.379066672011517
select max(nacelle_ambient_temperature)-min(nacelle_ambient_temperature) from wind_turbine; #range=480.37

#4) generator_bearing_temperature
select avg(generator_bearing_temperature) as mean from wind_turbine;  #mean=84.15726394849786
SELECT 
  AVG(generator_bearing_temperature) as median
FROM (
  SELECT 
    generator_bearing_temperature, 
    ROW_NUMBER() OVER (ORDER BY generator_bearing_temperature) as row_num,
    COUNT(*) OVER () as total_rows
  FROM wind_turbine
) subquery
WHERE row_num = (total_rows + 1) / 2 
   OR row_num = (total_rows + 2) / 2;   #median=83.37
select generator_bearing_temperature,count(generator_bearing_temperature) as frequency 
from wind_turbine group by generator_bearing_temperature order by frequency desc limit 1; #mode=74.6
select stddev(generator_bearing_temperature) as standard_deviation from wind_turbine; #stdeev=22.03598415059809
select variance(generator_bearing_temperature) as variance from wind_turbine; #variace=485.58459748541026
select (sum(power(generator_bearing_temperature-(select avg(generator_bearing_temperature) from wind_turbine),3))/
(count(*) * power ((select stddev(generator_bearing_temperature) from wind_turbine),3))
)as skewness 
from wind_turbine;   #skewness=-0.1251007603241535
select (sum(power(generator_bearing_temperature-(select avg(generator_bearing_temperature) from wind_turbine),4))/
(count(*) * power((select stddev(generator_bearing_temperature) from wind_turbine),4))-3
)as kurtosis
from wind_turbine;   #kurtosis=2.4010048834088646
select max(generator_bearing_temperature)-min(generator_bearing_temperature) from wind_turbine; #range=134.79999999999998

#5) gear_oil_temperature
select avg(gear_oil_temperature) as mean from wind_turbine;  #mean=77.91566881258937
select gear_oil_temperature as median 
from (select gear_oil_temperature,row_number() over(order by gear_oil_temperature) as row_num,
count(*) over() as total_count
from wind_turbine
) as subquery
where row_num=(total_count+1)/2
or row_num=(total_count+2)/2;     #median=73.11
select gear_oil_temperature,count(*) as frequency
from wind_turbine group by gear_oil_temperature
order by frequency desc limit 1;  #mdoe= 90
select stddev(gear_oil_temperature) as standard_deviation from wind_turbine; #stddev=20.306194283258186
select variance(gear_oil_temperature) as variance from wind_turbine; #412.3415262694275
select 
(sum(power(gear_oil_temperature-(select avg(gear_oil_temperature) from wind_turbine),3))/
(count(*)* power((select stddev(gear_oil_temperature) from wind_turbine),3))
) as skewness
from wind_turbine;  #skewness= 0.9595029382917195
select
(sum(power(gear_oil_temperature-(select avg(gear_oil_temperature)from wind_turbine),4))/
(count(*) * power((select stddev(gear_oil_temperature)from wind_turbine),4))-3
)as kurtosis 
from wind_turbine;  #kurtosis=0.09299956802066678
select max(gear_oil_temperature)-min(gear_oil_temperature) from wind_turbine; #range=79.84

#6)ambient_temperature
select avg(ambient_temperature) as mean from wind_turbine;  #mean= 14.22774678111583\
select ambient_temperature as median 
from (select ambient_temperature,row_number() over(order by ambient_temperature) as row_num,
count(*) over() as total_count
from wind_turbine
) as subquery
where row_num=(total_count+1)/2
or row_num=(total_count+2)/2;  #median=10.17
select ambient_temperature,count(*) as frequency 
from wind_turbine group by ambient_temperature order by frequency desc limit 1; #mode=40
select stddev(ambient_temperature) as standard_deviation from wind_turbine; #stddev=24.1439399209967
select variance(ambient_temperature) as variance from wind_turbine; #variance=582.9298349086982
select (sum(power(ambient_temperature-(select avg(ambient_temperature) from wind_turbine),3))/
(count(*) * power ((select stddev(ambient_temperature) from wind_turbine),3))
)as skewness 
from wind_turbine;   #skewness=1.0662421369189805
select (sum(power(ambient_temperature-(select avg(ambient_temperature) from wind_turbine),4))/
(count(*) * power((select stddev(ambient_temperature) from wind_turbine),4))-3
)as kurtosis
from wind_turbine;   #kurtosis=0.8922619025937739
select max(ambient_temperature)-min(ambient_temperature) from wind_turbine; #range=104.91

#7)rotor_speed 
select avg(rotor_speed) as mean from wind_turbine;  #mean=182.90497496423447
select rotor_speed as median 
from (select rotor_speed,row_number() over(order by rotor_speed) as row_num,
count(*) over() as total_count
from wind_turbine
) as subquery
where row_num=(total_count+1)/2
or row_num=(total_count+2)/2;  #median=179.83
select rotor_speed,count(*)  as frequency from wind_turbine
group by rotor_speed order by frequency desc limit 1; #mode=300
select stddev(rotor_speed) as standard_deviation from wind_turbine; #stddev=101.35356245375203
select variance(rotor_speed) as variance from wind_turbine; #variance=10272.544622066614
select (sum(power(rotor_speed-(select avg(rotor_speed) from wind_turbine),3))/
(count(*) * power ((select stddev(rotor_speed) from wind_turbine),3))
)as skewness 
from wind_turbine;   #skewness=0.4825667570212279
select (sum(power(rotor_speed-(select avg(rotor_speed) from wind_turbine),4))/
(count(*) * power((select stddev(rotor_speed) from wind_turbine),4))-3
)as kurtosis
from wind_turbine;   #kurtosis=0.044116573499831446
select max(rotor_speed)-min(rotor_speed) from wind_turbine; #range=449.41

#8) nacelle_temperature
select avg(nacelle_temperature) as mean from wind_turbine; #mean=45.17933118741059
select nacelle_temperature as median 
from (select nacelle_temperature,row_number() over(order by nacelle_temperature) as row_num,
count(*) over() as total_count
from wind_turbine
) as subquery
where row_num=(total_count+1)/2
or row_num=(total_count+2)/2;  #median=44.97
select nacelle_temperature,count(*) as frequency from wind_turbine
group by nacelle_temperature order by frequency desc limit 1; #mode=60
select stddev(nacelle_temperature) as standard_deviation from wind_turbine; #stddev=20.0755191066038
select variance(nacelle_temperature) as variance from wind_turbine; #variance=403.02646739961415
select (sum(power(nacelle_temperature-(select avg(nacelle_temperature) from wind_turbine),3))/
(count(*) * power ((select stddev(nacelle_temperature) from wind_turbine),3))
)as skewness 
from wind_turbine;   #skewness=-0.16990960309878966
select (sum(power(nacelle_temperature-(select avg(nacelle_temperature) from wind_turbine),4))/
(count(*) * power((select stddev(nacelle_temperature) from wind_turbine),4))-3
)as kurtosis
from wind_turbine;   #kurtosis=2.2440624207237727
select max(nacelle_temperature)-min(nacelle_temperature) from wind_turbine; #range=138.6

#9)bearing_temperature 
select * from wind_turbine;
select avg(bearing_temperature) as mean from wind_turbine; #mean=81.29061874105881
select bearing_temperature as median 
from (select bearing_temperature,row_number() over(order by bearing_temperature) as row_num,
count(*) over() as total_count
from wind_turbine
) as subquery
where row_num=(total_count+1)/2
or row_num=(total_count+2)/2;  #median=70
select bearing_temperature,count(*) as frequency from wind_turbine
group by bearing_temperature order by frequency desc limit 1; #mode=70
select stddev(bearing_temperature) as standard_deviation from wind_turbine; #stddev=24.37509911523505
select variance(bearing_temperature) as variance from wind_turbine; #variance=594.1454568775325
select (sum(power(bearing_temperature-(select avg(bearing_temperature) from wind_turbine),3))/
(count(*) * power ((select stddev(bearing_temperature) from wind_turbine),3))
)as skewness 
from wind_turbine;   #skewness=0.12688819146731706
select (sum(power(bearing_temperature-(select avg(bearing_temperature) from wind_turbine),4))/
(count(*) * power((select stddev(bearing_temperature) from wind_turbine),4))-3
)as kurtosis
from wind_turbine;   #kurtosis=0.9407068229806512
select max(bearing_temperature)-min(bearing_temperature) from wind_turbine; #range=139.63

#10) generator_speed
select avg(generator_speed) as mean from wind_turbine; #mean=1418.8000035765383
select nacelle_temperature as median 
from (select nacelle_temperature,row_number() over(order by nacelle_temperature) as row_num,
count(*) over() as total_count
from wind_turbine
) as subquery
where row_num=(total_count+1)/2
or row_num=(total_count+2)/2;  #median=44.97
select generator_speed,count(*) as frequency from wind_turbine
group by generator_speed order by frequency desc limit 1; #mode=1900
select stddev(generator_speed) as standard_deviation from wind_turbine; #stddev=437.6810005683909
select variance(generator_speed) as variance from wind_turbine; #variance=191564.6582585478
select (sum(power(generator_speed-(select avg(generator_speed) from wind_turbine),3))/
(count(*) * power ((select stddev(generator_speed) from wind_turbine),3))
)as skewness 
from wind_turbine;   #skewness=0.366809417118969
select (sum(power(generator_speed-(select avg(generator_speed) from wind_turbine),4))/
(count(*) * power((select stddev(generator_speed) from wind_turbine),4))-3
)as kurtosis
from wind_turbine;   #kurtosis=1.994527459751163
select max(generator_speed)-min(generator_speed) from wind_turbine; #range=3491.13

#11) yaw angle
select avg(yaw_angle) as mean from wind_turbine; #mean=46.044002145922775
select yaw_angle as median 
from (select yaw_angle,row_number() over(order by yaw_angle) as row_num,
count(*) over() as total_count
from wind_turbine
) as subquery
where row_num=(total_count+1)/2
or row_num=(total_count+2)/2;  #median=33.49
select yaw_angle,count(*) as frequency from wind_turbine
group by yaw_angle order by frequency desc limit 1; #mode=60
select stddev(yaw_angle) as standard_deviation from wind_turbine; #stddev=43.156458704792726
select variance(yaw_angle) as variance from wind_turbine; #variance=1862.4799279384797
select (sum(power(yaw_angle-(select avg(yaw_angle) from wind_turbine),3))/
(count(*) * power ((select stddev(yaw_angle) from wind_turbine),3))
)as skewness 
from wind_turbine;   #skewness=1.3413595229340847
select (sum(power(yaw_angle-(select avg(yaw_angle) from wind_turbine),4))/
(count(*) * power((select stddev(yaw_angle)from wind_turbine),4))-3
)as kurtosis
from wind_turbine;   #kurtosis=1.1517871853623198
select max(yaw_angle)-min(yaw_angle) from wind_turbine; #range=179.84

#12)wind_direction
select avg(wind_direction) as mean from wind_turbine; #mean=55.450715307582335
select wind_direction as median 
from (select wind_direction,row_number() over(order by wind_direction) as row_num,
count(*) over() as total_count
from wind_turbine
) as subquery
where row_num=(total_count+1)/2
or row_num=(total_count+2)/2;  #median=34.78
select wind_direction,count(*) as frequency from wind_turbine
group by wind_direction order by frequency desc limit 1; #mode=11.22
select stddev(wind_direction) as standard_deviation from wind_turbine; #stddev=89.02809860763895
select variance(wind_direction) as variance from wind_turbine; #variance=7926.002341691485
select (sum(power(wind_direction-(select avg(wind_direction) from wind_turbine),3))/
(count(*) * power ((select stddev(wind_direction) from wind_turbine),3))
)as skewness 
from wind_turbine;   #skewness=1.3182049103230122
select (sum(power(wind_direction-(select avg(wind_direction) from wind_turbine),4))/
(count(*) * power((select stddev(wind_direction)from wind_turbine),4))-3
)as kurtosis
from wind_turbine;   #kurtosis=7.9506482287211995
select max(wind_direction)-min(wind_direction) from wind_turbine; #range=1166.24

#13)wheel_hub_temperature
select avg(wheel_hub_temperature) as mean from wind_turbine; #mean=20.480354077253242
select wheel_hub_temperature as median 
from (select wheel_hub_temperature,row_number() over(order by wheel_hub_temperature) as row_num,
count(*) over() as total_count
from wind_turbine
) as subquery
where row_num=(total_count+1)/2
or row_num=(total_count+2)/2;  #median=20.38
select wheel_hub_temperature,count(*) as frequency from wind_turbine
group by wheel_hub_temperature order by frequency desc limit 1; #mode=80
select stddev(wheel_hub_temperature) as standard_deviation from wind_turbine; #stddev=47.75261428607891
select variance(wheel_hub_temperature) as variance from wind_turbine; #variance=2280.3121711550275
select (sum(power(wheel_hub_temperature-(select avg(wheel_hub_temperature) from wind_turbine),3))/
(count(*) * power ((select stddev(wheel_hub_temperature) from wind_turbine),3))
)as skewness 
from wind_turbine;   #skewness=-0.08711145346689526
select (sum(power(wheel_hub_temperature-(select avg(wheel_hub_temperature) from wind_turbine),4))/
(count(*) * power((select stddev(wheel_hub_temperature)from wind_turbine),4))-3
)as kurtosis
from wind_turbine;   #kurtosis=-0.2911792171828127
select max(wheel_hub_temperature)-min(wheel_hub_temperature) from wind_turbine; #range=209.68

#14)gear_box_inlet_temperature
select avg(gear_box_inlet_temperature) as mean from wind_turbine; #mean=23.263022174535024
select gear_box_inlet_temperature as median 
from (select gear_box_inlet_temperature,row_number() over(order by gear_box_inlet_temperature) as row_num,
count(*) over() as total_count
from wind_turbine
) as subquery
where row_num=(total_count+1)/2
or row_num=(total_count+2)/2;  #median=15.9
select gear_box_inlet_temperature,count(*) as frequency from wind_turbine
group by gear_box_inlet_temperature order by frequency desc limit 1; #mode=20
select stddev(gear_box_inlet_temperature) as standard_deviation from wind_turbine; #stddev=23.54454399621054
select variance(gear_box_inlet_temperature) as variance from wind_turbine; #variance=554.3455519894937
select (sum(power(gear_box_inlet_temperature-(select avg(gear_box_inlet_temperature) from wind_turbine),3))/
(count(*) * power ((select stddev(gear_box_inlet_temperature) from wind_turbine),3))
)as skewness 
from wind_turbine;   #skewness=2.9126599504486532
select (sum(power(gear_box_inlet_temperature-(select avg(gear_box_inlet_temperature) from wind_turbine),4))/
(count(*) * power((select stddev(gear_box_inlet_temperature)from wind_turbine),4))-3
)as kurtosis
from wind_turbine;   #kurtosis=7.1479453859847375
select max(gear_box_inlet_temperature)-min(gear_box_inlet_temperature) from wind_turbine; #range=109.89


#Correlation Coefficient
#1)wind speed and wind_direction
SELECT
  (COUNT(*) * SUM(wind_speed * wind_direction) - SUM(wind_speed) * SUM(wind_direction)) /
  (SQRT((COUNT(*) * SUM(wind_speed * wind_speed) - POWER(SUM(wind_speed), 2)) * (COUNT(*) * SUM(wind_direction * wind_direction) - POWER(SUM(wind_direction), 2)))) AS correlation_coefficient
FROM
  wind_turbine;   # -0.0020077149106768177strong negative correlation.

#2) generator_speed and Generator_Bearing_Temperature
SELECT
  (COUNT(*) * SUM(generator_speed *Generator_Bearing_Temperature) - SUM(generator_speed) * SUM(Generator_Bearing_Temperature)) /
  (SQRT((COUNT(*) * SUM(generator_speed * generator_speed) - POWER(SUM(generator_speed), 2)) * (COUNT(*) * SUM(Generator_Bearing_Temperature * Generator_Bearing_Temperature) - POWER(SUM(Generator_Bearing_Temperature), 2)))) AS correlation_coefficient
FROM
  wind_turbine;  #0.7392924047028604 moderate positive correlation
  
#3)Gear_Oil_Temperature and gear_box_inlet_temperature

SELECT
  (COUNT(*) * SUM(Gear_Oil_Temperature *gear_box_inlet_temperature) - SUM(Gear_Oil_Temperature) * SUM(gear_box_inlet_temperature)) /
  (SQRT((COUNT(*) * SUM(Gear_Oil_Temperature * Gear_Oil_Temperature) - POWER(SUM(Gear_Oil_Temperature), 2)) * (COUNT(*) * SUM(gear_box_inlet_temperature * gear_box_inlet_temperature) - POWER(SUM(gear_box_inlet_temperature), 2)))) AS correlation_coefficient
FROM
  wind_turbine; # 0.6319087476784162 weak positive correlation
  
#4) Wind_Speed and Rotor_Speed
SELECT
  (COUNT(*) * SUM(Wind_Speed *Rotor_Speed) - SUM(Wind_Speed) * SUM(Rotor_Speed)) /
  (SQRT((COUNT(*) * SUM(Wind_Speed * Wind_Speed) - POWER(SUM(Wind_Speed), 2)) * (COUNT(*) * SUM(Rotor_Speed * Rotor_Speed) - POWER(SUM(Rotor_Speed), 2)))) AS correlation_coefficient
FROM
  wind_turbine; #-0.5873284644607312  moderate to strong negative correlation
  
#5)

#Outliers Detection#
#wind speed
select * from
(select date,wind_speed ,(wind_speed-avg(wind_speed) over())/
stddev(wind_speed) over() as zscore from wind_turbine) score_table
where zscore>1.65 or zscore<-1.65; #275 rows detected as outliers

#power
select * from
(select date,power ,(power-avg(power) over())/
stddev(power) over() as zscore from wind_turbine) score_table
where zscore>1.65 or zscore<-1.65;  #212 rows detected as outliers

#nacelle_ambient_temperature
select * from
(select date,nacelle_ambient_temperature ,(nacelle_ambient_temperature-avg(nacelle_ambient_temperature) over())/
stddev(nacelle_ambient_temperature) over() as zscore from wind_turbine) score_table
where zscore>1.65 or zscore<-1.65; #318 rows detected as outliers

#generetor_bearng_temperature
select * from
(select date,generator_bearing_temperature ,(generator_bearing_temperature-avg(generator_bearing_temperature) over())/
stddev(generator_bearing_temperature) over() as zscore from wind_turbine) score_table
where zscore>1.65 or zscore<-1.65; #412 rows detected as outliers

#gear_oil_temperature
select * from
(select date,gear_oil_temperature ,(gear_oil_temperature-avg(gear_oil_temperature) over())/
stddev(gear_oil_temperature) over() as zscore from wind_turbine) score_table
where zscore>1.65 or zscore<-1.65; #314 rows detected as outliers

# ambient_temperature
select * from
(select date,ambient_temperature,(ambient_temperature-avg(ambient_temperature) over())/
stddev(ambient_temperature) over() as zscore from wind_turbine) score_table
where zscore>1.65 or zscore<-1.65;  #251 rows detected as outliers

# rotor_speed
select * from
(select date,rotor_speed,(rotor_speed-avg(rotor_speed) over())/
stddev(rotor_speed) over() as zscore from wind_turbine) score_table
where zscore>1.65 or zscore<-1.65;  #351 rows detected as outliers

#nacelle_temperature
select * from
(select date,nacelle_temperature,(nacelle_temperature-avg(nacelle_temperature) over())/
stddev(nacelle_temperature) over() as zscore from wind_turbine) score_table
where zscore>1.65 or zscore<-1.65;   #376 rows detected as outliers

#bearing_temperature
select * from
(select date,bearing_temperature,(bearing_temperature-avg(bearing_temperature) over())/
stddev(bearing_temperature) over() as zscore from wind_turbine) score_table
where zscore>1.65 or zscore<-1.65;  #335 rows detected as outliers

#generator_speed
select * from
(select date,generator_speed,(generator_speed-avg(generator_speed) over())/
stddev(generator_speed) over() as zscore from wind_turbine) score_table
where zscore>1.65 or zscore<-1.65; #408 rows detected as outliers

# yaw_angle
select * from
(select date,yaw_angle,(yaw_angle-avg(yaw_angle) over())/
stddev(yaw_angle) over() as zscore from wind_turbine) score_table
where zscore>1.65 or zscore<-1.65;  #287 rows detected as outliers

#wind_direction
select * from
(select date,wind_direction,(wind_direction-avg(wind_direction) over())/
stddev(wind_direction) over() as zscore from wind_turbine) score_table
where zscore>1.65 or zscore<-1.65;  #246 rows detected as outliers

#wheel_hub_temperature
select * from
(select date,wheel_hub_temperature,(wheel_hub_temperature-avg(wheel_hub_temperature) over())/
stddev(wheel_hub_temperature) over() as zscore from wind_turbine) score_table
where zscore>1.65 or zscore<-1.65;  #412 rows detected as outliers

#gear_box_inlet_temperature
select * from
(select date,gear_box_inlet_temperature,(gear_box_inlet_temperature-avg(gear_box_inlet_temperature) over())/
stddev(gear_box_inlet_temperature) over() as zscore from wind_turbine) score_table
where zscore>1.65 or zscore<-1.65;  #250 rows detected as outliers


