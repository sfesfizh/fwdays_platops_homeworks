package types

#KubernetesConfigMap: {
    apiVersion: "v1"
    kind:       "ConfigMap"
    metadata: {
        name:      string
        namespace: string | *"default"
        labels: {
            app:     string
            version: string & =~"^v[0-9]+(.[0-9]+)*$"
        }
    }
    data: {
        [string]: string
    }
    binaryData?: {
        [string]: string
    }
    immutable?: bool
} 