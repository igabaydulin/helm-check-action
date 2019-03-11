# Description [![Version](https://img.shields.io/badge/version-0.1.4-color.svg)](https://github.com/igabaydulin/helm-check-action/releases/tag/0.1.4)

helm-check is a [github action](https://github.com/features/actions) tool which allows to prevalidate helm chart
template before its deployment; executes [helm lint](https://helm.sh/docs/helm/#helm-lint) and [helm template](https://helm.sh/docs/helm/#helm-template)
commands

## Table of Contents
* [Components](#components)
* [Environment Variables](#environment-variables)
* [Sample](#sample)
* [Output Example](#output-example)
* [Testing](#testing)

## Components
* `Dockerfile`: contains docker image configuration
* `entrypoint.sh`: contains executable script for helm templates validation

## Environment variables
* `CHART_LOCATION`: chart folder; required field for `helm lint` and `helm template` executions
* `CHART_VALUES`: custom values file for specific kubernetes environment; required field for `helm template` execution

## Sample
[helm-check-action-sample](https://github.com/igabaydulin/helm-check-action-sample) is a sample which uses this action
in its workflow

## Output example
[Output](https://github.com/igabaydulin/helm-check-action-sample/runs/75704141) example in [helm-check-action-sample](https://github.com/igabaydulin/helm-check-action-sample):
```
----------------------------------------------------------------------

Helm-Check v0.1.0
Source code: https://github.com/igabaydulin/helm-check-action

----------------------------------------------------------------------




1. Checking a chart for possible issues

helm lint ./helm-check-action-sample
----------------------------------------
==> Linting ./helm-check-action-sample
[INFO] Chart.yaml: icon is recommended

1 chart(s) linted, no failures
----------------------------------------
Result: SUCCESS


------------------------------------------------------------------------------------------


2. Trying to render templates with provided values

helm template --values ./helm-check-action-sample/values/test.yaml ./helm-check-action-sample
----------------------------------------
---
# Source: helm-check-action-sample/templates/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: release-name-helm-check-action-sample
  labels:
    app: helm-check-action-sample
    chart: helm-check-action-sample-0.1.0
    release: release-name
    heritage: Tiller
spec:
  type: ClusterIP
  ports:
    - port: 80
      targetPort: 80
      protocol: TCP
      name: nginx
  selector:
    app: helm-check-action-sample
    release: release-name

---
# Source: helm-check-action-sample/templates/deployment.yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: release-name-helm-check-action-sample
  labels:
    app: helm-check-action-sample
    chart: helm-check-action-sample-0.1.0
    release: release-name
    heritage: Tiller
spec:
  replicas: 2
  template:
    metadata:
      labels:
        app: helm-check-action-sample
        release: release-name
    spec:
      containers:
        - name: helm-check-action-sample
          image: "nginx:stable"
          imagePullPolicy: IfNotPresent
          ports:
            - containerPort: 80
          livenessProbe:
            httpGet:
              path: /
              port: 80
          readinessProbe:
            httpGet:
              path: /
              port: 80
          resources:
            {}
            

---
# Source: helm-check-action-sample/templates/ingress.yaml

----------------------------------------
Result: SUCCESS


------------------------------------------------------------------------------------------


3. Summary

Examination is completed; no errors found!

### SUCCEEDED helm-check 22:36:42Z (10.512s)
```

## Testing
You can test script locally, but make sure you have all needed tools (helm at least); next steps describe how 
to test action on Linux system:

1. Clone action repository
1. Make sure entrypoint.sh is executable, otherwise execute next command in terminal:

    ```
    igabaydulin@localhost:~/dev/helm-check-action$ chmod +x ./entrypoint.sh
    ```
1. Move to your repository and execute next command in terminal:

    ```
    igabaydulin@localhost:~/dev/my-local-repository$ CHART_LOCATION=/path/to/chart CHART_VALUES=/path/to/values/values.yaml /path/to/entrypoint.sh
    ```

