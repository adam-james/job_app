#!/usr/bin/env bash

source ./bin/env.sh

echo Creating a resource group...
az group create --name $GROUP --location $LOCATION

echo Creating a Redis cache...
az redis create --name $CACHE --resource-group $GROUP --location $LOCATION \
  --sku Basic --vm-size C0
