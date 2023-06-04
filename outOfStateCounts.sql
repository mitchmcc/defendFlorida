.mode column
.echo off

.print
.print
.print "Out of State Active Voter Count Report"
.print "------------------------------------"
.print

# NOTE: FL not included

select mailState as "State", count() as "Num registered FL voters"
from voters
where mailState in ('AL','AK','AZ','AR','CA','CO','CT','DE','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')
and voterStatus = 'ACT'
group by mailState;

