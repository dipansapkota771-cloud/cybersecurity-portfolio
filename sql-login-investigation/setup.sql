-- SQL Login Security Investigation
-- Create and populate a fictional authentication log dataset.

DROP TABLE IF EXISTS log_in_attempts;

CREATE TABLE log_in_attempts (
    event_id INTEGER PRIMARY KEY,
    username TEXT NOT NULL,
    login_date TEXT NOT NULL,
    login_time TEXT NOT NULL,
    country TEXT NOT NULL,
    ip_address TEXT NOT NULL,
    success INTEGER NOT NULL CHECK (success IN (0, 1))
);

INSERT INTO log_in_attempts
(event_id, username, login_date, login_time, country, ip_address, success)
VALUES
(101, 'alex', '2026-09-14', '02:01:12', 'Mexico', '203.0.113.45', 0),
(102, 'alex', '2026-09-14', '02:02:24', 'Mexico', '203.0.113.45', 0),
(103, 'alex', '2026-09-14', '02:03:31', 'Mexico', '203.0.113.45', 0),
(104, 'alex', '2026-09-14', '02:04:46', 'Mexico', '203.0.113.45', 0),
(105, 'alex', '2026-09-14', '02:05:58', 'Mexico', '203.0.113.45', 0),
(106, 'alex', '2026-09-14', '02:07:03', 'Mexico', '203.0.113.45', 0),
(107, 'alex', '2026-09-14', '02:08:17', 'Mexico', '203.0.113.45', 0),
(108, 'alex', '2026-09-14', '02:09:29', 'Mexico', '203.0.113.45', 0),
(109, 'alex', '2026-09-14', '02:10:40', 'Mexico', '203.0.113.45', 1),
(110, 'brianna', '2026-09-14', '23:11:05', 'Canada', '198.51.100.72', 0),
(111, 'brianna', '2026-09-14', '23:12:16', 'Canada', '198.51.100.72', 0),
(112, 'brianna', '2026-09-14', '23:13:27', 'Canada', '198.51.100.72', 0),
(113, 'brianna', '2026-09-14', '23:14:38', 'Canada', '198.51.100.72', 0),
(114, 'brianna', '2026-09-14', '23:15:49', 'Canada', '198.51.100.72', 0),
(115, 'carlos', '2026-09-15', '09:15:00', 'United States', '192.0.2.18', 1),
(116, 'carlos', '2026-09-15', '13:42:10', 'United States', '192.0.2.18', 1),
(117, 'diana', '2026-09-15', '07:31:22', 'Germany', '203.0.113.88', 0),
(118, 'diana', '2026-09-15', '07:34:51', 'Germany', '203.0.113.88', 0),
(119, 'diana', '2026-09-15', '07:38:09', 'Germany', '203.0.113.88', 0),
(120, 'diana', '2026-09-15', '07:41:36', 'Germany', '203.0.113.88', 0),
(121, 'emma', '2026-09-15', '10:20:15', 'United States', '192.0.2.64', 0),
(122, 'emma', '2026-09-15', '10:22:41', 'United States', '192.0.2.64', 1),
(123, 'farah', '2026-09-15', '18:45:12', 'Japan', '198.51.100.140', 0),
(124, 'farah', '2026-09-15', '18:49:33', 'Japan', '198.51.100.140', 0),
(125, 'george', '2026-09-15', '14:05:17', 'United States', '192.0.2.91', 1);

SELECT COUNT(*) AS total_records
FROM log_in_attempts;
