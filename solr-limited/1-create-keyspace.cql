CREATE KEYSPACE nhanes_ks WITH REPLICATION = {'class': 'NetworkTopologyStrategy', 'SearchAnalytics': '1'}  AND durable_writes = true;
