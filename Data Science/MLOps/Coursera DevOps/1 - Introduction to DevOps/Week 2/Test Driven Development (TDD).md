> Writing test cases is critical to proving that your code works as intended

## What is test driven development?
- Test cases drive the design
-  You write the tests first then you write the code to make the test pass
- This keeps you focused on the purpose of the code
- Code is of no use if your client can't call it
=> TDD gives you the caller's perspective 

## Why developers don't test
- I already know my code works!
- **Test cases give you a baseline so that other people know that the code is still working**.
- I don't write broken code. 
- I have no time. 

## Basic TDD workflow
1. Write a test case that fails (RED)
2. Write code to make it pass (GREEN)
3. Improve code quality (REFACTOR) and get back to step 1
=> This is also known as RED, GREEN, REFACTOR

## Why is TDD important for DevOps?
- It saves time when developing
- Allow you to code faster and with more confidence
- It ensures the code is working as expected
- It ensures that future changes dont break your code
- In order to create a DevOps CI/CD pipeline, all testing must be automated (unless you want to push your bug onto production faster.)

