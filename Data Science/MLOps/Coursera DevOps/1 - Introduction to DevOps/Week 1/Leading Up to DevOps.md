## Traditional Waterfall development
- Architects worked for months designning the system
- Development worked for months on features
- Testing opened defects and sent the code back to development
- At some point, the code is released to operations
- The operations team took forever to deploy

We call it traditional waterfall development because:
- Requirements
	- Design
		- Code
			- Integration
				- Test
					- Deploy

We call it waterfall because it's very hard to go back. **Problems with waterfall approach is:**
- No provisions for changing requirements
- No idea if it works until the end
- Each step ends when the next begins
- Mistakes found in the later stages are more expensive to fix
- Teams work separately, unaware of their impact on each other
- People who know the least about the code are deploying it into production (the operations)