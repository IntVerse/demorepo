# **Redpanda Connect Docker Compose Setup**

This repository contains a docker-compose.yml configuration for setting up Redpanda along with Redpanda Console, Redpanda Connect, and a PostgreSQL database for development and testing.

## **Services**

### **1. Redpanda Broker (redpanda-0)**

      - Image: docker.redpanda.com/redpandadata/redpanda:v24.2.5

      - Pandaproxy:

          - External: 18082

          - Internal: 8082

      - Schema Registry:

          - External: 18081

          - Internal: 8081

      - Admin API: Port 9644

      - Mode: dev-container for local development

### **2. Redpanda Console (redpanda-console)**

      - Image: docker.redpanda.com/redpandadata/console:v2.7.2

      - Port: 8080

      - Schema Registry: redpanda-0:8081

      - The Console provides a web UI for monitoring the Kafka environment and clusters.

### **3. Redpanda Connect (redpanda-connect)**

      - Image: docker.redpanda.com/redpandadata/connect

      - Mounted Volumes:

            - ./streams for configuring tasks and connectors.

      - Command: Executes the Benthos and Redpanda connect YAML files from /streams.

      - Dependencies: redpanda-0, console

### **4. PostgreSQL Database (database)**

      - Image: ankane/pgvector:latest

      - Port: 5432

      - User: test

      - Password: test

      - Database: default_database

### **Usage**

      - Used for storing data related to Redpanda or for external tasks.

### **Prerequisites**

      - Install Docker

      - Install Docker Compose

### **Setup and Run**

#### **1. Clone this repository:**

```
git clone <repo-url> cd <repo-directory>
```

#### **2. Run the services:**

```
docker-compose up -d
```

#### **3. Verify the setup:**


Access the Redpanda Console at: http://localhost:8080

#### **4. Validate File Outputs**
Use vi or cat to check if data is written to /tmp/data.txt and /tmp/data1.txt within the container:

```
docker exec -it <benthos_container_id> /bin/sh
/tmp $ cat data.txt
/tmp $ cat data1.txt
```

#### **5. Validate Data in PostgreSQL**
After inserting data via Benthos, connect to PostgreSQL and query the table to check if records have been inserted:

```
docker exec -it <postgres_container_id> /bin/sh
# psql -h localhost -U test -d default_database
default_database=# SELECT * FROM my_table;
```

#### **6. Check Logs for Errors**
Monitor Benthos logs to ensure there are no errors during data processing. Inside the container, run:

```
docker logs <benthos_container_id>
```

#### **7. Stopping the Services**

```
docker-compose down
```

Note : To shut down and delete the containers along with all your cluster data:

```
docker compose down -v
```

### **Additional Notes**

    - You can add additional connectors for Redpanda by updating the YAML files in the ./streams folder.

    - Make sure to use internal and external addresses appropriately when connecting from inside or outside the Docker network.

