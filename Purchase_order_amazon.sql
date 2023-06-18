/*
Let's see who can solve this SQL problem asked in the Amazon interview for a BI Engineer position..


Given the users purchase history write a query to print users who have done purchase on more than 1 day and products purchased on a given day are never repeated on any other day.

Bonus points if you solve it without using a subquery or self join.

Here is the ready script:

create table purchase_history
(userid int
,productid int
,purchasedate date
);

insert all 
into purchase_history values (1,1,'23-01-2012')
into purchase_history values (1,2,'23-01-2012')
into purchase_history values (1,3,'25-01-2012')
into purchase_history values (2,1,'23-01-2012')
into purchase_history values (2,2,'23-01-2012')
into purchase_history values (2,2,'25-01-2012')
into purchase_history values (2,4,'25-01-2012')
into purchase_history values (3,4,'23-01-2012')
into purchase_history values (3,1,'23-01-2012')
into purchase_history values (4,1,'23-01-2012')
into purchase_history values (4,2,'25-01-2012')
select * from dual;
*/

-- Solution 1: Easy
select userid from purchase_history
group by userid having 
count(distinct productid) = count(1)
and count(distinct purchasedate) > 1;

-- Solution 2 : Medium

with p_history as
 (
 select userid,
 rank() over (partition by userid order by productid) product_rank,
 rank() over (partition by userid order by purchasedate) purchase_date_rank
 from purchase_history
 )
select userid
from p_history
where product_rank = purchase_date_rank
and product_rank > 1
and purchase_date_rank > 1;
