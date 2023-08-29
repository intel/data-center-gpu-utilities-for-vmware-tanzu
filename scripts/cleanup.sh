#!/bin/bash

echo "deleting (possible) kmm kernel pods"

for pod in $(kubectl get pods -n kmm-operator-system --no-headers -o custom-columns=":metadata.name");
do
    kubectl patch pod -n kmm-operator-system "$pod" -p '{"metadata":{"finalizers":null}}' --type=merge
done

kubectl delete crds \
    clusterissuers.cert-manager.io \
    certificaterequests.cert-manager.io \
    certificates.cert-manager.io \
    challenges.acme.cert-manager.io \
    issuers.cert-manager.io \
    orders.acme.cert-manager.io \
    modules.kmm.sigs.x-k8s.io \
    preflightvalidations.kmm.sigs.x-k8s.io \
    acceleratorfunctions.fpga.intel.com \
    dlbdeviceplugins.deviceplugin.intel.com \
    dsadeviceplugins.deviceplugin.intel.com \
    fpgadeviceplugins.deviceplugin.intel.com \
    fpgaregions.fpga.intel.com \
    iaadeviceplugins.deviceplugin.intel.com \
    qatdeviceplugins.deviceplugin.intel.com \
    sgxdeviceplugins.deviceplugin.intel.com \
    gpudeviceplugins.deviceplugin.intel.com \
    nodefeaturerules.nfd.k8s-sigs.io \
    nodefeatures.nfd.k8s-sigs.io

kubectl delete namespace \
    cert-manager \
    kmm-operator-system
