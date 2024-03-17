- Described an executable texttual format (code)
- Configure using that description
- Configuration Management Systems make this possible
- Never perform configurations manually
- Use version control to store all the changed in history

## Ephemeral immutable infrastructure
- Server drift is a major source of failure
- Servers are cattle not pets (one of them not working, you replace them)
- Infrastructure is transient (if you need it, you build it, otherwise, kill it)
- Build through parallel infrastructure (i.e you create the same server as the one on the production and test new feature on it, if it work, you shut down the one on the production, replace with this new server).

## Immutable delivery via containers (such as docker)
- Aplications are packaged in containers
- Same container that runs in production can be run locally
- Dependencies are contained
- No variance limits side-effects
- Rolling updates with immediate roll-back
=> Things wen wrong, shut down the container, build a new one

## Immutable way of working
- You never makes changes to a running container
- You make **changes to the image**
- Then redeploy a new container
- Keep images up-to-date

