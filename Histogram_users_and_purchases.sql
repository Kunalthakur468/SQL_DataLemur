/*
This is the same question as problem #13 in the SQL Chapter of Ace the Data Science Interview!

Assume you are given the table on Walmart user transactions. Based on a user's most recent transaction date, write a query to obtain the users and the number of products bought.

Output the user's most recent transaction date, user ID and the number of products sorted by the transaction date in chronological order.

P.S. As of 10 Nov 2022, the official solution was changed from output of the transaction date, number of users and number of products to the current output.

user_transactions Table:
Column Name	Type
product_id	integer
user_id	integer
spend	decimal
transaction_date	timestamp
user_transactions Example Input:
product_id	user_id	spend	transaction_date
3673	123	68.90	07/08/2022 12:00:00
9623	123	274.10	07/08/2022 12:00:00
1467	115	19.90	07/08/2022 12:00:00
2513	159	25.00	07/08/2022 12:00:00
1452	159	74.50	07/10/2022 12:00:00
Example Output:
transaction_date	user_id	purchase_count
07/08/2022 12:00:00	115	1
07/08/2022 12:00:000	123	2
07/10/2022 12:00:00	159	1
The dataset you are querying against may have different input & output - this is just an example!
*/

SELECT transaction_date,user_id, count(1) purchase_count 
FROM user_transactions ut where 
transaction_date in (
select max(transaction_date) from user_transactions 
where ut.user_id=user_id)
group by transaction_date,user_id;
