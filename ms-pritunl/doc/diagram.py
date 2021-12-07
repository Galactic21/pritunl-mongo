# diagram.py
from diagrams import Diagram, Cluster, Edge
from diagrams.custom import Custom
from diagrams.onprem.database import MongoDB
from diagrams.aws.storage import S3
from diagrams.onprem.monitoring import Prometheus
from diagrams.onprem.database import InfluxDB
from diagrams.onprem.monitoring import Grafana
from diagrams.onprem.client import User
from diagrams.onprem.compute import Server

with Diagram("Pritunl Archicteture", show=False):

    user_obj = User("User")
    internet_obj = Custom("Internet", "./my_resources/cloud.png")
    s3_obj = S3("S3")

    with Cluster("VPC - AccessHub"):
        mongodb_obj = MongoDB("MongoDB")

        with Cluster("Pritunl Nodes"):
            pritunl_obj1 = Custom("Pritunl Node 1", "./my_resources/pritunl-logo.png")
            pritunl_obj2 = Custom("Pritunl Node 2", "./my_resources/pritunl-logo.png")

            pritunl_group = [pritunl_obj1,
                            pritunl_obj2]

            s3_obj << Edge(label='data backups', color='darkgreen') << mongodb_obj << \
            Edge(label='store data', color='darkgreen') << pritunl_obj1

    with Cluster("VPC - MPS"):
        server_obj = Server("Server X")


        influxdb_obj = InfluxDB("InfluxDB")
        pritunl_obj2 >> Edge(label='pritunl cluster send time series data to', color='darkred') >> influxdb_obj

    pritunl_obj2 >> Edge(label='connect to Server X', color='black') << server_obj
    user_obj >> Edge(label='connect to Pritunl Client', color="black") << internet_obj >> \
    Edge(label='Pritunl Client connect to Pritunl Server', color="black") << pritunl_obj2


with Diagram("Monitoring Archicteture", show=False):


    prometheus_obj = Prometheus("Prometheus")
    grafana_obj = Grafana("Grafana")

    with Cluster("MongoDB"):
        mongodb_obj = MongoDB("MongoDB")
        mongodb_exporter = Custom("MongoDB Exporter", "./my_resources/prometheus_exporter.png")
        blackbox_exporter = Custom("Blackbox Exporter", "./my_resources/prometheus_exporter.png")

        mongodb_obj - Edge(color="darkgreen", style="dashed") - mongodb_exporter << Edge(label='scrape', color="black")\
        << prometheus_obj
        mongodb_obj - Edge(color="darkgreen", style="dashed") - blackbox_exporter << Edge(label='scrape', color="black")\
        << prometheus_obj

    with Cluster("Pritunl"):
        pritunl_obj = Custom("Pritunl", "./my_resources/pritunl-logo.png")
        node_exporter = Custom("Node Exporter", "./my_resources/prometheus_exporter.png")
        pritunl_obj - Edge(color="darkblue", style="dashed") - node_exporter << Edge(label='scrape', color="black")\
        << prometheus_obj

    with Cluster("InfluxDB"):
        influxdb_obj = InfluxDB("InfluxDB")
        influxdb_exporter = Custom("InfluxDB Exporter", "./my_resources/prometheus_exporter.png")
        influxdb_obj - Edge(color="darkred", style="dashed") - influxdb_exporter << Edge(label='scrape', color="black")\
        << prometheus_obj

    grafana_obj >> Edge(label='show graphs', color="darkred", style="dashed") >> prometheus_obj