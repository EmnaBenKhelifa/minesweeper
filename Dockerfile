FROM python:3.10.12-slim 

# Create a working directory
WORKDIR /webapp

# Copy reqs.txt
COPY requirements.txt .
# Install python dependencies
RUN pip install -r requirements.txt

# Copy app files
COPY app app
COPY src src 
# CMD
CMD python app/app.py 












