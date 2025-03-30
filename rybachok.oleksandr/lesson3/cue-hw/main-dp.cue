package kubernetes

import resources "github.com/sfesfizh/cue-hw/templates"

nginx_deployment: resources.#CreateDeployment & {
    params: {
        name: "nginx"
        namespace: "default"
        version: "v1.0.0"
        replicas: 3
        image: "nginx:1.14.2"
        containerPort: 80
        cpuRequest: "100m"
        memoryRequest: "128Mi"
        cpuLimit: "200m"
        memoryLimit: "256Mi"
        livenessProbePath: "/health"
        livenessProbeInitialDelaySeconds: 30    
        livenessProbePeriodSeconds: 10
        readinessProbePath: "/health"
        readinessProbeInitialDelaySeconds: 30
        readinessProbePeriodSeconds: 10
        mountPath: "/usr/share/nginx/html"
        key: "index.html"
        path: "/usr/share/nginx/html/index.html"
        env: {
            name: "APP_ENV"
            value: "production"
        }
        tolerations: {
            key: "app"
            operator: "Equal"
            value: "nginx"  
            effect: "NoSchedule"
        }
    }
}

nginx_service: resources.#CreateService & {
    params: {
        name: "nginx"
        namespace: "default"
        version: "v1.0.0"
        type: "ClusterIP"
        protocol: "TCP"
        portName: "http"
        port: 80
        targetPort: 80
    }
}

nginx_configMap: resources.#CreateConfigMap & {
    params: {
        name: "nginx"
        namespace: "default"
        version: "v1.0.0"
        data: {
            "index.html": "Hello, World!"
        }
    }
}

mysql_deployment: resources.#CreateDeployment & {
    params: {
        name: "mysql"
        namespace: "default"
        version: "v1.0.0"
        replicas: 1
        image: "mysql:8.0"
        containerPort: 3306
        cpuRequest: "100m"
        memoryRequest: "128Mi"
        cpuLimit: "200m"
        memoryLimit: "256Mi"
        livenessProbePath: "/health"
        livenessProbeInitialDelaySeconds: 30
        livenessProbePeriodSeconds: 10
        readinessProbePath: "/health"
        readinessProbeInitialDelaySeconds: 30
        readinessProbePeriodSeconds: 10
        mountPath: "/var/lib/mysql"
        key: "mysql-init.sql"
        path: "/var/lib/mysql/mysql-init.sql"
        env: {
            name: "MYSQL_ROOT_PASSWORD"
            value: "password"
        }
        tolerations: {
            key: "app"
            operator: "Equal"
            value: "mysql"  
            effect: "NoSchedule"
        }
    }
}

mysql_service: resources.#CreateService & {
    params: {
        name: "mysql"
        namespace: "default"
        version: "v1.0.0"
        type: "ClusterIP"
        protocol: "TCP"
        portName: "mysql"
        port: 3306
        targetPort: 3306
    }
}

mysql_configMap: resources.#CreateConfigMap & {
    params: {
        name: "mysql"
        namespace: "default"
        version: "v1.0.0"
        data: {
            "mysql-init.sql": "CREATE DATABASE IF NOT EXISTS mydatabase;"
        }
    }
}   