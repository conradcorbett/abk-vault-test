### Create Vault namespace

```shell
kubectl create namespace vault
```
### Deploy using helm

```shell
helm install vault hashicorp/vault --namespace vault -f helm-values.yaml
```

### Initialize Vault

```shell
Follow steps in vaultinit.sh
```

### Get UI URL

```shell
kubectl get svc -n vault
```

### Connect to Vault UI: http://vault-ui-external-ip:8200