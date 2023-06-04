update voteHistory set electionDate=substr(electionDate,7,4)||"-"||substr(electionDate,1,2)||"-"||substr(electionDate,4,2);
