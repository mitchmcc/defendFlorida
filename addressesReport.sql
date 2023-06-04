.mode column
.header
.width 25 25 25 10 30
.print "Addresses with more than 100 registered voters"
.print

select resAddr1 as "Address1", resAddr2 as "Address2", resCity as "City", resZip as "Zip", count(resAddr1) as "Num registered voters" from voters
group by resAddr1
having count(resAddr1) > 100
order by count(resAddr1) DESC;

