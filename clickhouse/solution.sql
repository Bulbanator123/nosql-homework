-- Решение заданий по ClickHouse

-- 1. Создание таблицы
-- TODO: скопируйте и доработайте CREATE TABLE из schema.sql
DROP TABLE IF EXISTS server_logs;
CREATE TABLE IF NOT EXISTS server_logs
(
    timestamp DateTime,
    user_id UInt8,
    endpoint String,
    response_time_ms UInt32,
    status_code UInt32
)
ENGINE = MergeTree
ORDER BY (timestamp, user_id);

-- 2. Загрузка данных из CSV
-- Подсказка: можно использовать clickhouse-client с параметром --query
-- Пример команды (выполняется в терминале):
-- cat server_logs.csv | clickhouse-client --query="INSERT INTO server_logs FORMAT CSVWithNames"


-- 3. Запрос: Топ-5 самых медленных endpoint'ов (по среднему времени ответа)
-- TODO: напишите SELECT запрос
SELECT endpoint, ROUND(AVG(response_time_ms)) AS average_endpoint_time FROM server_logs
GROUP BY endpoint
ORDER BY AVG(response_time_ms) DESC 
LIMIT 5;


-- 4. Запрос: Количество запросов по часам за весь период в логах
-- TODO: напишите SELECT запрос с использованием функции toHour() или formatDateTime()
SELECT toHour(timestamp) as hour, COUNT(*) AS responses_count FROM server_logs
GROUP BY toHour(timestamp)
ORDER BY toHour(timestamp);


-- 5. Запрос: Процент ошибок (status_code >= 400) для каждого endpoint'а
-- TODO: напишите SELECT запрос с вычислением процента ошибок
SELECT endpoint, ROUND(AVG((status_code >= 400) * 100), 2) AS error_percent FROM server_logs
GROUP BY endpoint;
