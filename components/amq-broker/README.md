# AMQ Broker
AMQ Broker is a high-performance messaging implementation based on [ActiveMQ Artemis](https://activemq.apache.org/components/artemis/). <br />
It uses an asynchronous journal for fast message persistence, and supports multiple languages, protocols, and platforms.

## Deplyment Plan
It does not require any kind of authentication and no persistance is currently enabled.

## Acceptors
Acceptors define the way connections are made to the broker. <br />
We're currently using the port 61616.