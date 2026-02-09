#!/bin/bash

RESOURCE_GROUP_NAME=terraform-state-rg-cicd
STAGE_SA_ACCOUNT=tftestbackend2025sd
DEV_SA_ACCOUNT=tfdevbackend2025sd
PROD_SA_ACCOUNT=tfprobackend2025sd
CONTAINER_NAME=tfstateme

# Create Resource Group
az group create --name $RESOURCE_GROUP_NAME --location centralindia

# Create Storage Accounts
az storage account create --name $STAGE_SA_ACCOUNT --resource-group $RESOURCE_GROUP_NAME
az storage account create --name $DEV_SA_ACCOUNT --resource-group $RESOURCE_GROUP_NAME
az storage account create --name $PROD_SA_ACCOUNT --resource-group $RESOURCE_GROUP_NAME

# Create Blob Containers
az storage container create --name $CONTAINER_NAME --account-name $STAGE_SA_ACCOUNT
az storage container create --name $CONTAINER_NAME --account-name $DEV_SA_ACCOUNT
az storage container create --name $CONTAINER_NAME --account-name $PROD_SA_ACCOUNT

