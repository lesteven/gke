
ip=$(kubectl get svc | grep nutriservice | awk '{print $4}')

curl "$ip"/elastic \
    -H 'Content-Type: application/json' \
    -d '{"search": "mochi"}' \
    -v
