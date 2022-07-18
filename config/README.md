# Rover Zone Configuration

Rover zones are configured through Custom Resources.

```sh
git clone https://github.com/Red-Hat-Space-Association/moon-base
```

You need cluster-admin privileges in order to install CRDs. The following command installs the RoverZones CRD and a sample Zone CR

```sh
oc apply -k config/
```

Check if you can read the CR (shortname for kind RoverZone is bz)

```sh
oc get bz rover-ffm -o json
```

The CRD extends the Kubernetes API as follows:

**/apis/rover.redhat.com/v1alpha1/namespaces/\*/zones/**

Test the API extension with:

```sh
curl -k -H "Authorization: Bearer yourtoken" "https://api.ocp3.stormshift.coe.muc.redhat.com:6443/apis/rover.redhat.com/v1alpha1/namespaces/rover/zones/"
```

or

```sh
curl -k -H "Authorization: Bearer yourtoken" "https://api.ocp3.stormshift.coe.muc.redhat.com:6443/apis/rover.redhat.com/v1alpha1/namespaces/rover/zones/rover-ffm"
```

```shell
oc adm policy add-cluster-role-to-user cluster-monitoring-view -z infinispan-monitoring

oc serviceaccounts get-token infinispan-monitoring
```