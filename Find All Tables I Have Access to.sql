select top 0 * 
    into #temp
    from INFORMATION_SCHEMA.TABLES

insert into #temp
    exec sp_msforeachdb 'select * from [?].INFORMATION_SCHEMA.TABLES'

select * from #temp

drop table #temp