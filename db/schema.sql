-- Create "device_type_ids" table
CREATE TABLE "device_type_ids" (
  "id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
  "device_type" text NOT NULL,
  "device_type_id" integer NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "device_type_ids_unique" UNIQUE ("device_type"),
  CONSTRAINT "device_type_ids_unique_1" UNIQUE ("device_type_id")
);
-- Create "device_list" table
CREATE TABLE "device_list" (
  "id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
  "device_name" text NOT NULL,
  "device_location" text NULL,
  "device_type_id" integer NULL,
  "device_id" integer NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "device_list_unique" UNIQUE ("device_name"),
  CONSTRAINT "device_list_unique_1" UNIQUE ("device_id"),
  CONSTRAINT "device_list_device_type_ids_fk" FOREIGN KEY ("device_type_id") REFERENCES "device_type_ids" ("device_type_id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- Create "ambient_station_unique" table
CREATE TABLE "ambient_station_unique" (
  "id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
  "timestamp" timestamptz NULL,
  "date" text NULL,
  "timezone" text NULL,
  "date_utc" integer NULL,
  "inside_temp_feels_like_f" real NULL,
  "outside_temp_f" real NULL,
  "outside_temp_feels_like_f" real NULL,
  "outside_humidity" real NULL,
  "inside_dew_point" real NULL,
  "outside_dew_point" real NULL,
  "relative_pressure" real NULL,
  "wind_direction" real NULL,
  "wind_speed_mph" real NULL,
  "wind_speed_gust_mph" real NULL,
  "max_daily_gust_mph" real NULL,
  "event_rain_inches" real NULL,
  "hourly_rain_inches" real NULL,
  "daily_rain_inches" real NULL,
  "weekly_rain_inches" real NULL,
  "monthly_rain_inches" real NULL,
  "total_rain_inches" real NULL,
  "last_rain" text NULL,
  "uv_index" real NULL,
  "solar_radiation" real NULL,
  "outside_batt_status" integer NULL,
  "co2_batt_status" integer NULL,
  "device_id" integer NULL,
  "device_type_id" integer NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "ambient_station_unique_device_list_fk" FOREIGN KEY ("device_id") REFERENCES "device_list" ("device_id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "ambient_station_unique_device_type_ids_fk" FOREIGN KEY ("device_type_id") REFERENCES "device_type_ids" ("device_type_id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- Create "aqara_temp_sensors_unique" table
CREATE TABLE "aqara_temp_sensors_unique" (
  "id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
  "timestamp" timestamptz NULL,
  "link_quality" real NULL,
  "batt_percentage" real NULL,
  "batt_voltage" real NULL,
  "power_outage_count" integer NULL,
  "device_id" integer NULL,
  "device_type_id" integer NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "aqara_temp_sensors_unique_device_list_fk" FOREIGN KEY ("device_id") REFERENCES "device_list" ("device_id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "aqara_temp_sensors_unique_device_type_ids_fk" FOREIGN KEY ("device_type_id") REFERENCES "device_type_ids" ("device_type_id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- Create "mqtt_config" table
CREATE TABLE "mqtt_config" (
  "id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
  "mqtt_topic" text NULL,
  "device_id" integer NULL,
  "device_type_id" integer NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "mqtt_config_device_list_fk" FOREIGN KEY ("device_id") REFERENCES "device_list" ("device_id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "mqtt_config_device_type_ids_fk" FOREIGN KEY ("device_type_id") REFERENCES "device_type_ids" ("device_type_id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
-- Create "shared_atmospheric_readings" table
CREATE TABLE "shared_atmospheric_readings" (
  "id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
  "timestamp" timestamptz NULL,
  "temp_f" real NULL,
  "temp_c" real NULL,
  "humidity" real NULL,
  "absolute_pressure" real NULL,
  "device_type_id" integer NULL,
  "device_id" integer NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "shared_atmospheric_readings_device_list_fk" FOREIGN KEY ("device_id") REFERENCES "device_list" ("device_id") ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "shared_atmospheric_readings_device_type_ids_fk" FOREIGN KEY ("device_type_id") REFERENCES "device_type_ids" ("device_type_id") ON UPDATE NO ACTION ON DELETE NO ACTION
);
