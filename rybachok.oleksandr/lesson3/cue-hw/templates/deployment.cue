package templates

import (
    "github.com/sfesfizh/cue-hw/types"
)

#CreateDeployment: {
    params: {
        name: string & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$" @error("Name must be a valid Kubernetes resource name")
        namespace: *"default" | string
        version: string & =~"^v[0-9]+(.[0-9]+)*$"
        replicas: *2 | int & >=1 & <=10
        image: string & =~".+:.+" & !~".+:latest$"
        containerPort: int & >=1 & <=65535
        cpuRequest: *"100m" | string
        memoryRequest: *"128Mi" | string
        cpuLimit: *"200m" | string
        memoryLimit: *"256Mi" | string
        livenessProbePath: *"/health" | string
        livenessProbeInitialDelaySeconds: *30 | int & >=0
        livenessProbePeriodSeconds: *10 | int & >=0
        readinessProbePath: string & =~"^/.+"
        readinessProbeInitialDelaySeconds: int & >=0
        readinessProbePeriodSeconds: int & >=0
        mountPath: string & =~"^/.+"
        key: string & =~"^[a-zA-Z0-9_.-]+$"
        path: string & =~"^/.+"
        env: {
            name: string & =~"^[a-zA-Z0-9_]+$"
            value: string & =~"^[a-zA-Z0-9_]+$"
        }
        tolerations: {
            key: string & =~"^[a-zA-Z0-9_]+$"
            operator: string & =~"^(Equal|Exists)$"
            value: string & =~"^[a-zA-Z0-9_]+$"
            effect: string & =~"^(NoSchedule|NoExecute)$"
        }
    }

    deployment: types.#KubernetesDeployment & {
        metadata: {
            name: params.name
            namespace: params.namespace
            labels: {
                app: params.name
                version: params.version
            }
        }
        spec: {
            replicas: params.replicas
            selector: matchLabels: {
                app: params.name
            }
            template: {
                metadata: labels: {
                    app: params.name
                }
                spec: {
                    containers: [{
                        name:  params.name
                        image: params.image
                        ports: [{
                            containerPort: params.containerPort
                        }]
                        resources: {
                            requests: {
                                cpu: params.cpuRequest
                                memory: params.memoryRequest
                            }
                            limits: {
                                cpu: params.cpuLimit
                                memory: params.memoryLimit
                            }
                        }
                        env: [{
                            name: params.env.name
                            value: params.env.value
                        }]
                        livenessProbe: {
                            httpGet: {
                                path: params.livenessProbePath
                                port: params.containerPort
                            }
                            initialDelaySeconds: params.livenessProbeInitialDelaySeconds
                            periodSeconds: params.livenessProbePeriodSeconds
                        }
                        readinessProbe: {
                            httpGet: {
                                path: params.readinessProbePath
                                port: params.containerPort
                            }
                            initialDelaySeconds: params.readinessProbeInitialDelaySeconds
                            periodSeconds: params.readinessProbePeriodSeconds
                        }
                        volumeMounts: [{
                            name: params.name
                            mountPath: params.mountPath
                        }]
                    }]
                    volumes: [{
                        name: params.name
                        configMap: {
                            name: params.name
                            items: [{
                                key: params.key
                                path: params.path
                            }]
                        }
                    }]
                    tolerations: [{
                        key: params.tolerations.key
                        operator: params.tolerations.operator
                        value: params.tolerations.value
                        effect: params.tolerations.effect
                    }]
                }
            }
        }
    }
}
