<pre><font color="#8AE234">orybachok</font>@maximus-pc-linux <font color="#4E9A06">~/D/C/P/H/cue-hw</font>&gt; <font color="#005FD7">cue</font> <font color="#00AFFF">export</font> <font color="#00AFFF"><u style="text-decoration-style:solid">main-dp.cue</u></font> <font color="#00AFFF">--out</font> <font color="#00AFFF">yaml</font>
nginx_deployment:
  params:
    name: nginx
    namespace: default
    version: v1.0.0
    replicas: 3
    image: nginx:1.14.2
    containerPort: 80
    cpuRequest: 100m
    memoryRequest: 128Mi
    cpuLimit: 200m
    memoryLimit: 256Mi
    livenessProbePath: /health
    livenessProbeInitialDelaySeconds: 30
    livenessProbePeriodSeconds: 10
    readinessProbePath: /health
    readinessProbeInitialDelaySeconds: 30
    readinessProbePeriodSeconds: 10
    mountPath: /usr/share/nginx/html
    key: index.html
    path: /usr/share/nginx/html/index.html
    env:
      name: APP_ENV
      value: production
    tolerations:
      key: app
      operator: Equal
      value: nginx
      effect: NoSchedule
  deployment:
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nginx
      namespace: default
      labels:
        app: nginx
        version: v1.0.0
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: nginx
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
            - name: nginx
              image: nginx:1.14.2
              ports:
                - containerPort: 80
              resources:
                requests:
                  cpu: 100m
                  memory: 128Mi
                limits:
                  cpu: 200m
                  memory: 256Mi
              env:
                - name: APP_ENV
                  value: production
              livenessProbe:
                httpGet:
                  path: /health
                  port: 80
                initialDelaySeconds: 30
                periodSeconds: 10
              readinessProbe:
                httpGet:
                  path: /health
                  port: 80
                initialDelaySeconds: 30
                periodSeconds: 10
              volumeMounts:
                - name: nginx
                  mountPath: /usr/share/nginx/html
          volumes:
            - name: nginx
              configMap:
                name: nginx
                items:
                  - key: index.html
                    path: /usr/share/nginx/html/index.html
          tolerations:
            - key: app
              operator: Equal
              value: nginx
              effect: NoSchedule
nginx_service:
  params:
    name: nginx
    namespace: default
    version: v1.0.0
    port: 80
    targetPort: 80
    protocol: TCP
    portName: http
    type: ClusterIP
  service:
    apiVersion: v1
    kind: Service
    metadata:
      name: nginx
      namespace: default
      labels:
        app: nginx
        version: v1.0.0
    spec:
      selector:
        app: nginx
      ports:
        - port: 80
          targetPort: 80
          protocol: TCP
          name: http
      type: ClusterIP
nginx_configMap:
  params:
    name: nginx
    namespace: default
    version: v1.0.0
    data:
      index.html: Hello, World!
  configMap:
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: nginx
      namespace: default
      labels:
        app: nginx
        version: v1.0.0
    data:
      index.html: Hello, World!
mysql_deployment:
  params:
    name: mysql
    namespace: default
    version: v1.0.0
    replicas: 1
    image: mysql:8.0
    containerPort: 3306
    cpuRequest: 100m
    memoryRequest: 128Mi
    cpuLimit: 200m
    memoryLimit: 256Mi
    livenessProbePath: /health
    livenessProbeInitialDelaySeconds: 30
    livenessProbePeriodSeconds: 10
    readinessProbePath: /health
    readinessProbeInitialDelaySeconds: 30
    readinessProbePeriodSeconds: 10
    mountPath: /var/lib/mysql
    key: mysql-init.sql
    path: /var/lib/mysql/mysql-init.sql
    env:
      name: MYSQL_ROOT_PASSWORD
      value: password
    tolerations:
      key: app
      operator: Equal
      value: mysql
      effect: NoSchedule
  deployment:
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: mysql
      namespace: default
      labels:
        app: mysql
        version: v1.0.0
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: mysql
      template:
        metadata:
          labels:
            app: mysql
        spec:
          containers:
            - name: mysql
              image: mysql:8.0
              ports:
                - containerPort: 3306
              resources:
                requests:
                  cpu: 100m
                  memory: 128Mi
                limits:
                  cpu: 200m
                  memory: 256Mi
              env:
                - name: MYSQL_ROOT_PASSWORD
                  value: password
              livenessProbe:
                httpGet:
                  path: /health
                  port: 3306
                initialDelaySeconds: 30
                periodSeconds: 10
              readinessProbe:
                httpGet:
                  path: /health
                  port: 3306
                initialDelaySeconds: 30
                periodSeconds: 10
              volumeMounts:
                - name: mysql
                  mountPath: /var/lib/mysql
          volumes:
            - name: mysql
              configMap:
                name: mysql
                items:
                  - key: mysql-init.sql
                    path: /var/lib/mysql/mysql-init.sql
          tolerations:
            - key: app
              operator: Equal
              value: mysql
              effect: NoSchedule
mysql_service:
  params:
    name: mysql
    namespace: default
    version: v1.0.0
    port: 3306
    targetPort: 3306
    protocol: TCP
    portName: mysql
    type: ClusterIP
  service:
    apiVersion: v1
    kind: Service
    metadata:
      name: mysql
      namespace: default
      labels:
        app: mysql
        version: v1.0.0
    spec:
      selector:
        app: mysql
      ports:
        - port: 3306
          targetPort: 3306
          protocol: TCP
          name: mysql
      type: ClusterIP
mysql_configMap:
  params:
    name: mysql
    namespace: default
    version: v1.0.0
    data:
      mysql-init.sql: CREATE DATABASE IF NOT EXISTS mydatabase;
  configMap:
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: mysql
      namespace: default
      labels:
        app: mysql
        version: v1.0.0
    data:
      mysql-init.sql: CREATE DATABASE IF NOT EXISTS mydatabase;</pre>