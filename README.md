## Deploy Vault Enterprise to Kubernetes Cluster
### Create Vault namespace
```shell
kubectl create namespace vault
```

### Create secret for license
```shell
kubectl -n vault create secret generic vault-ent-license --from-literal="license=02MV..."
```

### GCP Auto Unseal
Get credentials.json file from GCP, then load it as a k8s secret.
#### Helpful links: 
https://support.hashicorp.com/hc/en-us/articles/5277291261075-Auto-unseal-using-GCP-Cloud-KMS
https://gist.github.com/sdeoras/96e78780561b1e941e8d5c4d3a78b7e9
```shell
kubectl create -n vault secret generic kms-creds --from-file=credentials.json
```

### Deploy Vault using helm

```shell
helm install vault hashicorp/vault --namespace vault -f helm-values-ent.yaml
```

### Initialize Vault

```shell
./vaultinit.sh
```

### Get UI URL

```shell
kubectl get svc -n vault
```
Connect to Vault UI at: `http://<vault-ui-external-ip>:8200`

## Delete Vault Cluster
```shell
helm delete vault --namespace vault
kubectl delete namespace vault
```