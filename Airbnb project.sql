
# Problem Statements -
#1.What are the most popular neighborhoods for Airbnb rentals in New York City? How do prices and availability vary by neighborhood?

#2.How has the Airbnb market in New York City changed over time? Have there been any significant trends in terms of the number of listings, prices, or occupancy rates?

#3.Are there any patterns or trends in terms of the types of properties that are being rented out on Airbnb in New York City? 
#  Are certain types of properties more popular or more expensive than others?

#4.Are there any factors that seem to be correlated with the prices of Airbnb rentals in New York City?

#5.the best area in New York City for a host to buy property at a good price rate and in an area with high traffic ?

#6.How do the lengths of stay for Airbnb rentals in New York City vary by neighborhood? Do certain neighborhoods tend to attract longer or shorter stays?

#7.How do the ratings of Airbnb rentals in New York City compare to their prices? Are higher-priced rentals more likely to have higher ratings?

#8.Find the total numbers of Reviews and Maximum Reviews by Each Neighborhood Group.

#9.Find Most reviewed room type in Neighborhood groups per month.

#10.Find Best location listing/property location for travelers.

#11.Find also best location listing/property location for Hosts.

#12.Find Price variations in NYC Neighborhood groups.

#there is a lot of problem statements and we have to finds information and insights through different different problem statements so now lets start...

# Let's Begin;

load data local infile 'E:/airbnb.csv'
into table airbnb 
columns terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines;
set global local_infile=1;

select* from airbnb   limit 50000;
alter table air_bnb.airbnb change column id listing_id int;
alter table air_bnb.airbnb change column name listing_name varchar(1000);
alter table air_bnb.airbnb change column number_of_reviews   Total_reviews int;
alter table air_bnb.airbnb change column calculated_host_listings_count host_listing_count int;  
select count(*) from airbnb;
desc airbnb;
select count(listing_id) from airbnb where listing_id="";
select count(listing_name) from airbnb where listing_name="";
select count(host_id)from airbnb where host_id="";
select count(host_name) from airbnb where host_name="";
select count(neighbourhood_group) from airbnb where neighbourhood_group="";
select count(neighbourhood) from airbnb where neighbourhood="";
select count(latitude) from airbnb where latitude="";
select count(longitude) from airbnb where longitude="";
select count(room_type) from airbnb where room_type="";
select count(price) from airbnb where price="";
select count(minimum_nights) from airbnb where minimum_nights="";
select count(Total_reviews) from airbnb where Total_reviews="";
select count(reviews_per_month) from airbnb where reviews_per_month="";
select count(host_listing_count) from airbnb where host_listing_count="";
select count(availability_365) from airbnb where availability_365 ="";

update airbnb set listing_name="unknown" where listing_name=null;
update airbnb set host_name="no_name" where host_name="";
alter table airbnb drop column last_review;
update airbnb set reviews_per_month=0 where reviews_per_month="";

select  distinct count(listing_id) from airbnb;
select  listing_name, count(listing_name) from airbnb group by listing_name;
select  neighbourhood, count(neighbourhood) from airbnb group by neighbourhood limit 50000;
select  neighbourhood_group, count(neighbourhood_group) from airbnb group by neighbourhood_group limit 50000;
select  host_name, count(host_name) from airbnb group by host_name limit 50000;
select listing_name,host_name from airbnb group by listing_name,host_name having host_name="david";
select* from airbnb where host_name=listing_name;
select * from airbnb where host_name="alex" and neighbourhood_group="queens";


#1.What are the most popular neighborhoods for Airbnb rentals in New York City? How do prices and availability vary by neighborhood?
select distinct neighbourhood from airbnb;
select neighbourhood_group,count(neighbourhood_group) as Total_count,round(avg(price)) as price,round(avg(availability_365)) as availability from airbnb 
group by neighbourhood_group order by total_count desc;
create view top_nbhgroup_view as select neighbourhood_group,count(neighbourhood_group) as Total_count,round(avg(price)) as price,round(avg(availability_365)) as availability from airbnb 
group by neighbourhood_group order by total_count desc;


