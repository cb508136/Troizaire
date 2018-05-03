if "PostgreSQL" == ActiveRecord::Base.connection.adapter_name
  ActiveRecord::Base.connection.execute("CREATE OR REPLACE FUNCTION concat(text, text, text) RETURNS text AS $$ SELECT $1 || $2 || $3; $$ LANGUAGE 'sql';")
end
