create materialized view NR_OF_THREADS_BY_USER
refresh on commit
as
select u.nickname, count(*) "nr_of_threads" from users u join thread th on u.id=th.user_id group by u.nickname;

create materialized view NR_OF_POST_ON_THREAD_ID
refresh on commit
as
select th.id, count(*) "nr_of_posts" from thread th join post p on th.id = p.thread_id group by th.id;