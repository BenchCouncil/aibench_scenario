FROM python:3.6

WORKDIR /usr/src/app

COPY requirements.txt ./
# RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
RUN python -c "import nltk; nltk.download('punkt')"

CMD [ "python", "/usr/src/app/cpu_app.py" ]
