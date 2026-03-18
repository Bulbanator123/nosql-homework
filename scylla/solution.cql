-- TODO: Implementation
-- кейспейс
CREATE KEYSPACE forum_ks
    WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE forum;

-- таблица 1 (посты пользователя)
create table posts_by_user
(
    user_id    int,
    created_at timestamp,
    post_id    int,
    content    text,
    username   text,
    topic_id   int,
    primary key (user_id, created_at, post_id)
) with clustering order by (created_at desc);

-- запрос достающий посты заданного пользователя
select post_id, content, created_at
from posts_by_user
where user_id = 1;

-- селект достающий последний пост заданного пользователя
select post_id, content, created_at, username
from posts_by_user
where user_id = 1
limit 1;

-- запрос достающий посты заданного пользователя после заданной даты
select post_id, content, created_at
from posts_by_user
where user_id = 1
  and created_at >= '2026-01-01 00:00:00';

-- таблица 2 (посты по топикам)
create table posts_by_topic
(
    topic_id   int,
    created_at timestamp,
    post_id    int,
    user_id    int,
    username   text,
    content    text,
    primary key (topic_id, created_at, post_id)
) with clustering order by (created_at desc);

-- селект достающий пользователей, сделавших пост в заданный день по заданной теме
select user_id, username, post_id, created_at
from posts_by_topic
where topic_id = 1
  and created_at >= '2026-01-01 00:00:00'
  and created_at < '2026-01-02 00:00:00'

