# datagrid-rest-service

## Dev mode

````shell
kamel run src/main/java/com/redhat/rover/routes/DatagridToRestRoute.java --dev -d camel-netty-http -d camel-infinispan --secret=datagrid2rest --profile=openshift --trait service.enabled=false
````
