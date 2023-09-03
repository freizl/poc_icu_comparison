SELECT
    version();

SELECT
    '_' COLLATE "en_US" < 'e' COLLATE "en_US";

SELECT
    'lock_note' COLLATE "en_US" < 'locked_by' COLLATE "en_US";

SELECT
    'lock_note' COLLATE "C" < 'locked_by' COLLATE "C";

SELECT
    UNNEST(ARRAY['id' COLLATE "C", 'organization_id' COLLATE "C", 'locked_by' COLLATE "C", 'lock_reasons' COLLATE "C", 'lock_note' COLLATE "C", 'lock_source' COLLATE "C", 'sent_notification_emails' COLLATE "C", 'created_at' COLLATE "C"])
ORDER BY
    1;
