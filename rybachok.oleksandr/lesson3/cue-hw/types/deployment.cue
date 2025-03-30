package types

#KubernetesDeployment: {
    apiVersion: "apps/v1"
    kind:       "Deployment"
    metadata: {
        name:      string
        namespace: string | *"default"
         labels: {
            app:     string
            version: string & =~"^v[0-9]+(.[0-9]+)*$"
        }
    }
    spec: {
        replicas: int & >=1 & <=10
        selector: matchLabels: {
            app: string
        }
        template: {
            metadata: labels: {
                app: string
            }
            spec: {
                containers?: [...{
                    name:  string
                    image: string
                    ports?: [...{
                        containerPort: int & >=1 & <=65535
                    }]
                    resources: {
                        requests: {
                            cpu: string
                            memory: string
                        }
                        limits: {
                            cpu: string
                            memory: string
                        }
                    }
                    env?: [...{
                        name: string
                        value: string
                    }]
                    livenessProbe: {
                        httpGet: {
                            path: string
                            port: int & >=1 & <=65535
                        }
                        initialDelaySeconds: int & >=0  
                        periodSeconds: int & >=0      
                    }
                    readinessProbe: {
                        httpGet: {
                            path: string
                            port: int & >=1 & <=65535
                        }   
                        initialDelaySeconds: int & >=0
                        periodSeconds: int & >=0
                    }
                    volumeMounts?: [...{
                        name: string
                        mountPath: string
                    }]
                }]
                volumes?: [...{
                    name: string
                    configMap: {
                        name: string
                        items?: [...{
                            key: string
                            path: string
                        }]
                    }
                }]
                tolerations?: [...{
                    key: string
                    operator: string
                    value: string
                    effect: string
                }]
            }
        }
    }
}