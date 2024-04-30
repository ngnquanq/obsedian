
1. When having a piece of text that allow the user to type in their input, instead of `docker run <container>`, we must use this instead:

```cmd
docker run -i -t <image_name>
```

Where:
- `-i`: is for **interactive**
- `-t`: is for **pseudo terminal** 
