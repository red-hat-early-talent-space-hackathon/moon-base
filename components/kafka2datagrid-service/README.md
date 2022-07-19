# kafka2datagrid service

- Stores RoverZone CRs in Datagrid (every 60 seconds)
- Stores car events from Kafka in Datagrid (GPS data)
- Stores Zone change detection events in MQTT Broker

## Start integration in dev mode

````shell
kamel run src/main/java/com/redhat/rover/routes/KafkaToDatagridRoute.java --dev --name k2dgDEV --secret=kafka2datagrid-secret --trait service.enabled=false --profile=openshift
````

## Properties

- com.redhat.rover.camelk.dg.car.snapshot.cacheName: carsnapshots
- com.redhat.rover.camelk.dg.car.cacheName: cars
- com.redhat.rover.camelk.dg.zone.cacheName: zones
- com.redhat.rover.camelk.dg.host: rover-dg
- com.redhat.rover.camelk.dg.password: TBD
- com.redhat.rover.camelk.dg.user: operator
- com.redhat.rover.camelk.kafka.brokers: rover-cluster-kafka-brokers
- com.redhat.rover.camelk.kafka.topic: rover-gps
- com.redhat.rover.camelk.mqtt.brokerUrl: tcp://rover-amq-mqtt-all-0-svc:61616
- com.redhat.rover.camelk.mqtt.topic: rover/zonechange
- com.redhat.rover.camelk.dg.namespace: rover
- com.redhat.rover.camelk.dg.ocp.api: api.ocp4.stormshift.coe.muc.redhat.com
