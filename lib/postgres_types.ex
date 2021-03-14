Postgrex.Types.define(Works.PostgresTypes,
              [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
              json: Jason)
