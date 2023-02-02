TYPE=VIEW
query=select if(`performance_schema`.`accounts`.`USER` is null,\'background\',`performance_schema`.`accounts`.`USER`) AS `user`,sum(`stmt`.`total`) AS `statements`,`sys`.`format_time`(sum(`stmt`.`total_latency`)) AS `statement_latency`,`sys`.`format_time`(ifnull(sum(`stmt`.`total_latency`) / nullif(sum(`stmt`.`total`),0),0)) AS `statement_avg_latency`,sum(`stmt`.`full_scans`) AS `table_scans`,sum(`io`.`ios`) AS `file_ios`,`sys`.`format_time`(sum(`io`.`io_latency`)) AS `file_io_latency`,sum(`performance_schema`.`accounts`.`CURRENT_CONNECTIONS`) AS `current_connections`,sum(`performance_schema`.`accounts`.`TOTAL_CONNECTIONS`) AS `total_connections`,count(distinct `performance_schema`.`accounts`.`HOST`) AS `unique_hosts`,`sys`.`format_bytes`(sum(`mem`.`current_allocated`)) AS `current_memory`,`sys`.`format_bytes`(sum(`mem`.`total_allocated`)) AS `total_memory_allocated` from (((`performance_schema`.`accounts` left join `sys`.`x$user_summary_by_statement_latency` `stmt` on(if(`performance_schema`.`accounts`.`USER` is null,\'background\',`performance_schema`.`accounts`.`USER`) = `stmt`.`user`)) left join `sys`.`x$user_summary_by_file_io` `io` on(if(`performance_schema`.`accounts`.`USER` is null,\'background\',`performance_schema`.`accounts`.`USER`) = `io`.`user`)) left join `sys`.`x$memory_by_user_by_current_bytes` `mem` on(if(`performance_schema`.`accounts`.`USER` is null,\'background\',`performance_schema`.`accounts`.`USER`) = `mem`.`user`)) group by if(`performance_schema`.`accounts`.`USER` is null,\'background\',`performance_schema`.`accounts`.`USER`) order by sum(`stmt`.`total_latency`) desc
md5=ab4b3d2f67c44888d3adc69a1d3e7111
updatable=0
algorithm=2
definer_user=mariadb.sys
definer_host=localhost
suid=0
with_check_option=0
timestamp=2023-02-01 11:18:04
create-version=2
source=SELECT IF(accounts.user IS NULL, \'background\', accounts.user) AS user,\n       SUM(stmt.total) AS statements,\n       sys.format_time(SUM(stmt.total_latency)) AS statement_latency,\n       sys.format_time(IFNULL(SUM(stmt.total_latency) / NULLIF(SUM(stmt.total), 0), 0)) AS statement_avg_latency,\n       SUM(stmt.full_scans) AS table_scans,\n       SUM(io.ios) AS file_ios,\n       sys.format_time(SUM(io.io_latency)) AS file_io_latency,\n       SUM(accounts.current_connections) AS current_connections,\n       SUM(accounts.total_connections) AS total_connections,\n       COUNT(DISTINCT host) AS unique_hosts,\n       sys.format_bytes(SUM(mem.current_allocated)) AS current_memory,\n       sys.format_bytes(SUM(mem.total_allocated)) AS total_memory_allocated\n  FROM performance_schema.accounts\n  LEFT JOIN sys.x$user_summary_by_statement_latency AS stmt ON IF(accounts.user IS NULL, \'background\', accounts.user) = stmt.user\n  LEFT JOIN sys.x$user_summary_by_file_io AS io ON IF(accounts.user IS NULL, \'background\', accounts.user) = io.user\n  LEFT JOIN sys.x$memory_by_user_by_current_bytes mem ON IF(accounts.user IS NULL, \'background\', accounts.user) = mem.user\n GROUP BY IF(accounts.user IS NULL, \'background\', accounts.user)\n ORDER BY SUM(stmt.total_latency) DESC;
client_cs_name=utf8mb3
connection_cl_name=utf8mb3_general_ci
view_body_utf8=select if(`performance_schema`.`accounts`.`USER` is null,\'background\',`performance_schema`.`accounts`.`USER`) AS `user`,sum(`stmt`.`total`) AS `statements`,`sys`.`format_time`(sum(`stmt`.`total_latency`)) AS `statement_latency`,`sys`.`format_time`(ifnull(sum(`stmt`.`total_latency`) / nullif(sum(`stmt`.`total`),0),0)) AS `statement_avg_latency`,sum(`stmt`.`full_scans`) AS `table_scans`,sum(`io`.`ios`) AS `file_ios`,`sys`.`format_time`(sum(`io`.`io_latency`)) AS `file_io_latency`,sum(`performance_schema`.`accounts`.`CURRENT_CONNECTIONS`) AS `current_connections`,sum(`performance_schema`.`accounts`.`TOTAL_CONNECTIONS`) AS `total_connections`,count(distinct `performance_schema`.`accounts`.`HOST`) AS `unique_hosts`,`sys`.`format_bytes`(sum(`mem`.`current_allocated`)) AS `current_memory`,`sys`.`format_bytes`(sum(`mem`.`total_allocated`)) AS `total_memory_allocated` from (((`performance_schema`.`accounts` left join `sys`.`x$user_summary_by_statement_latency` `stmt` on(if(`performance_schema`.`accounts`.`USER` is null,\'background\',`performance_schema`.`accounts`.`USER`) = `stmt`.`user`)) left join `sys`.`x$user_summary_by_file_io` `io` on(if(`performance_schema`.`accounts`.`USER` is null,\'background\',`performance_schema`.`accounts`.`USER`) = `io`.`user`)) left join `sys`.`x$memory_by_user_by_current_bytes` `mem` on(if(`performance_schema`.`accounts`.`USER` is null,\'background\',`performance_schema`.`accounts`.`USER`) = `mem`.`user`)) group by if(`performance_schema`.`accounts`.`USER` is null,\'background\',`performance_schema`.`accounts`.`USER`) order by sum(`stmt`.`total_latency`) desc
mariadb-version=100903
