FROM python:3.6

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN /usr/local/bin/python -m pip install --upgrade --force-reinstall pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
# RUN python -c "import nltk; nltk.download('punkt')"

CMD [ "python", "/usr/src/app/app_cpu.py" ]
