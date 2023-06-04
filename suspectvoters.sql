.mode column
.print "Suspected Deceased Voters Report"
.print
select A.voterId, A.firstName, A.lastName, A.birthDate, (strftime('%Y', 'now') - strftime('%Y', A.birthDate)) - (strftime('%m-%d', 'now') < strftime('%m-%d', A.birthDate)) as "Age", B.electionDate from voters as A JOIN votehistory B on A.voterId = B.voterId
where A.voterId in (
'106731086','106748433','107361843','107415675','107213337','106753405','106697134','106917189','106711390','107119922','106759678','106981475','106692360','107150352','106810202','107213337','106754858','106811813','107328680','114852388','107437224','106758383','106908151','106873060','122366478','106974476','106856575','106704102','105237532')
and B.electionDate = '2020-11-03'
order by A.voterId, B.electionDate desc

