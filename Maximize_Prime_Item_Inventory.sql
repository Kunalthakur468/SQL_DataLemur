/*
Amazon wants to maximize the number of items it can stock in a 500,000 square feet warehouse. It wants to stock as many prime items as possible, 
and afterwards use the remaining square footage to stock the most number of non-prime items.

Write a query to find the number of prime and non-prime items that can be stored in the 500,000 square feet warehouse. 
Output the item type with prime_eligible followed by not_prime and the maximum number of items that can be stocked.

Effective April 3rd 2023, we added some new assumptions to the question to provide additional clarity.

Assumptions:

Prime and non-prime items have to be stored in equal amounts, regardless of their size or square footage. This implies that prime items will be stored separately from non-prime items in their respective containers, but within each container, all items must be in the same amount.
Non-prime items must always be available in stock to meet customer demand, so the non-prime item count should never be zero.
Item count should be whole numbers (integers).

inventory table:

Column Name	Type
item_id	integer
item_type	string
item_category	string
square_footage	decimal

inventory Example Input:
item_id	item_type	item_category	square_footage
1374	prime_eligible	mini refrigerator	68.00
4245	not_prime	standing lamp	26.40
2452	prime_eligible	television	85.00
3255	not_prime	side table	22.60
1672	prime_eligible	laptop	8.50

Example Output:
item_type	item_count
prime_eligible	9285
not_prime	6

*/
-- Solution 1:
with CTE as (
SELECT item_type,sum(square_footage) as sq_area,count(1) item_cnt 
FROM inventory group by item_type)
select 
item_type, 
floor(500000/sq_area)*item_cnt as item_count
FROM CTE where item_type='prime_eligible'
UNION
select item_type,
floor((500000 - (select floor(500000/sq_area)*sq_area from CTE where item_type='prime_eligible'))/sq_area)*item_cnt
from CTE where item_type='not_prime'
ORDER BY item_count DESC;

-- Solution 2:
WITH CTE AS
(SELECT 
SUM(CASE WHEN ITEM_TYPE = 'not_prime' THEN 1 ELSE 0 END) N_PRIME_ITEM_CNT,
SUM(CASE WHEN ITEM_TYPE = 'prime_eligible' THEN 1 ELSE 0 END) PRIME_ITEM_CNT,
SUM(CASE WHEN ITEM_TYPE = 'not_prime' THEN SQUARE_FOOTAGE END) SUM_NP_SQR,
SUM(CASE WHEN ITEM_TYPE = 'prime_eligible' THEN SQUARE_FOOTAGE END) SUM_P_SQR
FROM INVENTORY)
SELECT 
'prime_eligible',
FLOOR(500000/SUM_P_SQR)*PRIME_ITEM_CNT as PRIME_ITEMS
FROM CTE
UNION
SELECT 'not_prime', 
floor((500000 - (FLOOR(500000/SUM_P_SQR))*SUM_P_SQR)/SUM_NP_SQR)*N_PRIME_ITEM_CNT 
from cte order by prime_items desc;
