DataStax Solr
=============

## Build Schema and Index

```
$ curl http://localhost:8983/solr/resource/nhanes_ks.nhanes/solrconfig.xml --data-binary @solrconfig.xml -H 'Content-type:text/xml; charset=utf-8'
$ curl http://localhost:8983/solr/resource/nhanes_ks.nhanes/schema.xml --data-binary @schema.xml -H 'Content-type:text/xml; charset=utf-8'
$ curl "http://localhost:8983/solr/admin/cores?action=CREATE&name=nhanes_ks.nhanes"
```

## Identify DataCenter Name
```
$ nodetool status
Datacenter: SearchAnalytics
```

## Create Keyspace and Schema for DataCenter
```
cqlsh < 1-create-keyspace.cql
cqlsh < 2-create-nhanes.cql

```
## Load Data 

```
cqlsh < 3-copy-nhanes.cql

```

### References:
http://docs.datastax.com/en/datastax_enterprise/4.0/datastax_enterprise/srch/srchTutStrt.html
https://wiki.apache.org/solr/SolrQuerySyntax
