# n2n-supernode
n2n supernode

**使用**
```
docker pull ghostry/n2n-supernode:2
docker rm -f supernode
docker run --restart always --name supernode -d -p 7654:7654/udp ghostry/n2n-supernode:2
```
