# Apache Kafka (AMQ Streams) as IoT Cloud Gateway
The AMQ streams component provides an event streaming backbone that allows the exchange of data with high throughput and low latency.
## Setting up the AMQ Streams component

```sh
git clone https://github.com/Red-Hat-Space-Association/moon-base.git
```

```sh
cd components/amq-streams
```

```sh
oc apply -k .
```

This will setup/install the following resources in the **rover** namespace:

- an AMQ Streams Operator ([Strimzi](https://strimzi.io/))
- a Kafka cluster with 3 broker and 3 zookeeper instances and metrics configured
- a Kafka Bridge cluster with 2 instances
- a Route to access the Kafka Bridge from outside the Cluster
- a Kafka Topic named **rover-gps** with 3 partitions

## Testing with a Kafka consumer

With the following command you can start a Kafka consumer pod for testing purposes.

```sh
oc project rover
```

```sh
oc run kafka-consumer -ti --image=registry.redhat.io/amq7/amq-streams-kafka-24-rhel7:1.4.0 --rm=true --restart=Never -- bin/kafka-console-consumer.sh --bootstrap-server rover-cluster-kafka-bootstrap:9092 --topic rover-gps --from-beginning
```
