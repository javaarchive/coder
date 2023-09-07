-- name: InsertWorkspaceAgentScripts :many
INSERT INTO
	workspace_agent_scripts (workspace_agent_id, log_source_id, log_source_display_name, created_at, source, cron, start_blocks_login, run_on_start, run_on_stop, timeout)
SELECT
	@workspace_agent_id :: uuid AS workspace_agent_id,
	unnest(@log_source_id :: uuid [ ]) AS log_source_id,
	unnest(@log_source_display_name :: varchar(127) [ ]) AS log_source_display_name,
	unnest(@created_at :: timestamptz [ ]) AS created_at,
	unnest(@source :: text [ ]) AS source,
	unnest(@cron :: text [ ]) AS cron,
	unnest(@start_blocks_login :: boolean [ ]) AS start_blocks_login,
	unnest(@run_on_start :: boolean [ ]) AS run_on_start,
	unnest(@run_on_stop :: boolean [ ]) AS run_on_stop,
	unnest(@timeout :: integer [ ]) AS timeout
RETURNING workspace_agent_scripts.*;

-- name: GetWorkspaceAgentScriptsByAgentIDs :many
SELECT * FROM workspace_agent_scripts WHERE workspace_agent_id = ANY(@ids :: uuid [ ]);