select neighbourhood,count(neighbourhood) as total_count,round(avg(price))as price,round(avg(availability_365)) as availability from airbnb
group by neighbourhood order by Total_count desc limit 10;
create view top_neighborhood_view as select neighbourhood,count(neighbourhood) as total_count,round(avg(price))as price,round(avg(availability_365)) as availability from airbnb
group by neighbourhood order by Total_count desc limit 10;
select * from top_neighborhood_view;

# 2.   How has the Airbnb market in New York City changed over time? Have there been any significant trends in terms of the number of listings, prices, or occupancy rates?
select host_id,host_name,count(host_id) as Total_count,round(avg(price)),round(avg(availability_365))
 from airbnb group by host_id,host_name order by count(host_id) desc limit 10;
create view significant_trends_view as select host_id,host_name,count(host_id) as Total_count,round(avg(price)),round(avg(availability_365))
 from airbnb group by host_id,host_name order by count(host_id) desc limit 10;
 select * from significant_trends_view;

#3. Are there any patterns or trends in terms of the types of properties that are being rented out on Airbnb in New York City?
 -- Are certain types of properties more popular or more expensive than others?
select neighbourhood, count(room_type) as private_room_count,round(avg(price)) as price,round(avg(availability_365)) as availability from airbnb group by neighbourhood,room_type 
having room_type="private room" order by count(room_type) desc;
create view pattern_view_1 as select neighbourhood, count(room_type) as private_room_count,round(avg(price)) as price,round(avg(availability_365)) as availability from airbnb group by neighbourhood,room_type 
having room_type="private room" order by count(room_type) desc;
select neighbourhood, count(room_type) as Entire_home_count,round(avg(price)) as price,round(avg(availability_365)) as availability from airbnb group by neighbourhood,room_type 
having room_type="entire home/apt" order by count(room_type) desc;
create view pattern_view_2 as select neighbourhood, count(room_type) as Entire_home_count,round(avg(price)) as price,round(avg(availability_365)) as availability from airbnb group by neighbourhood,room_type 
having room_type="entire home/apt" order by count(room_type) desc;
select neighbourhood, count(room_type) as Shared_room_count,round(avg(price)) as price,round(avg(availability_365)) as availability from airbnb group by neighbourhood,room_type 
having room_type="Shared room" order by count(room_type) desc;
create view pattern_view_3 as select neighbourhood, count(room_type) as Shared_room_count,round(avg(price)) as price,round(avg(availability_365)) as availability from airbnb group by neighbourhood,room_type 
having room_type="Shared room" order by count(room_type) desc;

#5. the best area in New York City for a host to buy property at a good price rate and in an area with high traffic ?
select neighbourhood,round(avg(price)) as price,round(avg(availability_365)) as availability from airbnb group by neighbourhood order by availability limit 20;
create view	 best_area_view as select neighbourhood,round(avg(price)) as price,round(avg(availability_365)) as availability from airbnb group by neighbourhood order by availability limit 20;

#6. How do the lengths of stay for Airbnb rentals in New York City vary by neighborhood? Do certain neighborhoods tend to attract longer or shorter stays?
select neighbourhood_group,minimum_nights,count(minimum_nights) as Total_count from airbnb group by neighbourhood_group,minimum_nights
having neighbourhood_group="brooklyn" and minimum_nights in(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20) order by minimum_nights;
create view lenghts_stay_view1 as select neighbourhood_group,minimum_nights,count(minimum_nights) as Total_count from airbnb group by neighbourhood_group,minimum_nights
having neighbourhood_group="brooklyn" and minimum_nights in(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20) order by minimum_nights;
 
select neighbourhood_group,minimum_nights,count(minimum_nights) as Total_count from airbnb group by neighbourhood_group,minimum_nights
having neighbourhood_group="Manhattan" and minimum_nights in(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20) order by minimum_nights;
create view lenghts_stay_view2 as select neighbourhood_group,minimum_nights,count(minimum_nights) as Total_count from airbnb group by neighbourhood_group,minimum_nights
having neighbourhood_group="Manhattan" and minimum_nights in(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20) order by minimum_nights;

