FROM python:3

WORKDIR /tmp/

COPY requirements.txt ./
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "python", "./001.py" ]
