## Readiness Probe and Liveness Probe
Probe=thăm dò
- **Readiness Probes**: tell K8s **when a container is ready to serve request**. If it failed (not ready to serve request), it will remove that pod from service Load-Balancing.
- **Liveness Probes**: tell K8s **whether the process inside is still healthy** and repeated failures trigger the kubelet to kill and restart the container.
- **Startup Probes**: new thing in v1.16, which guards slow-boot applications by deplaying the other two until the process has fully initialised. 

### Readiness probe
Answer the question: "**Can I accept traffic now?**", typically use include:
1. Wait for web server to finish loading configuration or data files. 
2. Deferring traffic until a database connection pool is established. 
3. v.v...