select neighbourhood_group,minimum_nights,count(minimum_nights) as Total_count from airbnb group by neighbourhood_group,minimum_nights
having neighbourhood_group="Queens" and minimum_nights in(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20) order by minimum_nights;
create view lenghts_stay_view3 as select neighbourhood_group,minimum_nights,count(minimum_nights) as Total_count from airbnb group by neighbourhood_group,minimum_nights
having neighbourhood_group="Queens" and minimum_nights in(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20) order by minimum_nights;

select neighbourhood_group,minimum_nights,count(minimum_nights) as Total_count from airbnb group by neighbourhood_group,minimum_nights
having neighbourhood_group="Staten Island" and minimum_nights in(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20) order by minimum_nights;
create view lenghts_stay_view4 as select neighbourhood_group,minimum_nights,count(minimum_nights) as Total_count from airbnb group by neighbourhood_group,minimum_nights
having neighbourhood_group="Staten Island" and minimum_nights in(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20) order by minimum_nights;

select neighbourhood_group,minimum_nights,count(minimum_nights) as Total_count from airbnb group by neighbourhood_group,minimum_nights
having neighbourhood_group="Bronx" and minimum_nights in(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20) order by minimum_nights;
create view lenghts_stay_view5 as select neighbourhood_group,minimum_nights,count(minimum_nights) as Total_count from airbnb group by neighbourhood_group,minimum_nights
having neighbourhood_group="Bronx" and minimum_nights in(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20) order by minimum_nights;

#7. How do the ratings of Airbnb rentals in New York City compare to their prices? Are higher-priced rentals more likely to have higher ratings?
 select neighbourhood,room_type,round(avg(price)) as price,round(avg(total_reviews)) as Reviews from airbnb group by neighbourhood,room_type having room_type="private room"
 order by price desc limit 10;
 create view rentals_view1 as  select neighbourhood,room_type,round(avg(price)) as price,round(avg(total_reviews)) as Reviews from airbnb group by neighbourhood,room_type having room_type="private room"
 order by price desc limit 10;
 
 select neighbourhood,room_type,round(avg(price)) as price,round(avg(total_reviews)) as Reviews from airbnb group by neighbourhood,room_type having room_type="Entire home/apt"
 order by price desc limit 10;
  create view rentals_view2 as  select neighbourhood,room_type,round(avg(price)) as price,round(avg(total_reviews)) as Reviews from airbnb group by neighbourhood,room_type having room_type="Entire home/apt"
 order by price desc limit 10;
 
  select neighbourhood,room_type,round(avg(price)) as price,round(avg(total_reviews)) as Reviews from airbnb group by neighbourhood,room_type having room_type="Shared Room"
 order by price desc limit 10;
 create view rentals_view3 as select neighbourhood,room_type,round(avg(price)) as price,round(avg(total_reviews)) as Reviews from airbnb group by neighbourhood,room_type having room_type="Shared Room"
 order by price desc limit 10;
 
 #8. Find the total numbers of Reviews and Maximum Reviews by Each Neighborhood Group.
 select	neighbourhood_group,count(neighbourhood_group) as Total_count from airbnb group by neighbourhood_group;
 create view total_reviews as select	neighbourhood_group,count(neighbourhood_group) as Total_count from airbnb group by neighbourhood_group;
 
 select neighbourhood_group,neighbourhood,max(total_reviews) as max_reviews from airbnb group by neighbourhood_group,neighbourhood having neighbourhood_group="brooklyn" order by 
 max_reviews desc limit 1;
 create view max_reviews1 as select neighbourhood_group,neighbourhood,max(total_reviews) as max_reviews from airbnb group by neighbourhood_group,neighbourhood having neighbourhood_group="brooklyn" order by 
 max_reviews desc limit 1;
 
 select neighbourhood_group,neighbourhood,max(total_reviews) as max_reviews from airbnb group by neighbourhood_group,neighbourhood having neighbourhood_group="Queens" order by 
 max_reviews desc limit 1;
 create view max_reviews2 as select neighbourhood_group,neighbourhood,max(total_reviews) as max_reviews from airbnb group by neighbourhood_group,neighbourhood having neighbourhood_group="Queens" order by 
 max_reviews desc limit 1;
 
 select neighbourhood_group,neighbourhood,max(total_reviews) as max_reviews from airbnb group by neighbourhood_group,neighbourhood having neighbourhood_group="Manhattan" order by 
 max_reviews desc limit 1;
 create view max_reviews3 as select neighbourhood_group,neighbourhood,max(total_reviews) as max_reviews from airbnb group by neighbourhood_group,neighbourhood having neighbourhood_group="Manhattan" order by 
 max_reviews desc limit 1;
 
 select neighbourhood_group,neighbourhood,max(total_reviews) as max_reviews from airbnb group by neighbourhood_group,neighbourhood having neighbourhood_group="Staten island" order by 
 max_reviews desc limit 1;
 create view max_reviews4 as select neighbourhood_group,neighbourhood,max(total_reviews) as max_reviews from airbnb group by neighbourhood_group,neighbourhood having neighbourhood_group="Staten island" order by 
 max_reviews desc limit 1;
 
 select neighbourhood_group,neighbourhood,max(total_reviews) as max_reviews from airbnb group by neighbourhood_group,neighbourhood having neighbourhood_group="Bronx" order by 
 max_reviews desc limit 1;
 create view max_reviews5 as select neighbourhood_group,neighbourhood,max(total_reviews) as max_reviews from airbnb group by neighbourhood_group,neighbourhood having neighbourhood_group="Bronx" order by 
 max_reviews desc limit 1;
 
 #9. Find Most reviewed room type in Neighborhood groups per month.
