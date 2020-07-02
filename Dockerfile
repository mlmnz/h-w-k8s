FROM  python:3.8.3-alpine3.11

#Copy source and requirements files
WORKDIR /usr/src/app

# Copy firts and install dependecies for image cache
COPY myApp/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

#Copy app and test file
COPY myApp/myApp.py myApp/test_myApp.py ./

# Expose the http port
EXPOSE 80
CMD [ "python", "./myApp.py" ]