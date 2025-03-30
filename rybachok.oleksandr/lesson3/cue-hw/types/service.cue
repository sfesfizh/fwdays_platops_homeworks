package types

#KubernetesService: {
    apiVersion: "v1"
    kind:       "Service"
    metadata: {
        name:      string
        namespace: string | *"default"
        labels: {
            app:     string
            version: string & =~"^v[0-9]+(.[0-9]+)*$"
        }
    }
    spec: {
        selector: {
            app: string
        }
        ports: [...{
            port: int & >=1 & <=65535
            targetPort: int & >=1 & <=65535
            protocol: string & =~"^(TCP|UDP|SCTP)$"
            name?: string
            nodePort?: int & >=30000 & <=32767
        }]
        type: string & =~"^(ClusterIP|NodePort|LoadBalancer|ExternalName)$"
        clusterIP?: string
        externalIPs?: [...string]
        sessionAffinity?: string & =~"^(ClientIP|None)$"
        sessionAffinityConfig?: {
            clientIP: {
                timeoutSeconds: int & >=1 & <=86400
            }
        }
        loadBalancerIP?: string
        loadBalancerSourceRanges?: [...string]
        externalName?: string
        publishNotReadyAddresses?: bool
        ipFamilyPolicy?: string & =~"^(SingleStack|PreferDualStack|RequireDualStack)$"
        ipFamilies?: [...string & =~"^(IPv4|IPv6)$"]
    }
} 