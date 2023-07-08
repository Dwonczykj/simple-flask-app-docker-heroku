#Create a ubuntu base image with python 3 installed.
FROM python:3.9 as build

#Set the working directory
WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

#copy all the files
COPY . .

# #Install the dependencies
# RUN apt-get -y update
# RUN apt-get update && apt-get install -y python3 python3-pip
# RUN pip3 install -r requirements.txt

#Run the command
# CMD gunicorn main:app

CMD gunicorn my_distinct_package_name.app:app -b 0.0.0.0:$PORT