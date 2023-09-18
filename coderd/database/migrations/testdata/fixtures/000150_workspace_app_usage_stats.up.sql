INSERT INTO public.workspace_app_stats (
	id,
	user_id,
	workspace_id,
	agent_id,
	access_method,
	slug_or_port,
	session_id,
	session_started_at,
	session_ended_at,
	requests
)
VALUES
	(
		1498,
		'30095c71-380b-457a-8995-97b8ee6e5307',
		'3a9a1feb-e89d-457c-9d53-ac751b198ebe',
		'7a1ce5f8-8d00-431c-ad1b-97a846512804',
		'path',
		'code-server',
		'562cbfb8-3d9a-4018-9c04-e8159d5aa43e',
		'2023-08-14 20:15:00+00',
		'2023-08-14 20:16:00+00',
		1
	),
	(
		59,
		'30095c71-380b-457a-8995-97b8ee6e5307',
		'3a9a1feb-e89d-457c-9d53-ac751b198ebe',
		'7a1ce5f8-8d00-431c-ad1b-97a846512804',
		'terminal',
		'',
		'281919d0-5d99-48fb-8a93-2c3019010387',
		'2023-08-14 14:15:40.085827+00',
		'2023-08-14 14:17:41.295989+00',
		1
	),
	(
		58,
		'30095c71-380b-457a-8995-97b8ee6e5307',
		'3a9a1feb-e89d-457c-9d53-ac751b198ebe',
		'7a1ce5f8-8d00-431c-ad1b-97a846512804',
		'path',
		'code-server',
		'5b7c9d43-19e6-4401-997b-c26de2c86c55',
		'2023-08-14 14:15:34.620496+00',
		'2023-08-14 23:58:37.158964+00',
		1
	),
	(
		57,
		'30095c71-380b-457a-8995-97b8ee6e5307',
		'3a9a1feb-e89d-457c-9d53-ac751b198ebe',
		'7a1ce5f8-8d00-431c-ad1b-97a846512804',
		'path',
		'code-server',
		'fe546a68-0921-4a2b-bced-5dc5c5635576',
		'2023-08-14 14:15:34.129002+00',
		'2023-08-14 23:58:37.158901+00',
		1
	),
	(
		56,
		'30095c71-380b-457a-8995-97b8ee6e5307',
		'3a9a1feb-e89d-457c-9d53-ac751b198ebe',
		'7a1ce5f8-8d00-431c-ad1b-97a846512804',
		'path',
		'code-server',
		'96e4e857-598c-4881-bc40-e13008b48bb0',
		'2023-08-14 14:15:00+00',
		'2023-08-14 14:16:00+00',
		36
	),
	(
		7,
		'30095c71-380b-457a-8995-97b8ee6e5307',
		'3a9a1feb-e89d-457c-9d53-ac751b198ebe',
		'7a1ce5f8-8d00-431c-ad1b-97a846512804',
		'terminal',
		'',
		'95d22d41-0fde-447b-9743-0b8583edb60a',
		'2023-08-14 13:00:28.732837+00',
		'2023-08-14 13:09:23.990797+00',
		1
	),
	(
		4,
		'30095c71-380b-457a-8995-97b8ee6e5307',
		'3a9a1feb-e89d-457c-9d53-ac751b198ebe',
		'7a1ce5f8-8d00-431c-ad1b-97a846512804',
		'path',
		'code-server',
		'442688ce-f9e7-46df-ba3d-623ef9a1d30d',
		'2023-08-14 13:00:12.843977+00',
		'2023-08-14 13:09:26.276696+00',
		1
	),
	(
		3,
		'30095c71-380b-457a-8995-97b8ee6e5307',
		'3a9a1feb-e89d-457c-9d53-ac751b198ebe',
		'7a1ce5f8-8d00-431c-ad1b-97a846512804',
		'path',
		'code-server',
		'f963c4f0-55b7-4813-8b61-ea58536754db',
		'2023-08-14 13:00:12.323196+00',
		'2023-08-14 13:09:26.277073+00',
		1
	),
	(
		2,
		'30095c71-380b-457a-8995-97b8ee6e5307',
		'3a9a1feb-e89d-457c-9d53-ac751b198ebe',
		'7a1ce5f8-8d00-431c-ad1b-97a846512804',
		'terminal',
		'',
		'5a034459-73e4-4642-91b8-80b0f718f29e',
		'2023-08-14 13:00:00+00',
		'2023-08-14 13:01:00+00',
		4
	),
	(
		1,
		'30095c71-380b-457a-8995-97b8ee6e5307',
		'3a9a1feb-e89d-457c-9d53-ac751b198ebe',
		'7a1ce5f8-8d00-431c-ad1b-97a846512804',
		'path',
		'code-server',
		'd7a0d8e1-069e-421d-b876-b5d0ddbcaf6d',
		'2023-08-14 13:00:00+00',
		'2023-08-14 13:01:00+00',
		36
	);


-- Additional fixture data for migration 000156.
-- As the migration is meant to fix workspace_agents with duplicate auth_tokens,
-- setting auth_tokens of two agents to the same value.
UPDATE
	workspace_agents
SET
	auth_token = 'deaddead-dead-dead-dead-deaddeaddead'
WHERE
	id
IN (
	SELECT
		id
	FROM
		workspace_agents
	ORDER BY
		created_at
	ASC
	LIMIT 2
);
