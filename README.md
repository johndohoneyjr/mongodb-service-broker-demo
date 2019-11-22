# AWS MongoDB-Kubernetes Operator Example


This demo uses the MongoDb - Kubernetes Service Broker on AWS.  The cluster is provisioned with EKSCTL

  - Makes use of a MongDB Atlas Cluster
  - Uses a single ReplicaSet for access in the cloud from the cluster -- in a cloud or on-prem


# Be sure to install svcat 

  - Be sure to have a valid Kubernetes configuration, or this command will complain

  ## Mac OSX
  ```
    brew update
    brew install kubernetes-service-catalog-client
    svcat version --client
  ```

  ## Linux
  ```
    curl -sLO https://download.svcat.sh/cli/latest/linux/amd64/svcat
    chmod +x ./svcat
    mv ./svcat /usr/local/bin/
    svcat version --client
  ```

  ## Windows
  ```
    iwr 'https://download.svcat.sh/cli/latest/windows/amd64/svcat.exe' -UseBasicParsing -OutFile svcat.exe
    mkdir -f ~\bin
    Move-Item -Path svcat.exe  -Destination ~\bin
    $env:PATH += ";${pwd}\bin"
    svcat version --client
  ```

### Demo Process:
  - Make sure your AWS Key and secret are in your ~/.aws/credentials
  - The shell scripts are sequentially prefixed, runs this in prefix - sequential order.
  - Be sure to get all external IP's -- you need to Whitelist all of them in order for this to work without hiccups.  

  ```
    kubectl get nodes -o jsonpath='{ $.items[*].status.addresses[?(@.type=="ExternalIP")].address }'

  ```

### Notes

As you create you Kubernetes secret, secret.yaml, you will need the values of:
  - Project ID
  - API Key - Public Key @ The value of your Atlas Project ID
  - API Key - Private Key

FORMAT of ATLAS DATA
```
stringData:
  username: public-key:Project-ID
  password: Private-Key
```

example:
```
apiVersion: v1
kind: Secret
metadata:
  name: atlas-service-broker-auth
type: Opaque
stringData:
  username: fdeadoen@5d656831deadf5af4b
  password: d7ef8f25-ac12-4da8-dead-93dead39934b
```
CAUTION:
  ## Do Not use a hyphen in a username.  For some reason, this is not permitted, but not noted in any of the documentation