select room_type,round(sum(reviews_per_month)) as total_reviews from airbnb group by room_type having room_type in("private room","entire home/apt","shared room");
create view	Total_reviews1 as select room_type,round(sum(reviews_per_month)) as total_reviews from airbnb group by room_type having room_type in("private room","entire home/apt","shared room");
 
select neighbourhood_group, room_type,round(sum(reviews_per_month)) as Total_reviews from airbnb group by room_type,neighbourhood_group having room_type="private room";
create view most_reviewed_roomtype as select neighbourhood_group, room_type,round(sum(reviews_per_month)) as Total_reviews from airbnb group by room_type,neighbourhood_group having room_type="private room";

select neighbourhood_group, room_type,round(sum(reviews_per_month)) as Total_reviews from airbnb group by room_type,neighbourhood_group having room_type="entire home/apt";
create view most_reviewed_roomtype2 as select neighbourhood_group, room_type,round(sum(reviews_per_month)) as Total_reviews from airbnb group by room_type,neighbourhood_group having room_type="entire home/apt";
    
select neighbourhood_group, room_type,round(sum(reviews_per_month)) as Total_reviews from airbnb group by room_type,neighbourhood_group having room_type="Shared room";
create view most_reviewed_roomtype3 as select neighbourhood_group, room_type,round(sum(reviews_per_month)) as Total_reviews from airbnb group by room_type,neighbourhood_group having room_type="Shared room";
     
 #10. Find Best location listing/property location for travelers.
  select neighbourhood_group,round(avg(total_reviews)) as reviews,round(avg(price)) as price, round(avg(availability_365)) from airbnb group by neighbourhood_group;
  create view Best_location_travelers as select neighbourhood_group,round(avg(total_reviews)) as reviews,round(avg(price)) as price, round(avg(availability_365)) from airbnb group by neighbourhood_group;
  
  #11.Find also best location listing/property location for Hosts
   select neighbourhood_group,count(neighbourhood_group) as reviews,round(avg(price)) as price, round(avg(availability_365)) from airbnb group by neighbourhood_group;
   create view best_location_host as select neighbourhood_group,count(neighbourhood_group) as reviews,round(avg(price)) as price, round(avg(availability_365)) from airbnb group by neighbourhood_group;
 
 #12. Find Price variations in NYC Neighborhood groups.
 select neighbourhood_group,round(avg(price)) as price from airbnb group by neighbourhood_group;
 create view price_variation_view as select neighbourhood_group,round(avg(price)) as price from airbnb group by neighbourhood_group;
						
  