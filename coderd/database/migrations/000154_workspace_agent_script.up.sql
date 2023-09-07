BEGIN;
CREATE TABLE workspace_agent_log_sources (
	workspace_agent_id uuid NOT NULL,
	id uuid NOT NULL,
	created_at timestamptz NOT NULL,
	display_name varchar(127) NOT NULL,
	icon text NOT NULL,
	PRIMARY KEY (workspace_agent_id, id)
);

CREATE TABLE workspace_agent_scripts (
	workspace_agent_id uuid NOT NULL,
	log_source_id uuid NOT NULL,
	created_at timestamptz NOT NULL,
	script text NOT NULL,
	schedule text NOT NULL,
	login_before_ready boolean NOT NULL,
	run_on_start boolean NOT NULL,
	run_on_stop boolean NOT NULL,
	name varchar(127) NOT NULL,
	description text NOT NULL
);

ALTER TABLE workspace_agent_logs ADD COLUMN log_source_id uuid NOT NULL;
ALTER TABLE workspace_agent_logs DROP COLUMN source;
DROP TYPE workspace_agent_log_source;

ALTER TABLE workspace_agents DROP COLUMN startup_script_timeout_seconds;
ALTER TABLE workspace_agents DROP COLUMN shutdown_script;
ALTER TABLE workspace_agents DROP COLUMN shutdown_script_timeout_seconds;
ALTER TABLE workspace_agents DROP COLUMN startup_script_behavior;
ALTER TABLE workspace_agents DROP COLUMN startup_script;

-- Set the table to unlogged to speed up the inserts
ALTER TABLE workspace_agent_logs SET UNLOGGED;
COMMIT;
