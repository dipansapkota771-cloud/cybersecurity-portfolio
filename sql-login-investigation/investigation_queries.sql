-- SQL Login Security Investigation
-- Run setup.sql before running these queries.

-- 1. Review the complete dataset.
SELECT *
FROM log_in_attempts
ORDER BY event_id;

-- 2. Count all failed logins.
SELECT COUNT(*) AS failed_logins
FROM log_in_attempts
WHERE success = 0;

-- 3. Find failed attempts from Mexico or Canada.
SELECT *
FROM log_in_attempts
WHERE country IN ('Mexico', 'Canada')
  AND success = 0
ORDER BY event_id;

-- 4. Count failures outside 08:00-18:00 business hours.
SELECT COUNT(*) AS after_hours_failures
FROM log_in_attempts
WHERE (login_time < '08:00:00' OR login_time > '18:00:00')
  AND success = 0;

-- 5. Count failed attempts for each username.
SELECT username, COUNT(*) AS failed_attempts
FROM log_in_attempts
WHERE success = 0
GROUP BY username
ORDER BY failed_attempts DESC;

-- 6. Find accounts with more than three failures.
SELECT username, COUNT(*) AS failed_attempts
FROM log_in_attempts
WHERE success = 0
GROUP BY username
HAVING COUNT(*) > 3
ORDER BY failed_attempts DESC;

-- 7. Find source IPs with at least five failures.
SELECT ip_address, country, COUNT(*) AS failed_attempts
FROM log_in_attempts
WHERE success = 0
GROUP BY ip_address, country
HAVING COUNT(*) >= 5
ORDER BY failed_attempts DESC;

-- 8. Find accounts with more than three failures and at least one success.
SELECT
    username,
    SUM(CASE WHEN success = 0 THEN 1 ELSE 0 END) AS failed_attempts,
    SUM(CASE WHEN success = 1 THEN 1 ELSE 0 END) AS successful_attempts
FROM log_in_attempts
GROUP BY username
HAVING SUM(CASE WHEN success = 0 THEN 1 ELSE 0 END) > 3
   AND SUM(CASE WHEN success = 1 THEN 1 ELSE 0 END) >= 1
ORDER BY failed_attempts DESC;

-- 9. Examine Alex's events in chronological order.
SELECT
    event_id,
    username,
    login_date,
    login_time,
    country,
    ip_address,
    success
FROM log_in_attempts
WHERE username = 'alex'
ORDER BY login_date, login_time;

-- 10. Count failures by country.
SELECT country, COUNT(*) AS failed_attempts
FROM log_in_attempts
WHERE success = 0
GROUP BY country
ORDER BY failed_attempts DESC;

-- 11. Create a summary of accounts with at least four failures.
SELECT
    username,
    ip_address,
    country,
    SUM(CASE WHEN success = 0 THEN 1 ELSE 0 END) AS failed_attempts,
    SUM(CASE WHEN success = 1 THEN 1 ELSE 0 END) AS successful_attempts,
    MIN(login_time) AS first_attempt,
    MAX(login_time) AS last_attempt
FROM log_in_attempts
GROUP BY username, ip_address, country
HAVING SUM(CASE WHEN success = 0 THEN 1 ELSE 0 END) >= 4
ORDER BY failed_attempts DESC;

-- 12. Determine whether failed-login IPs targeted multiple accounts.
SELECT
    ip_address,
    COUNT(DISTINCT username) AS targeted_accounts,
    GROUP_CONCAT(DISTINCT username) AS usernames
FROM log_in_attempts
WHERE success = 0
GROUP BY ip_address
ORDER BY targeted_accounts DESC;
