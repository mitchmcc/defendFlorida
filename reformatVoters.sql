update voters set birthDate=substr(birthDate,7,4)||"-"||substr(birthDate,1,2)||"-"||substr(birthDate,4,2)
