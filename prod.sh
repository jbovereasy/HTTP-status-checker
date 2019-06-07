#! /bin/sh
# updated June 5
# Script is only tested for kibana-AROC SSL project

echo site, httpcode, status, server-side-redirect, client-side-redirect, 200-landing-page >> ./io/output.csv
for i in $(cat ./io/input.txt); do
    httpcode=$(curl -sI  -k "{$i}" | grep HTTP/1.1 | awk '{print $2}'); #200, 301, 302, 400
    redirectUrl=$(curl -sI -k "{$i}" | awk '/Location: / {print $2}'); #Server side redirect
    clientRedirect=$(curl -s -k "{$i}" | awk '/http-equiv="refresh/ {print $4}'); #Client side redirect
    notAvail=$(curl -s -k "{$i}" | awk '/This web site is currently not avail/ {print $6 $7}') #200 - but site is not available
    # echo $clientRedirect

    if [[ $httpcode == 200 ]]; 
    then
        echo "$i, $httpcode, OK, , $clientRedirect, $notAvail"
    elif [[ $httpcode == 301 ]]; 
    then
        echo "$i, $httpcode, Found, $redirectUrl"
    elif [[ $httpcode == 302 ]]; 
    then
        echo "$i, $httpcode, Found, $redirectUrl"
    elif [[ $httpcode == 403 ]]; 
    then
        echo "$i, $httpcode, Forbidden, ,"
    elif [[ $httpcode == 404 ]]; 
    then
        echo "$i, $httpcode, NotFound, ,"   
    else
        echo "$i, $httpcode"
    fi >> ./io/output.csv
done

