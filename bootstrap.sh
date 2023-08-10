kubectl apply -f bootstrap/flux-system/gotk-components.yaml 
kubectl create secret generic flux-system -n flux-system\
    --from-literal=username=${GITHUB_USER} \
    --from-literal=password=${GITHUB_TOKEN}
result=`kubectl api-resources --verbs=list | grep  source.toolkit.fluxcd.io/v1`
echo "result=${result}"
while [ -z "$result" ]
do
  sleep 1
  result=`kubectl api-resources --verbs=list | grep  source.toolkit.fluxcd.io/v1`
  echo "result=${result}"
done

kubectl apply -f bootstrap/flux-system/gotk-sync.yaml
