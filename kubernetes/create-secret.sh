#!/bin/bash

kubectl create secret generic dotenv \
  --from-literal=app-newrelic-license-key="" \
  --namespace=newrelic-gin-sample
