#!/bin/bash

kubectl exec -n vault vault-0 -- vault operator init \
    -key-shares=1 \
    -key-threshold=1 \
    -format=json > cluster-keys.json

sleep 10

VAULT_UNSEAL_KEY=$(cat cluster-keys.json | jq -r ".unseal_keys_b64[]")

kubectl exec -n vault vault-0 -- vault operator unseal $VAULT_UNSEAL_KEY

sleep 5

kubectl exec -n vault vault-0 -- vault status

CLUSTER_ROOT_TOKEN=$(cat cluster-keys.json | jq -r ".root_token")

kubectl exec -n vault vault-0 -- vault login $CLUSTER_ROOT_TOKEN

kubectl exec -n vault vault-0 -- vault operator raft list-peers

kubectl exec -n vault vault-1 -- vault operator raft join http://vault-0.vault-internal:8200

sleep 5

kubectl exec -n vault vault-1 -- vault operator unseal $VAULT_UNSEAL_KEY

kubectl exec -n vault vault-2 -- vault operator raft join http://vault-0.vault-internal:8200

sleep 5

kubectl exec -n vault vault-2 -- vault operator unseal $VAULT_UNSEAL_KEY

sleep 5

kubectl exec -n vault vault-0 -- vault operator raft list-peers
