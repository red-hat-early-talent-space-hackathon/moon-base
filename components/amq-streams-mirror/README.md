# AMQ Streams Mirror
[MirrorMaker](https://access.redhat.com/documentation/en-us/red_hat_amq/7.6/html/using_amq_streams_on_rhel/assembly-mirrormaker-str) is used to replicate data between two or more active Kafka clusters, within or across data centers. <br/>
MirrorMaker 2.0 uses:

+ Source cluster configuration to consume data from the source cluster
+ Target cluster configuration to output data to the target cluster

This template will setup an AMQ Streams Operator ([Strimzi](https://strimzi.io/)) in the **bobbycar** namespace.