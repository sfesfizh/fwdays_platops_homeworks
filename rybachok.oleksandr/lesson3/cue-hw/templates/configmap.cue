package templates

import (
    "github.com/sfesfizh/cue-hw/types"
)

#CreateConfigMap: {
    params: {
        name: string & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$" @error("Name must be a valid Kubernetes resource name")
        namespace: *"default" | string
        version: string & =~"^v[0-9]+(.[0-9]+)*$"
        data: {
            [string]: string
        }
        binaryData?: {
            [string]: string
        }
        immutable?: *false | bool
    }

    configMap: types.#KubernetesConfigMap & {
        metadata: {
            name: params.name
            namespace: params.namespace
            labels: {
                app: params.name
                version: params.version
            }
        }
        data: params.data
        if params.binaryData != _|_ {
            binaryData: params.binaryData
        }
        if params.immutable != _|_ {
            immutable: params.immutable
        }
    }
} 