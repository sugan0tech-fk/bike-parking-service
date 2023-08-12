# Bike Parking Service
A bike parking statistics generator application, with the given capacity of bike parking slot (Two sided format) [ref](https://www.dimensions.com/element/90-degree-parking-spaces-layouts). max-frequency will provide the list of bikes in most reoccurance order. max-time will provide the list of adjacent bike pairs with max hold time. For a bike i, adjacent bikes will be (i - 1), (i + 1) and (i*2).


# Tech specs
- service on rails
- db on MariaDB
- managed in K8s, docker-compose, or self containers 
- Cache on redis (coming soon)

### running the service
-  Docker
    ```
    Docker build
    ```
-  docker compose
  ```
  docker compose up
  ```
-  k8s

## api format

### bulk loading data
```
curl --location 'localhost:3000/load-entry' \
--header 'Content-Type: application/json' \
--data '{
  "capacity": 8,
  "bikes": [1, 2, 3, 4, 5, 6],
  "slots": [1, 2, 3, 4, 5, 6],
  "in_time": [
    "2023-07-17 10:30:00",
    "2023-07-17 12:30:00",
    "2023-07-17 14:45:00",
    "2023-07-17 16:15:00",
    "2023-07-17 17:15:00",
    "2023-07-17 18:00:00"
  ],
  "out_time": [
    "2023-07-17 11:00:00",
    "2023-07-17 13:15:00",
    "2023-07-17 15:30:00",
    "2023-07-17 17:30:00",
    "2023-07-17 17:30:00",
    "2023-07-17 19:30:00"
  ]
}'
```

### adding single load
```
curl --location 'localhost:3000/make-entry' \
--header 'Content-Type: application/json' \
--data '{
  "bike": 3,
  "slot": 7,
  "in_time": "2023-07-17 10:30:00",
  "out_time": "2023-07-17 11:00:00"
}'
```


### for getting the max frequency

```
curl --location 'localhost:3000/max-frequency'
```

### for getting max time
```
curl --location 'localhost:3000/max-time'
```
