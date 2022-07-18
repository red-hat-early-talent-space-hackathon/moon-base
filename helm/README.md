# Rover Manual Installation
To set up the core Rover demo, you have to install the required operators and the mandatory core components provided by two Helm charts.

### 1. Create a new OpenShift Project
````sh
oc new-project rover
````

### 2. Install the required Operators

Log in to the OpenShift Admin Console with a privileged user account and install the following operators in the rover namespace:  

**1. AMQ Streams**  
startingCSV: amqstreams.v2.0.0-0
channel: stable
installPlanApproval: Automatic

**2. AMQ Broker**
startingCSV: amq-broker-operator.v7.9.1-opr-2
channel: 7.x
installPlanApproval: Automatic

**3. Datagrid**  
startingCSV: datagrid-operator.v8.2.8
channel: 8.2.x
installPlanApproval: Automatic

**4. Camel-K**
startingCSV: red-hat-camel-k-operator.v1.6.3
channel: 1.6.x
installPlanApproval: Automatic

### 3. Install the Rover Helm Charts

There are 2 Helm charts, that needs to be installed:

**rover-core-infra** sets up and configures the required infrastructure components (Kafka, Kafka Topics, MQTT broker, Camel-K, Datagrid).

**rover-core-apps** sets up all required application components like the vehicle simulator, several Camel-K integrations etc.

Please install them in the following order:
1. rover-core-infra
2. rover-core-apps

### 4.1 Helm Installation Options

You have basically two options to install Rover.
1. Configure the Rover Helm Chart Repository in OpenShift (min. 4.6.x) and install Rover UI based from the OpenShift Development Console.
2. Use the Helm CLI to install Rover from the commandline.

#### 4.1.1 Option 1:

#### 1. Configure Helm chart repository for OpenShift

```sh
oc apply -f https://raw.githubusercontent.com/sa-mw-dach/rover/master/helm/helm-repo.yaml
```

#### 2. Install the Helm charts from the OpenShift Developer Catalog

1. Open the Browser and login to your OCP environment.
2. Switch to the Developer perspective and the go to the namespace rover
3. Click the +ADD button and choose Helm Charts
4. Now you should see the Rover Helm charts from the Helm repo. Click on the Helm chart and install them in the right order.

#### 4.1.2 Option 2:

#### 2. Install with Helm CLI

Add the rover Helm repo and list the charts.
```sh
helm repo add rover-repo https://sa-mw-dach.github.io/rover-charts/
helm repo update
helm search repo rover-repo

NAME                                 	CHART VERSION	APP VERSION	DESCRIPTION
rover-repo/rover-core-apps     	1.0.2        	4.6.12     	Rover core infrastructure components
rover-repo/rover-core-infra    	1.1.0        	4.6.12     	Rover core infrastructure components
rover-repo/rover-core-operators	1.0.0        	4.6.12     	Rover core operators
```

You can check the values of every chart (and create your values file). 
```sh
helm show values rover-repo/rover-core-infra

helm show values rover-repo/rover-core-infra > my-core-infra-values.yaml
```

**Install the Helm charts:**

1. rover-core-infra:  

You **need** to adjust these values:
- namespace
- ocpDomain

```sh
helm install rover-core-infra rover-repo/rover-core-infra --set-string namespace=rover --set-string ocpDomain=apps.ocp3.stormshift.coe.muc.redhat.com

or
 
helm install -f my-core-infra-values.yaml rover-core-infra rover-repo/rover-core-infra
```
Wait until the components have been installed...
```sh
watch oc get pods

NAME                                                   READY   STATUS      RESTARTS   AGE
rover-amq-mqtt-ss-0                                 1/1     Running     0          3d2h
rover-bridge-75568d5f8f-hb5cq                       1/1     Running     0          26h
rover-cluster-kafka-0                               1/1     Running     0          26h
rover-cluster-kafka-1                               1/1     Running     0          26h
rover-cluster-zookeeper-0                           1/1     Running     0          26h
rover-cluster-zookeeper-1                           1/1     Running     0          26h
rover-cluster-zookeeper-2                           1/1     Running     0          26h
rover-dg-0                                          1/1     Running     0          3d2h

oc get KafkaTopic
oc get KafkaBridge
oc get Infinispan
```

2. rover-core-apps:

3. You **need** to adjust these values:
- namespace
- ocpDomain
- ocpApi
- dashboard.config.googleApiKey

```sh
helm install rover-core-apps rover-repo/rover-core-apps \
--set-string ocpDomain=apps.ocp3.stormshift.coe.muc.redhat.com \
--set-string ocpApi=api.ocp3.stormshift.coe.muc.redhat.com \
--set-string namespace=rover \
--set-string dashboard.config.googleApiKey=YourGoogleApiKey

or
 
helm install -f my-core-apps-values.yaml rover-core-apps rover-repo/rover-core-apps
```
Wait until the app components have been build and installed...

```sh
watch oc get pods

NAME                                                   READY   STATUS      RESTARTS   AGE
cache-service-7c5dc67b6-2ltnj                          1/1     Running     0          3d2h
camel-k-kit-c07vq2m293usl0ms8geg-1-build               0/1     Completed   0          3d2h
camel-k-kit-c07vq2m293usl0ms8gf0-1-build               0/1     Completed   0          3d2h
camel-k-kit-c07vq2m293usl0ms8gfg-1-build               0/1     Completed   0          3d2h
camel-k-kit-c07vq2m293usl0ms8gg0-1-build               0/1     Completed   0          3d2h
car-simulator-1-8lwbv                                  1/1     Running     0          3d2h
car-simulator-1-build                                  0/1     Completed   0          3d2h
car-simulator-1-deploy                                 0/1     Completed   0          3d2h
car-simulator-native-1-build                           0/1     Completed   0          3d2h
dashboard-1-build                                      0/1     Completed   0          3d2h
dashboard-1-deploy                                     0/1     Completed   0          3d2h
dashboard-1-l9x2j                                      1/1     Running     0          3d2h
dashboard-streaming-service-7d8d6f769-5dhkk            1/1     Running     0          3d2h
kafka2datagrid-6df5456c58-p45cs                        1/1     Running     0          3d2h
mqtt2kafka-5494768b8b-4gc9b                            1/1     Running     0          3d2h
```

Open the Rover Dashboard URL and get started.
```sh
oc get route dashboard

NAME        HOST/PORT                                                    PATH   SERVICES    PORT       TERMINATION   WILDCARD
dashboard   dashboard-rover.apps.ocp3.stormshift.coe.muc.redhat.com          dashboard   8080-tcp                 None
```