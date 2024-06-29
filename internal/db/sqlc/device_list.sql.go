// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.26.0
// source: device_list.sql

package sqlc

import (
	"context"
)

const getDeviceIdByName = `-- name: GetDeviceIdByName :one
SELECT 
    id
FROM 
    device_list
WHERE 
    device_name = $1
`

func (q *Queries) GetDeviceIdByName(ctx context.Context, deviceName string) (int64, error) {
	row := q.db.QueryRow(ctx, getDeviceIdByName, deviceName)
	var id int64
	err := row.Scan(&id)
	return id, err
}

const getDevices = `-- name: GetDevices :many
SELECT 
	dl.device_name, 
	dl.device_location, 
	dl.device_type_id,
	dl.device_id,
	dt.device_type,
    mc.mqtt_topic
from
	device_list dl
inner join device_type_ids dt on dl.device_type_id = dt.device_type_id
left join mqtt_config mc on dl.device_id = mc.device_id
`

type GetDevicesRow struct {
	DeviceName     string  `json:"device_name"`
	DeviceLocation *string `json:"device_location"`
	DeviceTypeID   *int32  `json:"device_type_id"`
	DeviceID       int32   `json:"device_id"`
	DeviceType     string  `json:"device_type"`
	MqttTopic      *string `json:"mqtt_topic"`
}

func (q *Queries) GetDevices(ctx context.Context) ([]*GetDevicesRow, error) {
	rows, err := q.db.Query(ctx, getDevices)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []*GetDevicesRow
	for rows.Next() {
		var i GetDevicesRow
		if err := rows.Scan(
			&i.DeviceName,
			&i.DeviceLocation,
			&i.DeviceTypeID,
			&i.DeviceID,
			&i.DeviceType,
			&i.MqttTopic,
		); err != nil {
			return nil, err
		}
		items = append(items, &i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}
