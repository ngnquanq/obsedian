## Continuous Integration vs Continuous Delivery
- CI/CD is not one thing
- Continuous Integration (CI):
	- Continously building, testing, and merging to master
- Continuous Delivery (CD):
	- Continuously deploying to a production-like environment

## Traditional development
- Developers work in long-lived development branches
- Branches are periodically merged into a release
- Builds are run periodically
- Developers continue to add to the development branch
![[Pasted image 20240316190707.png]]

## Continuos Integration
- Developers integrate code often (daily of possible)
- Developers work in short-lived feature branches
- Each check-in is verified by an automated build 

![[Pasted image 20240316190834.png]]

## Changes are kept small
- Working in small batches
- Committing regularly
- Using pull requests
- Commiting all changes daily

## CI automation 
- Build and test every pull request
- Use CI tools that monitor version control
- Tests should run after each build
- Never merge a pull request with failing tests

## Benefits of Continuous Integration

> The master branch should always be deployable

- Faster reaction times to changes
- Reduced code integration risk
- Higher code quality
- The code in version control works
- Master branch is always deployable