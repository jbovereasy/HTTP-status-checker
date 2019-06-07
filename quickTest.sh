#! /bin/sh
# updated June 1
# Script is only tested for kibana-AROC SSL project

for i in $(cat ./io/input.txt); do
    foo1=$(curl -sI "{$i}" | grep HTTP/1.1 | awk '{print $2}');
    foo2=$(curl -sI "{$i}" | awk '/Location: / {print $2}'); 
    echo $i, $foo1, $foo2 #>> ./io/output.txt
done
