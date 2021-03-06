Install DataStax 
================
### Murmur3 Token Ranges
* [generate-murmur3-token.sh](https://github.com/kevinduraj/dse-install/blob/master/generate-murmur3-token.sh)

```
$ python -c 'print [str(((2**64 / 3) * i) - 2**63) for i in range(3)]'
['-9223372036854775808', '-3074457345618258603', '3074457345618258602']

$ python -c 'print [str(((2**64 / 5) * i) - 2**63) for i in range(5)]'
['-9223372036854775808', '-5534023222112865485', '-1844674407370955162', '1844674407370955161', '5534023222112865484']
```


DataStax Community Installation
===============================
* [http://docs.datastax.com/en/cassandra/3.x/cassandra/install/installRHEL.html](http://docs.datastax.com/en/cassandra/3.x/cassandra/install/installRHEL.html)

DataStax Enterprise Installation
================================
* [http://docs.datastax.com/en/datastax_enterprise/4.8/datastax_enterprise/install/installRHELdse.html](http://docs.datastax.com/en/datastax_enterprise/4.8/datastax_enterprise/install/installRHELdse.html)

### DSE - /etc/default/dse

```
vi /etc/default/dse
  SPARK_ENABLED=1
```


### Cassandra - cassandra.yaml

```
vi  /etc/dse/cassandra/cassandra.yaml 

cluster_name: 'Cassandra Cluster'
num_tokens: 32
seed_provider:
  - class_name: org.apache.cassandra.locator.SimpleSeedProvider
    parameters:
         - seeds: "192.168.1.159,192.168.1.132,192.168.1.133"
listen_address: 192.168.1.159
rpc_address: 192.168.1.159
endpoint_snitch: GossipingPropertyFileSnitch
```

### OpsCenter - address.yaml 
```
vi /var/lib/datastax-agent/conf/address.yaml

   stomp_interface: 192.168.1.159
```

### Data Center - cassandra-rackdc.properties

```
vi /etc/dse/cassandra/cassandra-rackdc.properties 

# Nodes 0 to 2
# indicate the rack and dc for this node
dc=DC1
rack=RAC1

# Nodes 3 to 5
# indicate the rack and dc for this node
dc=DC2
rack=RAC1
```


----

### Configure Multiple Data Centers

  + [Installing DataStax Enterprise](https://docs.datastax.com/en/datastax_enterprise/3.2/datastax_enterprise/install/installTOC.html)
  + [Initializing a multiple node clustes](https://docs.datastax.com/en/cassandra/2.0/cassandra/initialize/initializeMultipleDS.html)


* Set GossipingPropertyFileSnitch in /etc/dse/cassandra/cassandra.yaml
  * [GossipingPropertyFileSnitch](https://docs.datastax.com/en/cassandra/2.0/cassandra/architecture/architectureSnitchGossipPF_c.html)

| File                        | Configuration                                |  Why?                     |
| --------------------------  |:-------------------------------------------- |:------------------------- |
| cassandra.yaml              | num_token: 64                                | Vnodes                    |
| cassandra.yaml              | endpoint_snitch: GossipingPropertyFileSnitch | Communication between DC  |
| cassandra.yaml              | - seeds: "192.168.1.159,173.194.115.9"       | 2 internal and 1 external |
| cassandra-rackdc.properties | dc=DC1, rack=RAC1                            | Give name to data center  |


* Clearing up the data when changing Cluster Name or setting GossipingPropertyFileSnitch

| Delete Files and Directories            | Action                                |
| --------------------------------------- | ------------------------------------- |
| rm -rf /var/lib/cassandra/*             | Clearing entire system and data files |
| rm -rf /var/lib/cassandra/data/system/* | Clearing only system files            |





###Reference:

* [https://tobert.github.io/pages/als-cassandra-21-tuning-guide.html](https://tobert.github.io/pages/als-cassandra-21-tuning-guide.html)


