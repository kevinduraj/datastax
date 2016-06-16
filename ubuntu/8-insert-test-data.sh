#!/bin/bash

cqlsh -f test-data.cql
nodetool flush test1


