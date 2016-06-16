#!/bin/bash

curl "http://localhost:8983/solr/nhanes_ks.nhanes/select?q=age:[10%20TO%20*]&sort=age+asc&fl=age+family_size+num_smokers&wt=json&indent=true&facet=true&facet.field=age"
