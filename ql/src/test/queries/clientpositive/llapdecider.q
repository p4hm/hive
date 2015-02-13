set hive.stats.fetch.column.stats=true;

-- simple query with multiple reduce stages
EXPLAIN SELECT key, count(value) as cnt FROM src GROUP BY key ORDER BY cnt;

create table src_orc stored as orc as select * from src;

EXPLAIN SELECT key, count(value) as cnt FROM src_orc GROUP BY key ORDER BY cnt;

set hive.llap.auto.enforce.stats=false;

EXPLAIN SELECT key, count(value) as cnt FROM src_orc GROUP BY key ORDER BY cnt;

set hive.llap.auto.enforce.stats=true;

analyze table src_orc compute statistics for columns;

EXPLAIN SELECT key, count(value) as cnt FROM src_orc GROUP BY key ORDER BY cnt;

EXPLAIN SELECT * from src_orc join src on (src_orc.key = src.key) order by src.value;

EXPLAIN SELECT * from src_orc s1 join src_orc s2 on (s1.key = s2.key) order by s2.value;

set hive.llap.auto.enforce.tree=false;

EXPLAIN SELECT * from src_orc join src on (src_orc.key = src.key) order by src.value;

set hive.llap.auto.enforce.tree=true;

set hive.llap.auto.max.input.size=10;

EXPLAIN SELECT * from src_orc s1 join src_orc s2 on (s1.key = s2.key) order by s2.value;

set hive.llap.auto.max.input.size=1000000000;
set hive.llap.auto.max.output.size=10;

EXPLAIN SELECT * from src_orc s1 join src_orc s2 on (s1.key = s2.key) order by s2.value;

set hive.llap.auto.max.output.size=1000000000;

set hive.llap.execution.mode=map;

EXPLAIN SELECT * from src_orc s1 join src_orc s2 on (s1.key = s2.key) order by s2.value;

set hive.llap.execution.mode=none;

EXPLAIN SELECT * from src_orc s1 join src_orc s2 on (s1.key = s2.key) order by s2.value;

set hive.llap.execution.mode=all;

EXPLAIN SELECT * from src_orc s1 join src_orc s2 on (s1.key = s2.key) order by s2.value;