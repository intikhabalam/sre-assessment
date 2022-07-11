#!/bin/bash

rgName=clearpointresgrpiac
saName=tfstate
containerName=tf

# Create resource group
az group create --name $rgName --location eastus

# Create storage account
az storage account create --resource-group $rgName --name $saName --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $containerName --account-name $saName