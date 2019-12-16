drop table if exists temp_users;
create temp table temp_users(id bigserial, group_id bigint);
insert into temp_users(group_id) values (1), (1), (1), (2), (1), (3);

drop sequence if exists user_group_counter;
create temp sequence user_group_counter;

with groups as (
    select id,
           group_id,
           case when coalesce(group_id <> lag(group_id) over (order by id), true)
           then nextval('user_group_counter')
           else currval('user_group_counter')
           end as counter_value
    from temp_users
)
select
    min(id) as min_id,
    min(group_id) as group_id,
    count(*) as count
from groups
group by counter_value
order by min_id;