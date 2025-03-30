package templates

import (
    "github.com/sfesfizh/cue-hw/types"
)

#CreateService: {
    params: {
        name: string & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$" @error("Name must be a valid Kubernetes resource name")
        namespace: *"default" | string
        version: string & =~"^v[0-9]+(.[0-9]+)*$"
        port: int & >=1 & <=65535
        targetPort: int & >=1 & <=65535
        protocol: *"TCP" | string & =~"^(TCP|UDP|SCTP)$"
        portName?: string
        type: *"ClusterIP" | string & =~"^(ClusterIP|NodePort|LoadBalancer|ExternalName)$"
        nodePort?: int & >=30000 & <=32767
        clusterIP?: string
        externalIPs?: [...string]
        sessionAffinity?: *"None" | string & =~"^(ClientIP|None)$"
        sessionAffinityTimeoutSeconds?: int & >=1 & <=86400
        loadBalancerIP?: string
        loadBalancerSourceRanges?: [...string]
        externalName?: string
        publishNotReadyAddresses?: *false | bool
        ipFamilyPolicy?: *"SingleStack" | string & =~"^(SingleStack|PreferDualStack|RequireDualStack)$"
        ipFamilies?: [...string & =~"^(IPv4|IPv6)$"]
    }

    service: types.#KubernetesService & {
        metadata: {
            name: params.name
            namespace: params.namespace
            labels: {
                app: params.name
                version: params.version
            }
        }
        spec: {
            selector: {
                app: params.name
            }
            ports: [{
                port: params.port
                targetPort: params.targetPort
                protocol: params.protocol
                if params.portName != _|_ {
                    name: params.portName
                }
                if params.nodePort != _|_ {
                    nodePort: params.nodePort
                }
            }]
            type: params.type
            if params.clusterIP != _|_ {
                clusterIP: params.clusterIP
            }
            if params.externalIPs != _|_ {
                externalIPs: params.externalIPs
            }
            if params.sessionAffinity != _|_ {
                sessionAffinity: params.sessionAffinity
                if params.sessionAffinityTimeoutSeconds != _|_ {
                    sessionAffinityConfig: {
                        clientIP: {
                            timeoutSeconds: params.sessionAffinityTimeoutSeconds
                        }
                    }
                }
            }
            if params.loadBalancerIP != _|_ {
                loadBalancerIP: params.loadBalancerIP
            }
            if params.loadBalancerSourceRanges != _|_ {
                loadBalancerSourceRanges: params.loadBalancerSourceRanges
            }
            if params.externalName != _|_ {
                externalName: params.externalName
            }
            if params.publishNotReadyAddresses != _|_ {
                publishNotReadyAddresses: params.publishNotReadyAddresses
            }
            if params.ipFamilyPolicy != _|_ {
                ipFamilyPolicy: params.ipFamilyPolicy
            }
            if params.ipFamilies != _|_ {
                ipFamilies: params.ipFamilies
            }
        }
    }
} 