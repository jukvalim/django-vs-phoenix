import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :events_phoenix, EventsPhoenix.Repo,
  username: "postgres",
  password: "postgres",
  database: "events_phoenix_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :events_phoenix, EventsPhoenixWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "OccGfXo1gKDwcDU5b6zPeNIgR5xNEpSSWg35AyOYTxEa52sfOB6QQ8uydE32y6zC",
  server: false

# In test we don't send emails.
config :events_phoenix, EventsPhoenix.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
