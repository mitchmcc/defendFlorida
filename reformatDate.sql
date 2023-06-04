update voters set birthDate=substr(birthDate,7,4)||"-"||substr(birthDate,1,2)||"-"||substr(birthDate,4,2);

update voteHistory set electionDate=substr(electionDate,7,4)||"-"||substr(electionDate,1,2)||"-"||substr(electionDate,4,2);

update voters SET birthDate = REPLACE(birthDate, '/', '-');


