### Create Vault namespace

```shell
kubectl create namespace vault
```
### If deploying Vault Enterprise and GCP Auto Unseal
Create a credentials.json file with your GCP credentials, then load it as a k8s secret
```shell
kubectl create -n vault secret generic kms-creds --from-file=credentials.json
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

### Connect to Vault UI: http://<vault-ui-external-ip>:8200
