#! /usr/bin/env bash

kubectl delete servicebindings jdohoney -n atlas 

svcat describe instance jdohoney -n atlas 
